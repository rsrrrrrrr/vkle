(in-package :vkle)


#|
(defun main(&key (delay 2000))
  (sdl2:with-init (:video)
    (sdl2:with-window (window :title "SDL2 Window" :w *screen-width* :h *screen-height* :flags '(:shown :vulkan))
      (let ((screen-surface (sdl2:get-window-surface window)))
        (sdl2:fill-rect screen-surface
                        nil
                        (sdl2:map-rgb (sdl2:surface-format screen-surface) 255 255 255))
        (sdl2:update-window window)
        (sdl2:delay delay)))))
|#

(defparameter *info* '())
;; :instance = instance
;; :gpus = all physical devices
;; :gpu = physical device
;; :gpu-props = physical device properties for :gpu
;; :gpu-features = physical device features for :gpu
;; :memory-properties = physical device memory properties for :gpu
;; :queue-props = queue-family properties for :gpu
;; :queue-family-index = list of queue families to create on device
;; :queue-priorities = list of list of priorities for corresponding queue family
;; :queue-families = which queue families to use for various queues
;; :graphics-queue = queue that supports graphics
;; :transfer-queue = queue that supports transfer
;; :present-queue = queue that supports present
;;  - all 3 queues may be same queue
;; :window = 'window' object from glop or sdl or whatever
;; :surface = surface used for drawing to screen

(defmacro info (property &rest properties-or-indices)
  (let ((f `(getf *info* ,property)))
    (loop for p in properties-or-indices
          do (if (numberp p)
                 (setf f `(elt ,f ,p))
                 (setf f `(getf ,f ,p))))
    f))

(defparameter *validation-layers*
  (loop for l in '("VK_LAYER_LUNARG_threading"
                   "VK_LAYER_LUNARG_param_checker"
                   "VK_LAYER_LUNARG_device_limits"
                   "VK_LAYER_LUNARG_object_tracker"
                   "VK_LAYER_LUNARG_image"
                   "VK_LAYER_LUNARG_mem_tracker"
                   "VK_LAYER_LUNARG_draw_state"
                   "VK_LAYER_LUNARG_swapchain"
                   "VK_LAYER_GOOGLE_unique_objects")
        collect (list l :optional t)))

(defparameter *instance-layer-names*
  ;; load a bunch of validation layers if available (for example from
  ;; the SDK)
  `(,@*validation-layers*
    ;; dump all API calls and parameters to stdout
    ("VK_LAYER_LUNARG_api_dump" :optional t)))

(defparameter *instance-extension-names* nil)

;; most of the validation layers need to be activated on the device as well
(defparameter *device-layer-names* *validation-layers*)

(defparameter *device-extension-names*
  ;; to actually display anything with vulkan, we need a "swap chain",
  ;; which handles things like vsync, double buffering, etc. so we will
  ;; load the device extension for that.
  '(:khr-swapchain))


(defmacro with-sample-instance ((instance
                                 &key (exts '*instance-extension-names*)
                                   (layers '*instance-layer-names*)
                                   (app "cl-vulkan test")
                                   (app-version 0)
                                   (engine "cl-vulkan")
                                   (engine-version 0))
                                &body body)
  `(vk:with-instance (,instance
                      :exts ,exts
                      :layers ,layers
                      :app ,app
                      :app-version ,app-version
                      :engine ,engine
                      :engine-version ,engine-version)
     (let ((*info* `(:instance ,,instance)))
       ;; install a debug report handler if possible, so we see
       ;; validation messages/errors
       (vk:with-debug-report (,instance)
         ,@body))))

(defun init-enumerate-device ()
  (setf (info :gpus) (vk:enumerate-physical-devices (info :instance)))
  (assert (plusp (length (info :gpus))))
  (setf (info :gpu) (info :gpus 0))
  (setf (info :queue-props)
        (vk:get-physical-device-queue-family-properties (info :gpu)))
  (assert (plusp (length (info :queue-props))))
  ;; save some info about the device for later use
  (setf (info :memory-properties)
        (vk:get-physical-device-memory-properties (info :gpu)))
  (setf (info :gpu-props)
        (vk:get-physical-device-properties (info :gpu)))
  (setf (info :gpu-features)
        (vk:get-physical-device-features (info :gpu))))

;; for debugging, make sure it still works if we got more queues than
;; the minimum required by the device/driver, since some devices have
;; 1 and others have many
(defparameter *split-queues* t)
(defparameter *queue-priorities* '(:present 1.0 :graphics 0.5 :transfer 0.0))

(defun select-queue-families (surface)
  (loop for queue in (info :queue-props)
        for i from 0
        for flags = (getf queue :queue-flags)
        when (member :graphics flags)
          collect i into graphics
        when (member :transfer flags)
          collect i into transfer
        when (vk:get-physical-device-surface-support-khr (info :gpu) i surface)
          collect i into present
        finally
           (let* ((gp (list (car (intersection graphics present))))
                  (all (car (intersection gp transfer))))
             (cond
               ((and all (not *split-queues*))
                (setf (info :queue-families)
                      (list :present (list all 0)
                            :graphics (list all 0)
                            :transfer (list all 0)))
                (setf (info :queue-family-index) (list all))
                (setf (info :queue-priorities) '((0.0))))
               ((and gp transfer (not *split-queues*))
                (setf (info :queue-families)
                      (list :present (list gp 0)
                            :graphics (list gp 1)
                            :transfer (list (car transfer) 0)))
                (setf (info :queue-family-index) (list gp (car transfer)))
                (setf (info :queue-priorities)
                      (list (list (getf *queue-priorities* :present)
                                  (getf *queue-priorities* :graphics))
                            (list (getf *queue-priorities* :transfer)))))
               ((and graphics transfer present)
                (setf (info :queue-families)
                      (list  :present (list (car present) 0)
                             :graphics (list (car graphics) 0)
                             :transfer (list (car transfer) 0)))
                (setf (info :queue-family-index) (list (car present)
                                                       (car graphics)
                                                       (car transfer)))
                (setf (info :queue-priorities)
                      (list (list (getf *queue-priorities* :present))
                            (list (getf *queue-priorities* :graphics))
                            (list (getf *queue-priorities* :transfer)))))
               (t (error "couldn't find graphics, present, and transfer queues?"))))))




(defmacro with-sample-device ((var) &body body)
  ;; create a device, specifying the layers and extensions we want,
  ;; and the selected queue

  ;; WITH-DEVICE handles all the vk*Info structs we just pass in the
  ;; details
  `(progn
     (init-enumerate-device)
     (select-queue-families (info :surface))
     (vk:with-device (,var (info :gpu)
                     ;; Specify which queue families we want to use.
                     ;; If using multiple families, specify a list of
                     ;; indices.
                     :queue-family-index (info :queue-family-index)
                     ;; if we have multiple queues for a given
                     ;; family, we can specify a list of relative
                     ;; priorities (0.0-1.0) for each. If using
                     ;; multiple queue families, :priorities should
                     ;; be a list containing a list of priorities
                     ;; for each corresponding queue family

                     ;; (API for :queue-family-index and :priorities
                     ;;  might change in the future, since handling
                     ;;  a single family specially is a bit ugly)
                     :priorities (info :queue-priorities)
                     ;; Vulkan has various features which are not
                     ;; required to be supported (like different
                     ;; compression formats), or which might slow
                     ;; things down (like checking array bounds
                     ;; before access), so you need to specify which
                     ;; ones you want to use here.  for example
                     ;; :features '(:robust-buffer-access t
                     ;;             :texture-compression-bc t)

                     ;; You should also check the results of
                     ;; vk:get-physical-device-features first to
                     ;; make sure the particular features are
                     ;; available on the selected device.

                     ;; Pass NIL if you don't need any optional features.
                     :features nil
                     ;; and specify the layers/extensions we want
                     :exts *device-extension-names*
                     :layers *device-layer-names*)
      (let ((qf (info :queue-families)))
        (unless qf
          (error "no queues specified?"))
        (setf (info :graphics-queue)
              (apply #'vk::get-device-queue ,var (getf qf :graphics)))
        (setf (info :transfer-queue)
              (apply #'vk::get-device-queue ,var (getf qf :transfer)))
        (setf (info :present-queue)
              (apply #'vk::get-device-queue ,var (getf qf :present))))
      ,@body)))


(defparameter *keys-pressed* nil)
(defparameter *buttons-pressed* nil)
(defparameter *window-size* nil)

(defun update-window-title (window)
  (set-window-title (format nil "size ~A | keys ~A | buttons ~A"
                            *window-size*
                            *keys-pressed*
                            *buttons-pressed*)
                    window))

(def-key-callback key-callback (window key scancode action mod-keys)
  (declare (ignore scancode mod-keys))
  (when (and (eq key :escape) (eq action :press))
    (set-window-should-close))
  (if (eq action :press)
    (pushnew key *keys-pressed*)
    ;;(deletef *keys-pressed* key))
  (update-window-title window)))

(def-mouse-button-callback mouse-callback (window button action mod-keys)
  (declare (ignore mod-keys))
  (if (eq action :press)
    (pushnew button *buttons-pressed*)
    ;;(deletef *buttons-pressed* button))
  (update-window-title window)))

(def-window-size-callback window-size-callback (window w h)
  (setf *window-size* (list w h))
  (update-window-title window))

(defun glfw-with-vulkan-example ()
  ;; Graphics calls on OS X must occur in the main thread
  ;;  (with-body-in-main-thread ()
  (with-init-window (:title "" :width 400 :height 400 :client-api :no-gl-api)
    (setf *instance-extension-names* (get-instance-extensions))
    (with-sample-instance (instance)
      (with-surface (surface *window* (info :instance))
	(setf (info :surface) surface)
	(with-sample-device (gpu)
	  (set-key-callback 'key-callback)
	  (set-mouse-button-callback 'mouse-callback)
	  (set-window-size-callback 'window-size-callback)
	  (setf *window-size* (get-window-size))
	  (update-window-title *window*)
	  (loop until (window-should-close-p) do (wait-events)))))))

(defun test ()
  (with-init-window (:title "" :width 500 :height 500 :client-api :no-gl-api)
	(get-instance-extensions)))

(in-package :vkle)

(defparameter vk-info nil)

(defun set-vk-info (key val)
  (setf (getf vk-info key) val))

(defun get-vk-info (key)
  (getf vk-info key))

(def-key-callback key-callback (window key scancode action mod-keys)
  (declare (ignore window scancode mod-keys))
  (when (and (eq key :escape) (eq action :press))
    (set-window-should-close)))

(def-mouse-button-callback mouse-callback (window button action mod-keys)
  (declare (ignore window button action mod-keys)))

(def-window-size-callback window-size-callback (window w h)
  (declare (ignore window w h)))

(defmacro init-basic-glfw ((&key
			    (title "Basic Window")
			    (w 600)
			    (h 600))
			   &body body)
  `(with-init-window (:title ,title :width ,w :height ,h :client-api :no-gl-api)
     ,@body))

#|
(defun demo ()
  (init-basic-glfw ()
    (set-vk-info :instance (create-instance (make-instance-info :layers '("VK_LAYER_KHRONOS_validation"))))
    (set-vk-info :gpus (enumerate-physical-devices (getf vk-info :instance)))
    (set-vk-info :gpu (car (get-vk-info :gpus)))
    (set-vk-info :gpu-properties (get-physical-device-properties (get-vk-info :gpu)))
    (set-vk-info :select-gpu-queue-family-properties (get-physical-device-queue-family-properties (get-vk-info :gpu)))
    (set-vk-info :select-gpu-memory-properties (get-physical-device-memory-properties (get-vk-info :gpu)))
    (set-vk-info :select-gpu-feautres (get-physical-device-properties (get-vk-info :gpu)))
    

    (set-key-callback 'key-callback)
    (set-mouse-button-callback 'mouse-callback)
    (set-window-size-callback 'window-size-callback)
    (loop until (window-should-close-p) do (wait-events))
    (destroy-instance (get-vk-info :instance) c-null)))
|#

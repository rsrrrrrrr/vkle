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

(defun select-swapchain-format ()
  (loop for format in (get-vk-info :surface-format)
	when (and (eql (getf format :format) :format-r8g8b8a8-srgb)
		  (eql (getf format :color-space) :color-space-srgb-nonlinear-khr))
	  do (progn
	       (set-vk-info :selet-format format)
	       (return-from select-swapchain-format)))
  (set-vk-info :select-format (car (get-vk-info :surface-format))))

(defun select-present-mode ()
  (if (member :present-mode-mailbox-khr (get-vk-info :present-modes))
      (set-vk-info :select-present-mode :present-mode-mailbox-khr)
      (set-vk-info :select-present-mode :present-mode-fifo-khr)))

(defun get-surface-image-count ()
  (let* ((capabilities (get-vk-info :surface-capabilities))
	 (max-image-count (getf capabilities :max-image-count))
	 (min-image-count (1+ (getf capabilities :min-image-count))))
    (if (> min-image-count max-image-count)
	max-image-count
	min-image-count)))

(defun vulkan-initialize ()
  (set-vk-info :instance (create-instance :info-layers '("VK_LAYER_LUNARG_standard_validation")
					  :info-extensions (get-instance-extensions)
					  :with-debug t))
  (set-vk-info :gpus (enumerate-physical-devices (getf vk-info :instance)))
  (set-vk-info :gpu (car (get-vk-info :gpus)))
  (set-vk-info :gpu-properties (get-physical-device-properties (get-vk-info :gpu)))
  (set-vk-info :select-gpu-queue-family-properties (get-physical-device-queue-family-properties (get-vk-info :gpu)))
  (set-vk-info :graphics-queues (get-properity-queue-families (get-vk-info :gpu) :queue-graphics-bit))
  (set-vk-info :transfer-queues (get-properity-queue-families (get-vk-info :gpu) :queue-transfer-bit))
  (set-vk-info :compute-queues (get-properity-queue-families (get-vk-info :gpu) :queue-compute-bit))
  (set-vk-info :present-queues (get-present-queue-families (get-vk-info :instance)
							   (get-vk-info :gpu)))
  (set-vk-info :queue-use (intersection (get-vk-info :graphics-queues)
					(get-vk-info :present-queues)))
  (set-vk-info :select-gpu-properties (get-physical-device-properties (get-vk-info :gpu)))
  (set-vk-info :select-gpu-feautres (get-physical-device-features (get-vk-info :gpu)))
  (set-vk-info :device-extensions (get-device-extensions (get-vk-info :gpu)))
  (set-vk-info :logic-device (create-device (get-vk-info :gpu)
					    :info-extensions '("VK_KHR_swapchain")
					    :info-queue-infos (list (list :queue-family-index (car (get-vk-info :queue-use))
									  :queue-count 1
									  :queue-properties 1.0))))
  (set-vk-info :surface (create-surface-khr (get-vk-info :instance)))
  (set-vk-info :surface-format (get-physical-device-surface-formats (get-vk-info :gpu)
								    (get-vk-info :surface)))
  (set-vk-info :present-modes (get-physical-device-surface-present-mode-khr (get-vk-info :gpu)
									    (get-vk-info :surface)))
  (set-vk-info :surface-capabilities (get-physical-device-surface-capabilities-khr (get-vk-info :gpu)
										   (get-vk-info :surface)))
  (set-vk-info :present-queue (get-device-queue (get-vk-info :logic-device) (car (get-vk-info :queue-use)) 0))
  (set-vk-info :graphics-queue (get-device-queue (get-vk-info :logic-device) (car (get-vk-info :queue-use)) 0))
  (select-swapchain-format)
  (select-present-mode)
  (set-vk-info :swapchain (create-swapchain-khr (get-vk-info :logic-device)
						(get-vk-info :surface)
						:info-image-count (get-surface-image-count)
						:info-image-format (getf (get-vk-info :select-format) :format)
						:info-image-color-space (getf (get-vk-info :select-format) :color-space)
						:info-image-array-layers 1
						:info-extent-width 500
						:info-extent-height 500
						:info-image-usage :image-usage-color-attachment-bit
						:info-image-sharing-mode :sharing-mode-exclusive
						:info-pre-transfer (getf (get-vk-info :surface-capabilities) :current-transform)
						:info-composite-alpha :composite-alpha-opaque-bit-khr
						:info-present-mode (get-vk-info :select-present-mode)
						:info-clipped 1
						:info-old-swapchain c-null))
  (set-vk-info :images (get-swapchain-image-khr (get-vk-info :logic-device) (get-vk-info :swapchain)))
  (set-vk-info :image-views (loop for image in (get-vk-info :images)
				  collect (create-image-view (get-vk-info :logic-device) image))))

(defun vulkan-destroy ()
  (loop for image-view in (get-vk-info :image-views)
	do (destroy-image-view (get-vk-info :logic-device) image-view c-null))
  (destroy-swapchain-khr (get-vk-info :logic-device) (get-vk-info :swapchain) c-null)
  (destroy-surface-khr (get-vk-info :instance) (get-vk-info :surface) c-null)
  (when (check-reslute-type (device-wait-idle (get-vk-info :logic-device)))
    (destroy-device (get-vk-info :logic-device) c-null))
  (destroy-instance (get-vk-info :instance) c-null))

(defun demo ()
  (init-basic-glfw ()
    (vulkan-initialize)
    (set-key-callback 'key-callback)
    (set-mouse-button-callback 'mouse-callback)
    (set-window-size-callback 'window-size-callback)
    (loop until (window-should-close-p) do (wait-events))
    (vulkan-destroy)))


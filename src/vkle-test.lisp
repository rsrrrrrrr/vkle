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


(defun demo ()
  (init-basic-glfw ()
    (set-vk-info :instance (create-instance :info-layers '("VK_LAYER_KHRONOS_validation")
					    :info-extensions (get-instance-extensions)))
    (set-vk-info :gpus (enumerate-physical-devices (getf vk-info :instance)))
    (set-vk-info :gpu (car (get-vk-info :gpus)))
    (set-vk-info :gpu-properties (get-physical-device-properties (get-vk-info :gpu)))
    (set-vk-info :select-gpu-queue-family-properties (get-physical-device-queue-family-properties (get-vk-info :gpu)))
    (set-vk-info :graphics-queues (get-properity-queue-families (get-vk-info :gpu) :queue-graphics-bit))
    (set-vk-info :transfer-queues (get-properity-queue-families (get-vk-info :gpu) :queue-transfer-bit))
    (set-vk-info :compute-queues (get-properity-queue-families (get-vk-info :gpu) :queue-compute-bit))
    (set-vk-info :present-queues (get-present-queue-familues (get-vk-info :instance)
							     (get-vk-info :gpu)))
    (set-vk-info :select-gpu-feautres (get-physical-device-properties (get-vk-info :gpu)))
    (set-vk-info :device-extensions (get-device-extensions (get-vk-info :gpu)))
    (set-vk-info :logic-device (create-device (get-vk-info :gpu)
					      :info-queue-infos (list (list :queue-family-index (car (get-vk-info :graphics-queues))
									    :queue-count 1
									    :queue-properties 1.0))))

    (format t "~a~%" (get-vk-info :device-extensions))
    (set-vk-info :surface (create-surface-khr (get-vk-info :instance)))
    
    (format t "queue-families: ~a~%" (get-vk-info :select-gpu-queue-family-properties))
    (format t "present-queues: ~a~%" (get-vk-info :present-queues))
    (format t "graphics-queues: ~a~%" (get-vk-info :graphics-queues))
    (format t "compute-queues: ~a~%" (get-vk-info :compute-queues))
    (format t "transfer-queues: ~a~%" (get-vk-info :transfer-queues))

    (set-key-callback 'key-callback)
    (set-mouse-button-callback 'mouse-callback)
    (set-window-size-callback 'window-size-callback)
    (loop until (window-should-close-p) do (wait-events))
    (destroy-surface-khr (get-vk-info :instance) (get-vk-info :surface) c-null)
    (when (check-reslute-type (device-wait-idle (get-vk-info :logic-device)))
      (destroy-device (get-vk-info :logic-device) c-null))
    (destroy-instance (get-vk-info :instance) c-null)))

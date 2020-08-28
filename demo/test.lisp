(defpackage :vkle-demo
  (:use :cl :cl-glfw3 :vkle)
  (:export
   :instance-demo
   :print-physical-devices-info-demo
   :surface-demo
   :logic-device-demo
   :get-surface-capabilities
   :get-surface-formats
   :get-surface-present-modes))

(in-package :vkle-demo)                          

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
    (with-instance (instance
		    :extensions (get-instance-extensions)
		    :layers '("VK_LAYER_KHRONOS_validation"))
      (with-surface (surface *window* instance)
	(let* ((gpu-list (enumerate-physical-devices instance))
	       (gpu (car gpu-list))
	       (queue-family-properties (get-physical-device-queue-family-properties gpu))
	       (graphics-queues (get-propertiy-queue-list queue-family-properties :queue-graphics-bit))
	       (transfer-queues (get-propertiy-queue-list queue-family-properties :queue-transfer-bit))
	       (present-queus (get-present-queue-list instance gpu queue-family-properties)))
	  (format t "~a ~%~%~%" graphics-queues)
	  (format t "~a ~%~%~%" transfer-queues)
	  (format t "~a ~%~%~%" present-queus)
	  (with-device (device gpu
			:layers '("VK_LAYER_KHRONOS_validation")
			:queue-create-infos (list (list :flags 1
							:queue-family-index (car graphics-queues)
							:queue-count 1
							:queue-properties 1.0)
						  (list :flags 1
							:queue-family-index (car present-queus)
							:queue-count 1
							:queue-properties 1.0)))
	    (set-key-callback 'key-callback)
	    (set-mouse-button-callback 'mouse-callback)
	    (set-window-size-callback 'window-size-callback)
	    (loop until (window-should-close-p) do (wait-events))))))))

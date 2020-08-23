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
    (with-instance (instance)
      (let* ((gpu-list (enumerate-physical-devices instance))
	     (gpu (car gpu-list))
	     (gpu-properties (get-physical-device-properties gpu))
	     (queue-family-properties (get-physical-device-queue-family-properties gpu)))
	(format t "~{~a ~a~%~}~%" gpu-properties)
	(loop for queue-family in queue-family-properties
	      for i from 0
	      for mode = (getf queue-family :queue-flags)
	      when (queue-family-support-mode-p mode :mode :queue-graphics-bit)
		collect i into graphics-list
	      when (queue-family-support-mode-p mode :mode :queue-transfer-bit)
		collect i into transfer-list
	      finally
		 (progn
		   (format t "graphics list: ~{ ~a ~}~%" graphics-list)
		   (format t "transfer list: ~{ ~a ~}~%" transfer-list)
		   (format t "~a" queue-family-properties)
		   (set-key-callback 'key-callback)
		   (set-mouse-button-callback 'mouse-callback)
		   (set-window-size-callback 'window-size-callback)
		   (loop until (window-should-close-p) do (wait-events))))))))



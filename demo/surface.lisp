(in-package :vkle-demo)

(defmacro with-demo-surface ((surface) &body body)
  `(with-surface (,surface *window* (vk-info-instance *info*))
     (progn 
       (setf (vk-info-surface *info*) ,surface)
       ,@body)))

(defun surface-demo ()
  (init-basic-glfw ()
    (with-demo-instance (instance)
      (set-key-callback 'key-callback)
      (set-mouse-button-callback 'mouse-callback)
      (set-window-size-callback 'window-size-callback)
      (get-physical-device-list)
      (get-physical-device-info)
      (print-physical-device-infos)
      (with-demo-surface (surface)
	(loop until (window-should-close-p) do (wait-events))))))

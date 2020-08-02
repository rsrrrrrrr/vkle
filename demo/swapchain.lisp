(in-package :vkle-demo)


(defun get-surface-capabilities ()
  (init-basic-glfw ()
    (with-demo-instance (instance)
      (princ "Create Instance Success")
      (set-key-callback 'key-callback)
      (set-mouse-button-callback 'mouse-callback)
      (set-window-size-callback 'window-size-callback)
      (with-surface (surface *window* instance)
	(setf (vk-info-surface *info*) surface)
	(select-queue-family)
	(with-demo-device (device)
	  (setf (vk-info-surface-capabilities *info*) (get-physical-device-surface-capabilities (vk-info-gpu *info*) (vk-info-surface *info*)))
	  (format t "~{~a ~a~%~}" (vk-info-surface-capabilities *info*))
	  (loop until (window-should-close-p) do (wait-events)))))))



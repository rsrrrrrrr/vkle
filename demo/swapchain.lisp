(in-package :vkle-demo)


(defun get-surface-capabilities ()
  (setf (vk-info-surface-capabilities *info*) (get-physical-device-surface-capabilities (vk-info-gpu *info*) (vk-info-surface *info*)))
  (format t "~{~a ~a~%~}~%" (vk-info-surface-capabilities *info*)))

(defun get-surface-formats ()
  (setf (vk-info-surface-formats *info*) (get-physical-device-surface-formats-khr (vk-info-gpu *info*) (vk-info-surface *info*)))
  (dolist (info (vk-info-surface-formats *info*))
    (format t "~{~a ~a~%~}~%" info)))

(defun get-surface-present-modes ()
  (setf (vk-info-present-mode *info*) (get-physical-device-surface-present-modes-khr (vk-info-gpu *info*) (vk-info-surface *info*)))
  (format t "~{~a ~%~}~%" (vk-info-present-mode *info*)))

(defun init-swap-chain ()
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
	  (print-physical-device-infos)
	  (get-surface-capabilities)
	  (get-surface-formats)
	  (get-surface-present-modes)
	  (loop until (window-should-close-p) do (wait-events)))))))



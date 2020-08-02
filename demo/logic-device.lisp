(in-package :vkle-demo)

(defun select-gpu ()
  (get-physical-device-list)
  (get-physical-device-info)
  (setf (vk-info-gpu *info*) (nth 0 (vk-info-physical-devices *info*))
	(vk-info-gpu-properties *info*) (vk-info-physical-devices-properties *info*)
	(vk-info-gpu-features *info*) (vk-info-physical-devices-features *info*)))

(defun get-gpu-queue-families ()
  (select-gpu)
  (setf (vk-info-gpu-queue-families *info*) (get-physical-device-queue-family-properties (vk-info-gpu *info*))))

(defun select-queue-family ()
  (get-gpu-queue-families)
  (loop for queue in (vk-info-gpu-queue-families *info*)
	for i from 0
	for flags = (getf queue :queue-flags)
	when (member :graphics flags)
	  collect i into graphics
	when (member :transfer flags)
	  collect i into transfer
	finally
	   (setf (vk-info-gpu-graphics-queues *info*) graphics
		 (vk-info-gpu-transfer-queues *info*) transfer)
	   (let ((all (intersection (vk-info-gpu-graphics-queues *info*)
				    (vk-info-gpu-transfer-queues *info*))))
	     (dolist (index all)
	       (when (queue-family-index-support-present-p (vk-info-instance *info*)
							   (vk-info-gpu *info*)
							   index)
		 (pushnew index (vk-info-gpu-present-queues *info*))))
	     (when (vk-info-gpu-present-queues *info*)
	       (setf (vk-info-queue-families *info*) (list :present (list (car (vk-info-gpu-present-queues *info*)) 0)
							   :graphics (list (car (vk-info-gpu-present-queues *info*)) 0)
							   :transfer (list (car (vk-info-gpu-present-queues *info*)) 0))
		     (vk-info-queue-family-index *info*) (list (car (vk-info-gpu-present-queues *info*)))
		     (vk-info-queue-properties *info*) '((0.0)))))))

(defmacro with-demo-device ((device) &body body)
  `(with-device (,device (vk-info-gpu *info*)
		 :queue-family-index (vk-info-queue-family-index *info*)
		 :priorities (vk-info-queue-properties *info*)
		 :features nil
		 :exts *device-extension-names*
		 :layers *device-layer-names*)
     (progn
       (setf (vk-info-logic-device *info*) ,device)
       ,@body)))

(defun logic-device-demo ()
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
	  (loop until (window-should-close-p) do (wait-events)))))))


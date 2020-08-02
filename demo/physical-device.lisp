(in-package :vkle-demo)

(defun get-physical-device-list ()
  "you should get the physical devices, then select the gpu whitch you want"
  (setf (vk-info-physical-devices *info*) (enumerate-physical-devices (vk-info-instance *info*)))
  (assert (plusp (length (vk-info-physical-devices *info*)))))

(defun get-physical-device-info ()
  "used to get the gpu's properties and features"
  (setf (vk-info-physical-devices-properties *info*) (make-list (length (vk-info-physical-devices *info*)))
	(vk-info-physical-devices-features *info*) (make-list (length (vk-info-physical-devices *info*))))
  (do ((i 0 (1+ i)))
      ((>= i (length (vk-info-physical-devices *info*))) 'done)
    (progn
      (setf (nth i (vk-info-physical-devices-properties *info*)) (get-physical-device-properties (nth i (vk-info-physical-devices *info*)))
	    (nth i (vk-info-physical-devices-features *info*)) (get-physical-device-features (nth i (vk-info-physical-devices *info*)))))))

(defun print-physical-device-infos ()
  "used to print the gpu's info"
  (dolist (gpu-property (vk-info-physical-devices-properties *info*))
    (format t "API Version:~A~% Driver Version:~A~% Vendor ID:~A~% Device ID:~A~% Device Type:~A~% Device Name:~A~%" (getf gpu-property :api-version)
	    (getf gpu-property :driver-version )
	    (getf gpu-property :vendor-id)
	    (getf gpu-property :device-id)
	    (getf gpu-property :driver-uuid)
	    (getf gpu-property :device-name))))

(defun print-physical-devices-info-demo ()
  (init-basic-glfw ()
    (with-demo-instance (instance)
      (princ "Create Instance Success")
      (set-key-callback 'key-callback)
      (set-mouse-button-callback 'mouse-callback)
      (set-window-size-callback 'window-size-callback)
      (get-physical-device-list)
      (get-physical-device-info)
      (print-physical-device-infos)
      (loop until (window-should-close-p) do (wait-events)))))

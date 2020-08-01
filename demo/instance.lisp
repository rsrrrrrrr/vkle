(in-package :vkle-demo)


(defmacro with-demo-instance ((instance &key
					  (app "vkle-demo app")
					  (app-version 0)
					  (engine "vkle-demo engine")
					  (engine-version 0)) &body body)
  `(progn
     (setf *instance-extensions* (get-instance-extensions))
     (with-instance (,instance
		     :exts *instance-extensions*
		     :layers *instance-layer-names*
		     :app ,app
		     :app-version ,app-version
		     :engine ,engine
		     :engine-version ,engine-version)
       (setf (vk-info-instance info) ,instance)
       (with-debug-report (,instance)
	 ,@body))))

(defun instance-demo ()
  (init-basic-glfw ()
    (with-demo-instance (instance)
      (princ "Create Instance Success")
      (set-key-callback 'key-callback)
      (set-mouse-button-callback 'mouse-callback)
      (set-window-size-callback 'window-size-callback)
      (loop until (window-should-close-p) do (wait-events)))))

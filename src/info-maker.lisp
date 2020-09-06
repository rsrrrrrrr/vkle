(in-package :vkle)

(defun make-instance-info (&key
			     (next nil)
			     (flags 0)
			     (info nil)
			     (layers nil)
			     (extensions (get-instance-extensions)))
  (setf layers (check-usable-instance-layers layers)
	extensions (check-usable-instance-extensions extensions))
  (list '(:struct vk-instance-create-info)
	(list :type :structure-type-instance-create-info
	      :next next
	      :flags flags
	      :info (list '(:struct vk-application-info)
			  (append '(:type :structure-type-application-info)
				  info))
	      :layer-count (length layers)
	      :layers (list :string
			    layers)
	      :extension-count (length layers)
	      :extensions (list :string
				extensions))))

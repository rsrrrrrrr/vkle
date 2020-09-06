(in-package :vkle)

(defun make-instance-info (&key
			     (next nil)
			     (flags 0)
			     (app-info nil)
			     (layers nil)
			     (extensions nil))
  (list '(:struct vk-instance-create-info)
	(list :type :structure-type-instance-create-info
	      :next next
	      :flags flags
	      :info (list '(:struct vk-application-info)
			      app-info)
	      :layer-count (length layers)
	      :layers (list :string
			    layers)
	      :extension-count (length extensions)
	      :extensions (list :string
				extensions))))

(in-package :vkle)

(defun make-instance-info (&key
			     (next c-null)
			     (flags 0)
			     (info (list :next c-null
					 :app-name "vkle test"
					 :app-version (make-vulkan-version 0 0 1)
					 :engine-name "vkle test"
					 :engine-version (make-vulkan-version 0 0 1)))
			     (layers nil)
			     (extensions nil))
  (setf layers (check-usable-instance-layers layers)
	extensions (check-usable-instance-extensions extensions))
  (with-foreign-objects ((use-extensions :string (length extensions))
			 (use-layers :string (length layers)))
    (fill-obj use-extensions extensions :string)
    (fill-obj use-layers layers :string)
    (convert-to-foreign
     (list :type :structure-type-instance-create-info
	   :next next
	   :flags flags
	   :info (convert-to-foreign
		  (append (list :type :structure-type-application-info
				:api-version (make-vulkan-version 1 2 0))
			  (convert-nil->null-pointer info))
		  '(:struct vk-application-info))
	   :layer-count (length layers)
	   :layers use-layers
	   :extension-count (length extensions)
	   :extensions use-extensions)
     '(:struct vk-instance-create-info))))



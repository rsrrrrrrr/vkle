(in-package :vkle)

(defun fill-obj (obj lst type)
  (when (null lst)
    (null-pointer))
  (loop for name in lst
	for i from 0
	do
	   (setf (mem-aref obj type i)
		 (convert-to-foreign (nth i lst) type))))

(defun make-instance-info (&key
			     (next nil)
			     (flags 0)
			     (info (list :next nil
					 :app-name "vkle test"
					 :app-version (make-vulkan-version 0 0 1)
					 :engine-name "vkle test"
					 :engine-version (make-vulkan-version 0 0 1)))
			     (layers '("VK_LAYER_LUNARG_standard_validation"))
			     (extensions (get-instance-extensions)))
  (setf layers (check-usable-instance-layers layers)
	extensions (check-usable-instance-extensions extensions))
  (with-foreign-objects ((use-extensions :string (length extensions))
			 (use-layers :string (length layers)))
    (fill-obj use-extensions extensions :string)
    (fill-obj use-layers layers :string)
    (convert-to-foreign
     (convert-nil->null-pointer (list :type :structure-type-instance-create-info
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
				      :extensions use-extensions))
     '(:struct vk-instance-create-info))))

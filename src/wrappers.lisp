(in-package :vkle)

(export '(get-instance-extensions
	  get-instance-layers
	  get-instance-version))

(defun get-instance-extensions ()
  (with-foreign-object (count :uint32)
    (let ((extensions (glfwGetRequiredInstanceExtensions count)))
      (obj->list extensions count :string))))

(defun get-instance-layers ()
  (with-foreign-objects ((count :uint32)
			 (properties '(:struct vk-layer-properties)))
    (do-get-function #'vkEnumerateInstanceLayerProperties count (null-pointer))
    (do-get-function #'vkEnumerateInstanceLayerProperties count properties)
    (convert-to-new-list (obj->list properties count '(:struct vk-layer-properties)))))

(defun get-instance-version ()
  (with-foreign-object (version :uint32)
    (check-reslute-type (vkEnumerateInstanceVersion version))
    (mem-ref version :uint32)))

(defun create-instance (&key
			  (allocator nil)
			  (info-list nil))
  (with-foreign-object (instance 'vk-instance)
    (let ((info (convert-to-pointer info-list)))
      (check-reslute-type (vkCreateInstance info
					    (null->null-pointer allocator)
					    instance))
      (mem-ref instance 'vk-instance))))

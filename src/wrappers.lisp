(in-package :vkle)

(export '(get-instance-extensions
	  get-instance-layers
	  get-device-layers
	  get-instance-version
	  enumerate-physical-devices
	  get-physical-device-properties
	  get-physical-device-queue-family-properties
	  get-physical-device-memory-properties
	  get-physical-device-features
	  get-physical-device-format-properties
	  get-physical-device-image-format-properties))

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

(defun get-device-layers (physical-device)
  (with-foreign-objects ((count :uint32)
			 (properties '(:struct vk-layer-properties)))
    (do-get-function #'vkEnumerateDeviceLayerProperties physical-device count (null-pointer))
    (do-get-function #'vkEnumerateDeviceLayerProperties physical-device count properties)
    (convert-to-new-list (obj->list properties count '(:struct vk-layer-properties)))))

(defun get-device-extensions (physical-device layer)
  (with-foreign-objects ((count :uint32)
			 (properties '(:struct vk-extension-properties)))
    (do-get-function #'vkEnumerateDeviceExtensionProperties physical-device layer count (null-pointer))
    (do-get-function #'vkEnumerateDeviceExtensionProperties physical-device layer count properties)
    (convert-to-new-list (obj->list properties count '(:struct vk-layer-properties)))))

(defun get-instance-version ()
  (with-foreign-object (version :uint32)
    (check-reslute-type (vkEnumerateInstanceVersion version))
    (mem-ref version :uint32)))

(defun enumerate-physical-devices (instance)
  (with-foreign-objects ((count :uint32)
			 (physical-device 'vk-physical-device))
    (do-get-function #'vkEnumeratePhysicalDevices instance count (null-pointer))
    (assert (plusp (mem-ref count :uint32)))
    (do-get-function #'vkEnumeratePhysicalDevices instance count physical-device)
    (obj->list physical-device count 'vk-physical-device)))

(defun get-physical-device-properties (physical-device)
  (with-foreign-object (properties '(:struct vk-physical-device-properties))
    (vkGetPhysicalDeviceProperties physical-device properties)
    (mem-ref properties '(:struct vk-physical-device-properties))))

(defun get-physical-device-queue-family-properties (physical-device)
  (with-foreign-objects ((count :uint32)
			 (properties '(:struct vk-queue-family-properties)))
    (vkGetPhysicalDeviceQueueFamilyProperties physical-device count (null-pointer))
    (assert (plusp (mem-ref count :uint32)))
    (vkGetPhysicalDeviceQueueFamilyProperties physical-device count properties)
    (obj->list properties count '(:struct vk-queue-family-properties))))

(defun get-physical-device-memory-properties (physical-device)
  (with-foreign-object (properties '(:struct vk-physical-device-memory-properties))
    (vkGetPhysicalDeviceMemoryProperties physical-device properties)
    (mem-ref properties '(:struct vk-physical-device-memory-properties))))

(defun get-physical-device-features (physical-device)
  (with-foreign-object (features '(:struct vk-physical-device-features))
    (vkGetPhysicalDeviceFeatures physical-device features)
    (mem-ref features '(:struct vk-physical-device-features))))

(defun get-physical-device-format-properties (physical-device format)
  (with-foreign-object (properties '(:struct vk-format-properties))
    (vkGetPhysicalDeviceFormatProperties physical-device format properties)
    (mem-ref properties '(:struct vk-format-properties))))

(defun get-physical-device-image-format-properties (physical-device format type tiling usage flags)
  (with-foreign-object (properties '(:struct vk-image-format-properties))
    (vkGetPhysicalDeviceImageFormatProperties physical-device format type tiling usage flags properties)
    (mem-ref properties '(:struct vk-image-format-properties))))

(defun get-device-memory-commitment (device memory)
  (with-foreign-object (bytes 'vk-device-size)
    (vkGetDeviceMemoryCommitment device memory bytes)
    (mem-ref bytes 'vk-device-size)))

(defun get-buffer-memory-requirements (device buffer)
  (with-foreign-object (requirements '(:struct vk-memory-requirements))
    (vkGetBufferMemoryRequirements device buffer requirements)
    (mem-ref requirements '(:struct vk-memory-requirements))))

(defun get-image-memory-requirements (device image)
  (with-foreign-object (requirements '(:struct vk-memory-requirements))
    (vkGetImageMemoryRequirements device image requirements)
    (mem-ref requirements '(:struct vk-memory-requirements))))

(defun get-image-sparse-memory-requirements (device image)
  (with-foreign-objects ((count :uint32)
			 (requirements '(:struct vk-sparse-image-memory-requirements)))
    (do-get-function #'vkGetImageSparseMemoryRequirements device image count (null-pointer))
    (do-get-function #'vkGetImageSparseMemoryRequirements device image count requirements)
    (obj->list requirements count '(:struct vk-sparse-image-memory-requirements))))

(defun create-instance (info &key (allocator c-null))
  (with-foreign-object (instance 'vk-instance)
    (check-reslute-type (vkCreateInstance info (null->null-pointer allocator) instance))
    (mem-ref instance 'vk-instance)))



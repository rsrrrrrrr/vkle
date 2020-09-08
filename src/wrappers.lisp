(in-package :vkle)

(export '(get-instance-extensions
	  get-instance-layers
	  get-device-layer-properties
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

(defun get-device-layer-properties (physical-device)
  (with-foreign-objects ((count :uint32)
			 (properties '(:struct vk-layer-properties)))
    (do-get-function #'vkEnumerateDeviceLayerProperties physical-device count (null-pointer))
    (do-get-function #'vkEnumerateDeviceLayerProperties physical-device count properties)
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

(defun create-instance (info &key (allocator c-null))
  (with-foreign-object (instance 'vk-instance)
    (check-reslute-type (vkCreateInstance info (null->null-pointer allocator) instance))
    (mem-ref instance 'vk-instance)))

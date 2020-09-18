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
	  get-physical-device-image-format-properties
	  create-instance
	  create-device))

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

(defun create-instance (&key
			  (app-next c-null) 
			  (app-name "vkle-test")
			  (app-version (make-vulkan-version 0 0 1))
			  (engine-name "vkle-test")
			  (engine-version (make-vulkan-version 0 0 1))
			  (api-version (make-vulkan-version 1 2 0))
			  (info-next c-null)
			  (info-flags 0)
			  (info-extensions nil)
			  (info-layers nil)
			  (allocator c-null))
  (with-foreign-objects ((app-info '(:struct vk-application-info))
			 (create-info '(:struct vk-instance-create-info))
			 (instance 'vk-instance))
    (obj->default app-info '(:struct vk-application-info))
    (obj->default create-info '(:struct vk-instance-create-info))
    ;;fill application info
    (set-struct-val app-info
		    '(:struct vk-application-info)
		    :type
		    :structure-type-application-info)
    (set-struct-val app-info
		    '(:struct vk-application-info)
		    :next
		    app-next)
    (set-struct-val app-info
		    '(:struct vk-application-info)
		    :app-name
		    (convert-to-foreign app-name :string))
    (set-struct-val app-info
		    '(:struct vk-application-info)
		    :app-version
		    app-version)
    (set-struct-val app-info
		    '(:struct vk-application-info)
		    :engine-name
		    (convert-to-foreign engine-name :string))
    (set-struct-val app-info
		    '(:struct vk-application-info)
		    :engine-version
		    engine-version)
    (set-struct-val app-info
		    '(:struct vk-application-info)
		    :api-version
		    api-version)
    ;;fill struct of instance create info
    (setf info-extensions (get-all-usable-instance-extensions info-extensions)
	  info-layers (get-all-usable-instance-layers info-layers))
    (with-foreign-objects ((extensions :string (length info-extensions))
			   (layers :string (length info-layers)))
      (loop for i upto (1- (length info-extensions))
	    do (setf (mem-aref extensions :string i) (convert-to-foreign (nth i info-extensions) :string)))
      (loop for i upto (1- (length info-layers))
	    do (setf (mem-aref layers :string i) (convert-to-foreign (nth i info-layers) :string)))
      (set-struct-val create-info
		      '(:struct vk-instance-create-info)
		      :type
		      :structure-type-instance-create-info)
      (set-struct-val create-info
		      '(:struct vk-instance-create-info)
		      :next
		      info-next)
      (set-struct-val create-info
		      '(:struct vk-instance-create-info)
		      :flags
		      info-flags)
      (set-struct-val create-info
		      '(:struct vk-instance-create-info)
		      :info
		      app-info)
      (set-struct-val create-info
		      '(:struct vk-instance-create-info)
		      :layer-count
		      (length info-layers))
      (set-struct-val create-info
		      '(:struct vk-instance-create-info)
		      :layers
		      layers)
      (set-struct-val create-info
		      '(:struct vk-instance-create-info)
		      :extension-count
		      (length info-extensions))
      (set-struct-val create-info
		      '(:struct vk-instance-create-info)
		      :extensions
		      extensions)
      (check-reslute-type (vkCreateInstance create-info allocator instance))
      (mem-ref instance 'vk-instance))))

(defun fill-queue-infos (objs properties infos)
  (loop for info in infos
	for i from 0
	for obj = (mem-aptr objs '(:struct vk-device-queue-create-info) i)
	for properity = (mem-aptr properties :float i)
	do
	   (progn
	     (setf (mem-ref properity :float) (getf info :queue-properties))
	     (set-struct-val obj
			     '(:struct vk-device-queue-create-info)
			     :type
			     :structure-type-device-queue-create-info)
	     (set-struct-val obj
			     '(:struct vk-device-queue-create-info)
			     :next
			     (getf info :next))
	     (set-struct-val obj
			     '(:struct vk-device-queue-create-info)
			     :flags
			     (getf info :flags))
	     (set-struct-val obj
			     '(:struct vk-device-queue-create-info)
			     :queue-family-index
			     (getf info :queue-family-index))
	     (set-struct-val obj
			     '(:struct vk-device-queue-create-info)
			     :queue-count
			     (getf info :queue-family-count))
	     (set-struct-val obj
			     '(:struct vk-device-queue-create-info)
			     :queue-properties
			     properity))))

(defun create-device (physical-device &key
					(info-next c-null)
					(info-flags 0)
					(info-queue-infos nil)
					(info-layers nil)
					(info-extensions nil)
					(info-features nil)
					(allocator c-null))
  (with-foreign-objects ((create-info '(:struct vk-device-create-info))
			 (queue-infos '(:struct vk-device-queue-create-info) (length info-queue-infos))
			 (properties :float (length info-queue-infos))
			 (features '(:struct vk-physical-device-features))
			 (device 'vk-device))
    (obj->default create-info '(:struct vk-device-create-info))
    (obj->default features '(:struct vk-physical-device-features))
    (loop for info in info-queue-infos
	  for i from 0
	  do (obj->default (mem-aptr queue-infos '(:struct vk-device-queue-create-info) i)
			   '(:struct vk-device-queue-create-info)))
    ;;initialize queue create infos
    (fill-queue-infos queue-infos properties info-queue-infos)
    ;;check physical device features
    (auto-set-struct-val features '(:struct vk-physical-device-features) info-features)
    ;;initialize create info
    (setf info-layers (get-all-usable-device-layers physical-device info-layers)
	  info-extensions (get-all-usable-device-extensions physical-device info-layers info-extensions))
    (with-foreign-objects ((layers :string (length info-layers))
			   (extensions :string (length info-extensions)))
      (loop for ext in info-extensions
	    for i upto (1- (length info-extensions))
	    do (setf (mem-aref extensions :string i) (convert-to-foreign (nth i info-extensions) :string)))
      (loop for lay in info-layers
	    for i upto (1- (length info-layers))	    
	    do (setf (mem-aref layers :string i) (convert-to-foreign (nth i info-layers) :string)))
      (set-struct-val create-info
		      '(:struct vk-device-create-info)
		      :type
		      :structure-type-device-create-info)
      (set-struct-val create-info
		      '(:struct vk-device-create-info)
		      :next
		      info-next)
      (set-struct-val create-info
		      '(:struct vk-device-create-info)
		      :flags
		      info-flags)
      (set-struct-val create-info
		      '(:struct vk-device-create-info)
		      :queue-create-info-count
		      (length info-queue-infos))
      (set-struct-val create-info
		      '(:struct vk-device-create-info)
		      :queue-create-infos
		      queue-infos)
      (set-struct-val create-info
		      '(:struct vk-device-create-info)
		      :layer-count
		      (length info-layers))
      (set-struct-val create-info
		      '(:struct vk-device-create-info)
		      :layers
		      layers)
      (set-struct-val create-info
		      '(:struct vk-device-create-info)
		      :extension-count
		      (length info-extensions))
      (set-struct-val create-info
		      '(:struct vk-device-create-info)
		      :extensions
		      extensions)
      (set-struct-val create-info
		      '(:struct vk-device-create-info)
		      :enable-features
		      features)
      (check-reslute-type (vkCreateDevice physical-device create-info allocator device))
      (mem-ref device 'vk-device))))

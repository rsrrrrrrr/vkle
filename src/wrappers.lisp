(in-package :vkle)

(export '(get-instance-extensions
	  get-instance-layers
	  get-device-layers
	  get-device-extensions
	  get-instance-version
	  get-physical-device-surface-formats
	  get-physical-device-surface-present-mode-khr
	  get-physical-device-surface-capabilities-khr
	  get-device-queue
	  enumerate-physical-devices
	  get-physical-device-properties
	  get-physical-device-queue-family-properties
	  get-physical-device-memory-properties
	  get-physical-device-features
	  get-physical-device-format-properties
	  get-physical-device-image-format-properties
	  get-swapchain-image-khr
	  create-instance
	  destroy-instance
	  create-device
	  create-surface-khr
	  create-swapchain-khr
	  create-image-views))

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

(defun get-device-extensions (physical-device)
  (with-foreign-object (count :uint32)
    (vkEnumerateDeviceExtensionProperties physical-device c-null count c-null)
    (unless (zerop (mem-ref count :uint32))
      (with-foreign-object (properties '(:struct vk-extension-properties) (mem-ref count :uint32))
	(vkEnumerateDeviceExtensionProperties physical-device c-null count properties)
	(convert-to-new-list (obj->list properties count '(:struct vk-extension-properties)))))))

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

(defun get-physical-device-surface-formats (physical-device surface)
  (with-foreign-object (count :uint32)
    (do-get-function #'vkGetPhysicalDeviceSurfaceFormatsKHR physical-device surface count c-null)
    (with-foreign-object (format '(:struct vk-surface-format-khr) (mem-ref count :uint32))
      (do-get-function #'vkGetPhysicalDeviceSurfaceFormatsKHR physical-device surface count format)
      (obj->list format count '(:struct vk-surface-format-khr)))))

(defun get-physical-device-surface-present-mode-khr (physical-device surface)
  (with-foreign-object (count :uint32)
    (do-get-function #'vkGetPhysicalDeviceSurfacePresentModesKHR physical-device surface count c-null)
    (with-foreign-object (mode 'VkPresentModeKHR (mem-ref count :uint32))
      (do-get-function #'vkGetPhysicalDeviceSurfacePresentModesKHR physical-device surface count mode)
      (obj->list mode count 'VkPresentModeKHR))))

(defun get-physical-device-surface-capabilities-khr (physical-device surface)
  (with-foreign-object (capabilities '(:struct vk-surface-capabilities-khr))
    (do-get-function #'vkGetPhysicalDeviceSurfaceCapabilitiesKHR physical-device surface capabilities)
    (mem-ref capabilities '(:struct vk-surface-capabilities-khr))))

(defun get-device-queue (device queue-family-index queue-index)
  (with-foreign-object (queue 'vk-queue)
    (vkGetDeviceQueue device queue-family-index queue-index queue)
    (mem-ref queue 'vk-queue)))

(defun get-swapchain-image-khr (device swapchain)
  (with-foreign-object (count :uint32)
    (vkGetSwapchainImagesKHR device swapchain count c-null)
    (with-foreign-object (images 'vk-image (mem-ref count :uint32))
      (vkGetSwapchainImagesKHR device swapchain count images)
      (obj->list images count 'vk-image))))

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
			  (allocator c-null)
			  (with-debug nil))
  (with-foreign-objects ((app-info '(:struct vk-application-info))
			 (create-info '(:struct vk-instance-create-info))
			 (instance 'vk-instance))
    (obj->default app-info '(:struct vk-application-info))
    (obj->default create-info '(:struct vk-instance-create-info))
    ;;fill application info
    (set-struct-val app-info '(:struct vk-application-info) :type :structure-type-application-info)
    (set-struct-val app-info '(:struct vk-application-info) :next app-next)
    (set-struct-val app-info '(:struct vk-application-info) :app-name (convert-to-foreign app-name :string))
    (set-struct-val app-info '(:struct vk-application-info) :app-version app-version)
    (set-struct-val app-info '(:struct vk-application-info) :engine-name (convert-to-foreign engine-name :string))
    (set-struct-val app-info '(:struct vk-application-info) :engine-version engine-version)
    (set-struct-val app-info '(:struct vk-application-info) :api-version api-version)
    ;;fill struct of instance create info
    (setf info-extensions (get-all-usable-instance-extensions info-extensions)
	  info-layers (get-all-usable-instance-layers info-layers))
    (when with-debug
      (setf *debug-status* t
	    *instance-dbg-create-info* (foreign-alloc '(:struct vk-debug-report-callback-create-info-ext)))
      (push "VK_EXT_debug_report" info-extensions)
      (set-struct-val *instance-dbg-create-info* '(:struct vk-debug-report-callback-create-info-ext) :type :structure-type-debug-report-callback-create-info-ext)
      (set-struct-val *instance-dbg-create-info* '(:struct vk-debug-report-callback-create-info-ext) :next c-null)
      (set-struct-val *instance-dbg-create-info* '(:struct vk-debug-report-callback-create-info-ext) :user-data c-null)
      (set-struct-val *instance-dbg-create-info* '(:struct vk-debug-report-callback-create-info-ext) :flags
		      (logior (foreign-enum-value 'VkDebugReportFlagBitsEXT :debug-report-warning-bit-ext )
			      (foreign-enum-value 'VkDebugReportFlagBitsEXT :debug-report-performance-warning-bit-ext)
			      (foreign-enum-value 'VkDebugReportFlagBitsEXT :debug-report-error-bit-ext)
			      (foreign-enum-value 'VkDebugReportFlagBitsEXT :debug-report-debug-bit-ext)))
      (set-struct-val *instance-dbg-create-info* '(:struct vk-debug-report-callback-create-info-ext) :pfn-callback (callback debug-message)))
    (with-foreign-objects ((extensions :string (length info-extensions))
			   (layers :string (length info-layers)))
      (loop for i upto (1- (length info-extensions))
	    do (setf (mem-aref extensions :string i) (convert-to-foreign (nth i info-extensions) :string)))
      (loop for i upto (1- (length info-layers))
	    do (setf (mem-aref layers :string i) (convert-to-foreign (nth i info-layers) :string)))
      (set-struct-val create-info '(:struct vk-instance-create-info) :type :structure-type-instance-create-info)
      (if with-debug
	  (set-struct-val create-info '(:struct vk-instance-create-info) :next *instance-dbg-create-info*)
	  (set-struct-val create-info '(:struct vk-instance-create-info) :next info-next))
      (set-struct-val create-info '(:struct vk-instance-create-info) :flags info-flags)
      (set-struct-val create-info '(:struct vk-instance-create-info) :info app-info)
      (set-struct-val create-info '(:struct vk-instance-create-info) :layer-count (length info-layers))
      (set-struct-val create-info '(:struct vk-instance-create-info) :layers layers)
      (set-struct-val create-info '(:struct vk-instance-create-info) :extension-count(length info-extensions))
      (set-struct-val create-info '(:struct vk-instance-create-info) :extensions extensions)
      (check-reslute-type (vkCreateInstance create-info allocator instance))
      (when with-debug
	(create-debug-callback (mem-ref instance 'vk-instance))
	(foreign-free *instance-dbg-create-info*))
      (mem-ref instance 'vk-instance))))

(defun destroy-instance (instance &optional (allocator c-null))
  (when *debug-status*
    (destroy-debug-callback instance))
  (vkDestroyInstance instance allocator))

(defun fill-queue-infos (objs properties infos)
  (loop for info in infos
	for i from 0
	for obj = (mem-aptr objs '(:struct vk-device-queue-create-info) i)
	for properity = (mem-aptr properties :float i)
	do
	   (progn
	     (setf (mem-ref properity :float) (getf info :queue-properties))
	     (set-struct-val obj '(:struct vk-device-queue-create-info) :type :structure-type-device-queue-create-info)
	     (set-struct-val obj '(:struct vk-device-queue-create-info) :next (getf info :next))
	     (set-struct-val obj '(:struct vk-device-queue-create-info) :flags (getf info :flags))
	     (set-struct-val obj '(:struct vk-device-queue-create-info) :queue-family-index (getf info :queue-family-index))
	     (set-struct-val obj '(:struct vk-device-queue-create-info) :queue-count (getf info :queue-count))
	     (set-struct-val obj '(:struct vk-device-queue-create-info) :queue-properties properity))))

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
	  info-extensions (get-all-usable-device-extensions physical-device info-extensions))
    (with-foreign-objects ((layers :string (length info-layers))
			   (extensions :string (length info-extensions)))
      (loop for ext in info-extensions
	    for i upto (1- (length info-extensions))
	    do (setf (mem-aref extensions :string i) (convert-to-foreign (nth i info-extensions) :string)))
      (loop for lay in info-layers
	    for i upto (1- (length info-layers))	    
	    do (setf (mem-aref layers :string i) (convert-to-foreign (nth i info-layers) :string)))
      (set-struct-val create-info '(:struct vk-device-create-info) :type :structure-type-device-create-info)
      (set-struct-val create-info '(:struct vk-device-create-info) :next info-next)
      (set-struct-val create-info '(:struct vk-device-create-info) :flags info-flags)
      (set-struct-val create-info '(:struct vk-device-create-info) :queue-create-info-count (length info-queue-infos))
      (set-struct-val create-info '(:struct vk-device-create-info) :queue-create-infos queue-infos)
      (set-struct-val create-info '(:struct vk-device-create-info) :layer-count 0)
      (set-struct-val create-info '(:struct vk-device-create-info) :layers c-null)
      (set-struct-val create-info '(:struct vk-device-create-info) :extension-count (length info-extensions))
      (set-struct-val create-info '(:struct vk-device-create-info) :extensions extensions)
      (set-struct-val create-info '(:struct vk-device-create-info) :enable-features features)
      (check-reslute-type (vkCreateDevice physical-device create-info allocator device))
      (mem-ref device 'vk-device))))

(defun create-surface-khr (instance &key
				      (window *window*)
				      (allocator c-null))
  (with-foreign-object (surface 'vk-surface-khr)
    (check-reslute-type (glfwCreateWindowSurface instance window allocator surface))
    (mem-ref surface 'vk-surface-khr)))

(defun create-swapchain-khr (device surface &key
					      (info-next c-null)
					      (info-flags 0)
					      (info-image-count 0)
					      (info-image-format :format-undefined)
					      (info-image-color-space :color-space-srgb-nonlinear-khr)
					      (info-extent-width 600)
					      (info-extent-height 600)
					      (info-image-array-layers 0)
					      (info-image-usage 0)
					      (info-image-sharing-mode :sharing-mode-exclusive)
					      (info-queue-family-index-count 0)
					      (info-queue-family-indices nil)
					      (info-pre-transfer :surface-transform-identity-bit-khr)
					      (info-composite-alpha :composite-alpha-opaque-bit-khr)
					      (info-present-mode :present-mode-immediate-khr)
					      (info-clipped 0)
					      (info-old-swapchain c-null)
					      (allocator c-null))
  (with-foreign-objects ((create-info '(:struct vk-swapchain-create-info-khr))
			 (indices :uint32 (length info-queue-family-indices))
			 (swapchain 'vk-swapchain-khr))
    (loop for index in info-queue-family-indices
	  for i from 0
	  do
	     (setf (mem-aref indices :uint32 i) index))
    (set-struct-val create-info '(:struct vk-swapchain-create-info-khr) :type :structure-type-swapchain-create-info-khr)
    (set-struct-val create-info '(:struct vk-swapchain-create-info-khr) :next info-next)
    (set-struct-val create-info '(:struct vk-swapchain-create-info-khr) :flags info-flags)
    (set-struct-val create-info '(:struct vk-swapchain-create-info-khr) :surface surface)
    (set-struct-val create-info '(:struct vk-swapchain-create-info-khr) :min-image-count info-image-count)
    (set-struct-val create-info '(:struct vk-swapchain-create-info-khr) :image-format info-image-format)
    (set-struct-val create-info '(:struct vk-swapchain-create-info-khr) :image-color-space info-image-color-space)
    (set-struct-val create-info '(:struct vk-swapchain-create-info-khr) :image-array-layers info-image-array-layers)
    (set-struct-val create-info '(:struct vk-swapchain-create-info-khr) :image-usage info-image-usage)
    (set-struct-val create-info '(:struct vk-swapchain-create-info-khr) :image-sharing-mode info-image-sharing-mode)
    (set-struct-val create-info '(:struct vk-swapchain-create-info-khr) :queue-family-index-count info-queue-family-index-count)
    (set-struct-val create-info '(:struct vk-swapchain-create-info-khr) :queue-family-indices indices)
    (set-struct-val create-info '(:struct vk-swapchain-create-info-khr) :pre-transform info-pre-transfer)
    (set-struct-val create-info '(:struct vk-swapchain-create-info-khr) :composite-alpha info-composite-alpha)
    (set-struct-val create-info '(:struct vk-swapchain-create-info-khr) :present-mode info-present-mode)
    (set-struct-val create-info '(:struct vk-swapchain-create-info-khr) :clipped info-clipped)
    (set-struct-val create-info '(:struct vk-swapchain-create-info-khr) :old-swapchain info-old-swapchain)
    (setf (foreign-slot-value create-info '(:struct vk-swapchain-create-info-khr) :image-extent)
	  (convert-to-foreign (list :height info-extent-height :width info-extent-width)
			      '(:struct vk-extent-2d)))
    (check-reslute-type (vkCreateSwapchainKHR device create-info allocator swapchain))
    (mem-ref swapchain 'vk-swapchain-khr)))

(defun create-image-view (device image &key
					 (info-next c-null)
					 (info-flags 0)
					 (info-view-type :image-view-type-2d)
					 (info-format :format-r8g8b8a8-srgb)
					 (info-compoents '(:r :component-swizzle-identity
							   :g :component-swizzle-identity
							   :b :component-swizzle-identity
							   :a :component-swizzle-identity))
					 (info-subresource-range '(:aspect-mask :image-aspect-color-bit
								   :base-mip-level 0
								   :level-count 1
								   :base-array-layer 0
								   :layer-count 1))
					 (allocator c-null))
  (with-foreign-objects ((create-info '(:struct vk-image-view-create-info))
			 (image-view 'vk-image-view))
    (set-struct-val create-info '(:struct vk-image-view-create-info) :type :structure-type-image-view-create-info)
    (set-struct-val create-info '(:struct vk-image-view-create-info) :next info-next)
    (set-struct-val create-info '(:struct vk-image-view-create-info) :flags info-flags)
    (set-struct-val create-info '(:struct vk-image-view-create-info) :image image)
    (set-struct-val create-info '(:struct vk-image-view-create-info) :view-type info-view-type)
    (set-struct-val create-info '(:struct vk-image-view-create-info) :format info-format)
    (set-struct-val create-info '(:struct vk-image-view-create-info) :components (convert-to-foreign info-compoents '(:struct vk-component-mapping)))
    (set-struct-val create-info '(:struct vk-image-view-create-info) :subresource-range (convert-to-foreign info-subresource-range '(:struct vk-image-subresource-range)))
    (check-reslute-type (vkCreateImageView device create-info allocator image-view))
    (mem-ref image-view 'vk-image-view)))

(in-package :vkle)

(export '(make-vulkan-version
	  create-instance
	  destroy-instance
	  with-instance
	  enumerate-physical-devices
	  get-physical-device-properties
	  get-physical-device-queue-family-properties
	  get-physical-device-memory-properties
	  get-physical-device-features
	  get-physical-device-format-properties
	  get-physical-device-image-format-properties
	  create-device
	  destroy-device
	  with-device))

(defun check-reslute-type (ret-val)
  (when (not (eql ret-val :success))
    (error ret-val)))

(defun make-vulkan-version (&optional (major 1) (minor 2) (patch 0))
  (logior (ash major 22)
	  (ash minor 12)
	  patch))
#|
(defun create-vulkan-surface-khr (win instance allocate)
  (let ((surface-type (get-vulkan-dispatch-type)))
    (with-foreign-object (surface surface-type)
      (foreign-funcall "glfwCreateWindowSurface"
		       :pointer instance
		       :pointer win
		       :pointer allocate
		       :pointer surface
		       :boolean)
      (mem-ref surface surface-type))))

(defmacro with-surface ((surface win instance) &body body)
  `(let ((,surface (create-vulkan-surface-khr ,win ,instance (null-pointer))))
     (progn
       ,@body
       (%vk:destroy-surface-khr ,instance ,surface (null-pointer)))))

(defun create-semaphore (logic-device)
  (let ((semaphore-type (get-vulkan-dispatch-type)))
    (with-foreign-objects ((create-info '(:struct semaphore-create-info) (semaphore semaphore-type)))
      (setf (foreign-slot-value create-info '(:struct semaphore-create-info) :struct-info) :semaphore-create-info
	    (foreign-slot-value create-info '(:struct semaphore-create-info) :next) (null-pointer)
	    (foreign-slot-value create-info '(:struct semaphore-create-info) :flag) 0)
      (foreign-funcall "vkCreateSemaphore"
		       logic-device ))))

(defcfun ("vkCreateSemaphore" create-semaphore) :uint32
  (device :pointer)
  (p-create-info (:pointer (:struct semaphore-create-info)))
  (p-allocator :pointer) 
  (p-semaphore (:pointer semaphore)))
|#

(defcfun ("glfwVulkanSupported" get-vulkan-support) :boolean
  "return true if vulkan is available")

(defcfun ("glfwGetPhysicalDevicePresentationSupport" queue-family-index-support-present-p) :uint64
  (instance vk-handle)
  (physical-device vk-handle)
  (index :uint32))

(defcfun ("vkCreateInstance" vkCreateInstance) VkResult
  (instance-create-info (:pointer (:struct vk-instance-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (instance (:pointer vk-instance)))

(defcfun ("vkDestroyInstance" destroy-instance) :void
  (instance vk-instance)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defun get-instance-extensions ()
  (with-foreign-object (count :uint32)
    (let* ((extensions (foreign-funcall "glfwGetRequiredInstanceExtensions"
					:pointer count
					:pointer))
	   (extensions-count (- (mem-ref count :uint32) 1)))
      (loop for i from 0 upto extensions-count
	    collect (mem-aref extensions :string i)))))

(defun create-instance (&key
			  (instance-next nil)
			  (instance-flags 0)
			  (application-next nil)
			  (application-name "Vkle test")
			  (application-version (make-vulkan-version 0 0 0))
			  (engine-name "Vkle test")
			  (engine-version (make-vulkan-version 0 0 0))
			  (api-version (make-vulkan-version))
			  (extensions (get-instance-extensions))   ;;as default use glfw get the extension
			  (layers nil)
			  (allocator nil))
  (with-foreign-objects ((app-info '(:struct vk-application-info))
			 (instance-info '(:struct vk-instance-create-info))
			 (instance 'vk-instance)
			 (instance-layers '(:pointer :string))
			 (instance-extensions '(:pointer :string)))
    (when (null instance-next)
      (setf instance-next (null-pointer)))    
    (when (null application-next)
      (setf application-next (null-pointer)))
    (when (null allocator)
      (setf allocator (null-pointer)))
    ;;set struct VkApplicationInfo
    (setf (foreign-slot-value app-info '(:struct vk-application-info) :type)
	  :structure-type-application-info
	  (foreign-slot-value app-info '(:struct vk-application-info) :next)
	  application-next
	  (foreign-slot-value app-info '(:struct vk-application-info) :app-name)
	  application-name
	  (foreign-slot-value app-info '(:struct vk-application-info) :app-version)
	  application-version
	  (foreign-slot-value app-info '(:struct vk-application-info) :engine-name)
	  engine-name
	  (foreign-slot-value app-info '(:struct vk-application-info) :engine-version)
	  engine-version
	  (foreign-slot-value app-info '(:struct vk-application-info) :api-version)
	  api-version)
    (let* ((usable-extensions (get-instance-extensions))
	   (use-extensions (intersection usable-extensions extensions)))
      ;;covert lisp string to c string pointer
      (loop for extension in use-extensions
	    for i from 0 upto (1- (length use-extensions))
	    do
	       (setf (mem-ref instance-extensions '(:pointer :string) i) extension))
      (loop for layer in layers
	    for i from 0 upto (1- (length layers))
	    do
	       (setf (mem-ref instance-layers '(:pointer :string) i) layer))
      ;;setf struct VkInstanceCreaetInfo
      (setf (foreign-slot-value instance-info '(:struct vk-instance-create-info) :type)
	    :structure-type-instance-create-info
	    (foreign-slot-value instance-info '(:struct vk-instance-create-info) :next)
	    instance-next
	    (foreign-slot-value instance-info '(:struct vk-instance-create-info) :flags)
	    instance-flags
	    (foreign-slot-value instance-info '(:struct vk-instance-create-info) :info)
	    app-info
	    (foreign-slot-value instance-info '(:struct vk-instance-create-info) :layer-count)
	    (length layers)
	    (foreign-slot-value instance-info '(:struct vk-instance-create-info) :layers)
	    instance-layers
	    (foreign-slot-value instance-info '(:struct vk-instance-create-info) :extension-count)
	    (length extensions)
	    (foreign-slot-value instance-info '(:struct vk-instance-create-info) :extensions)
	    instance-extensions)
      (check-reslute-type (VkCreateInstance instance-info allocator instance))
      (mem-ref instance 'vk-instance))))

(defmacro with-instance ((instance &key
				     (instance-next nil)
				     (instance-flags 0)
				     (application-next nil)
				     (application-name "Vkle test")
				     (application-version (make-vulkan-version 0 0 0))
				     (engine-name "Vkle test")
				     (engine-version (make-vulkan-version 0 0 0))
				     (api-version (make-vulkan-version))
				     (extensions nil)
				     (layers nil)
				     (allocator nil))
			 &body body)
  `(let ((,instance (create-instance :instance-next ,instance-next
				     :instance-flags ,instance-flags
				     :application-next ,application-next
				     :application-name ,application-name
				     :application-version ,application-version
				     :engine-name ,engine-name
				     :engine-version ,engine-version
				     :api-version ,api-version
				     :extensions ,extensions
				     :layers ,layers
				     :allocator ,allocator)))
       ,@body
       (destroy-instance ,instance (null-pointer))))

(defcfun ("vkEnumeratePhysicalDevices" vkEnumeratePhysicalDevices) VkResult
  (instance vk-instance)
  (count (:pointer :uint32))
  (physical-devices (:pointer vk-physical-device)))

(defun enumerate-physical-devices (instance)
  (with-foreign-object (count :uint32)
    (check-reslute-type (vkEnumeratephysicaldevices instance count (null-pointer)))
    (let ((ct (mem-ref count :uint32)))
      (assert (plusp ct))
      (with-foreign-object (physical-devices 'vk-physical-device ct)
	(check-reslute-type (vkEnumeratephysicaldevices instance count physical-devices))
	(loop for i from 0 upto (1- ct)
	      collect (mem-aref physical-devices 'vk-physical-device i))))))

(defcfun ("vkGetPhysicalDeviceProperties" vkGetPhysicalDeviceProperties) :void
  (physical-device vk-physical-device)
  (properties (:pointer (:struct vk-physical-device-properties))))

(defun get-physical-device-properties (physical-device)
  (with-foreign-object (properties '(:struct vk-physical-device-properties))
    (VkGetPhysicalDeviceProperties physical-device properties)
    (mem-ref properties '(:struct vk-physical-device-properties))))

(defcfun ("vkGetPhysicalDeviceQueueFamilyProperties" vkGetPhysicalDeviceQueueFamilyProperties) :void
  (physical-device vk-physical-device)
  (count (:pointer :uint32))
  (queue-family-properties (:pointer (:struct vk-queue-family-properties))))

(defun get-physical-device-queue-family-properties (physical-device)
  (with-foreign-object (count :uint32)
    (vkGetPhysicalDeviceQueueFamilyProperties physical-device count (null-pointer))
    (let ((ct (mem-ref count :uint32)))
      (assert (plusp ct))
      (with-foreign-object (queue-families '(:struct vk-queue-family-properties) ct)
	(vkGetPhysicalDeviceQueueFamilyProperties physical-device count queue-families)
	(loop for i from 0 upto (1- ct)
	      collect (mem-aref queue-families '(:struct vk-queue-family-properties) i))))))

(defun get-physical-device-memory-properties (physical-device)
  (with-foreign-object (memory-properties '(:struct vk-physical-device-memory-properties))
    (foreign-funcall "vkGetPhysicalDeviceMemoryProperties"
		     vk-physical-device physical-device
		     (:pointer (:struct vk-physical-device-memory-properties)) memory-properties
		     :void)
    (mem-ref memory-properties '(:struct vk-physical-device-memory-properties))))

(defun get-physical-device-features (physical-device)
  (with-foreign-object (physical-device-features '(:struct vk-physical-device-features))
    (foreign-funcall "vkGetPhysicalDeviceFeatures"
		     vk-physical-device physical-device
		     (:pointer (:struct vk-physical-device-features)) physical-device-features
		     :void)
    (mem-ref physical-device-features '(:struct vk-physical-device-features))))

(defcfun ("vkGetPhysicalDeviceFormatProperties" vkGetPhysicalDeviceFormatProperties) :void
  (physical-device vk-physical-device)
  (format VkFormat)
  (format-properties (:pointer (:struct vk-format-properties))))

(defun get-physical-device-format-properties (physical-device format)
  (with-foreign-object (format-properties '(:struct vk-format-properties))
    (vkGetPhysicalDeviceFormatProperties physical-device format format-properties)
    (mem-ref format-properties '(:struct vk-format-properties))))

(defun get-physical-device-image-format-properties (physical-device format type tiling usage flags)
  (with-foreign-object (image-format-properties '(:struct vk-image-format-properties))
    (check-reslute-type (foreign-funcall "vkGetPhysicalDeviceImageFormatProperties"
					 vk-physical-device physical-device
					 VkFormat format
					 VkImageType type
					 VkImageTiling tiling
					 VkImageUsageFlagBits usage
					 vk-image-create-flags flags
					 (:pointer (:struct vk-image-format-properties)) image-format-properties
					 VkResult))
    (mem-ref image-format-properties '(:struct vk-image-format-properties))))

(defcfun ("vkCreateDevice" vkCreateDevice) VkResult
  (physical-device vk-physical-device)
  (create-info (:pointer (:struct vk-device-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (device (:pointer vk-device)))

(defcfun ("vkDestroyDevice" destroy-device) :void
  (device vk-device)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defun create-device (physical-device &key
					(next nil)
					(flags 0)
					(queue-create-infos nil)
					(layers nil)
					(extensions nil)
					(enable-features 1.0)
					(allocator nil))
  (let ((queue-count (length queue-create-infos)))
    (with-foreign-objects ((device 'vk-device)
			   (queues '(:struct vk-device-queue-create-info) queue-count)
			   (queue-properties :float queue-count)
			   (device-create-info '(:struct vk-device-create-info))
			   (device-extensions '(:pointer :string))
			   (device-layers '(:pointer :string))
			   (device-features '(:pointer :float)))
      (if (null queue-create-infos)
	  (setf queues (null-pointer))
	  (loop for lqueue in queue-create-infos
		for i from 0
		for cqueue = (mem-aref queues '(:struct vk-device-queue-create-info) i)
		do
		   (progn
		     (setf (foreign-slot-value cqueue '(:struct vk-device-queue-create-info) :type)
			   :structure-type-device-queue-create-info)
		     (loop for (key val) in lqueue
			   when (null val)
			     do
				(setf val (null-pointer))
			   when (eql key :queue-properties)
			     do
				(setf (mem-aref queue-properties :float i) val
				      val (mem-aref queue-properties :float i))
			   do
			      (setf (foreign-slot-value cqueue '(:struct vk-device-queue-create-info) key) val)))))
      (when (null next)
	(setf next (null-pointer)))
      (when (null layers)
	(setf device-layers (null-pointer)))
      (when (null extensions)
	(setf device-extensions (null-pointer)))
      (when (null allocator)
	(setf allocator (null-pointer)))
      (setf (mem-ref device-features :float) enable-features)
      (loop for layer in layers
	    for i from 0
	    do
	       (setf (mem-ref device-layers '(:pointer :string) i) layer))
      (loop for extension in extensions
	    for i from 0
	    do
	       (setf (mem-ref device-extensions '(:pointer :string) i) extension))
      (setf (foreign-slot-value device-create-info '(:struct vk-device-create-info) :type)
	    :structure-type-device-create-info
	    (foreign-slot-value device-create-info '(:struct vk-device-create-info) :next)
	    next
	    (foreign-slot-value device-create-info '(:struct vk-device-create-info) :flags)
	    flags
	    (foreign-slot-value device-create-info '(:struct vk-device-create-info) :queue-create-info-count)
	    (length queue-create-infos)
	    (foreign-slot-value device-create-info '(:struct vk-device-create-info) :queue-create-infos)
	    queues
	    (foreign-slot-value device-create-info '(:struct vk-device-create-info) :layer-count)
	    (length layers)
	    (foreign-slot-value device-create-info '(:struct vk-device-create-info) :layers)
	    device-layers
	    (foreign-slot-value device-create-info '(:struct vk-device-create-info) :extension-count)
	    (length extensions)
	    (foreign-slot-value device-create-info '(:struct vk-device-create-info) :extensions)
	    device-extensions
	    (foreign-slot-value device-create-info '(:struct vk-device-create-info) :enable-features)
	    device-features)
      (check-reslute-type (vkCreateDevice physical-device device-create-info allocator device))
      (mem-ref device 'vk-device))))

(defmacro with-device ((device physical-device &key
						 (next nil)
						 (flags 0)
						 (queue-create-infos nil)
						 (layers nil)
						 (extensions nil)
						 (enable-features 1.0)
						 (allocator nil))
		       &body body)
  `(let ((,device (create-device ,physical-device :next ,next
						  :flags ,flags
						  :queue-create-infos ,queue-create-infos
						  :layers ,layers
						  :extensions ,extensions
						  :enable-features ,enable-features
						  :allocator ,allocator)))
     ,@body
     (destroy-device ,device (null-pointer))))


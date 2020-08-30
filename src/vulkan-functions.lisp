(in-package :vkle)

(export '(make-vulkan-version
	  create-instance
	  destroy-instance
	  with-instance
	  enumerate-physical-devices
	  get-instance-extensions
	  get-physical-device-properties
	  get-physical-device-queue-family-properties
	  get-physical-device-memory-properties
	  get-physical-device-features
	  get-physical-device-format-properties
	  get-physical-device-image-format-properties
	  create-device
	  destroy-device
	  with-device
	  enumerate-instance-version
	  enumerate-instance-layer-properties
	  enumerate-instance-extension-properties
	  enumerate-device-layer-properties
	  enumerate-device-extesnion-properties
	  get-device-queue
	  queue-submit
	  queue-wait-idle
	  device-wait-idle
	  allocate-memory
	  free-memory
	  create-surface-khr
	  destroy-surface-khr
	  with-surface
	  map-memory
	  unmap-memory
	  flush-mapped-memory-ranges
	  invalidate-mapped-memory-rannges
	  get-device-memory-commitment
	  get-buffer-memory-requirements
	  bind-buffer-memory
	  get-image-memory-requirememt
	  bind-image-memory
	  get-image-sparse-memory-requirements
	  get-physical-device-sparse-image-format-properties
	  queue-bind-sparse
	  create-fence
	  destroy-fence
	  reset-fence
	  get-fence-status
	  wait-for-fence
	  create-semaphore
	  destroy-semaphore
	  create-event
	  destroy-evnet
	  get-event-status
	  set-event
	  reset-event
	  create-query-pool
	  destroy-query-pool
	  get-query-pool-results
	  reset-query-pool
	  with-query-pool
	  create-buffer
	  destroy-buffer
	  create-buffer-view
	  destroy-buffer-view
	  create-image
	  destroy-image
	  get-image-subresource-layout
	  create-image-view
	  destroy-image-view
	  create-sharder-module
	  destroy-shader-module
	  create-pipeline-cache
	  destroy-pipeline-cache
	  get-pipeline-cache-data
	  merge-pipeline-caches
	  create-graphics-pipelines
	  create-compute-pipelines
	  destroy-pipeline))

(defun check-reslute-type (ret-val)
  (when (not (eql ret-val :success))
    (error ret-val)))

(defun make-vulkan-version (&optional (major 1) (minor 2) (patch 0))
  (logior (ash major 22)
	  (ash minor 12)
	  patch))

#|
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

(defcfun ("glfwGetPhysicalDevicePresentationSupport" queue-family-index-support-present-p) :int
  (instance vk-handle)
  (physical-device vk-handle)
  (index :uint32))

(defcfun ("vkCreateInstance" vkCreateInstance) VkResult
  (instance-create-info (:pointer (:struct vk-instance-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (instance (:pointer vk-instance)))

(defun destroy-instance (instance &optional (allocator nil))
  (when (null allocator)
    (setf allocator (null-pointer)))
  (foreign-funcall "vkDestroyInstance"
		   vk-instance instance
		   (:pointer (:struct vk-allocation-callback)) allocator
		   :void))

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
			  (extensions nil)   ;;as default use glfw get the extension
			  (layers nil)
			  (allocator nil))
  (with-foreign-objects ((app-info '(:struct vk-application-info))
			 (instance-info '(:struct vk-instance-create-info))
			 (instance 'vk-instance)
			 (instance-layers :string)
			 (instance-extensions :string))
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
	   (use-extensions (intersection usable-extensions extensions :test #'string=))
	   (extension-count (length use-extensions))
	   (use-layers (get-support-layers layers (enumerate-instance-layer-properties)))
	   (layer-count (length use-layers)))
      ;;covert lisp string to c string pointer
      (loop for extension in use-extensions
	    for i from 0 
	    do
	       (setf (mem-aref instance-extensions :string i) extension))
      (loop for layer in use-layers
	    for i from 0 
	    do
	       (setf (mem-aref instance-layers :string i) layer))
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
	    layer-count
	    (foreign-slot-value instance-info '(:struct vk-instance-create-info) :layers)
	    instance-layers
	    (foreign-slot-value instance-info '(:struct vk-instance-create-info) :extension-count)
	    extension-count
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
       (destroy-instance ,instance)))

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

(defun get-physical-device-features (physical-device &optional (get-pointer nil))
  (with-foreign-object (physical-device-features '(:struct vk-physical-device-features))
    (foreign-funcall "vkGetPhysicalDeviceFeatures"
		     vk-physical-device physical-device
		     (:pointer (:struct vk-physical-device-features)) physical-device-features
		     :void)
    (if get-pointer
	physical-device-features
	(mem-ref physical-device-features '(:struct vk-physical-device-features)))))

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

(defun destroy-device (device &optional (allocator nil))
  (when (null allocator)
    (setf allocator (null-pointer)))  
  (foreign-funcall "vkDestroyDevice"
		   vk-device device
		   (:pointer (:struct vk-allocation-callback)) allocator
		   :void))

(defun create-device (physical-device &key
					(next nil)
					(flags 0)
					(queue-create-infos nil)
					(layers nil)
					(extensions nil)
					(allocator nil))
  (let ((queue-count (length queue-create-infos)))
    (with-foreign-objects ((device 'vk-device)
			   (queues '(:struct vk-device-queue-create-info) queue-count)
			   (queue-properties :float queue-count)
			   (device-create-info '(:struct vk-device-create-info))
			   (device-extensions :string)
			   (device-layers :string))
      (if (null queue-create-infos)
	  (setf queues (null-pointer))
	  (loop for lqueue in queue-create-infos
		for i from 0
		for cqueue = (mem-aptr queues '(:struct vk-device-queue-create-info) i)
		do
		   (create-device-queue lqueue cqueue)))
      (let* ((usable-layers (get-support-layers layers (enumerate-device-layer-properties physical-device)))
	     (usable-extensions-t (loop for l in usable-layers
					collect (get-support-extensions extensions (enumerate-device-extesnion-properties physical-device l))))
	     (usable-extensions (apply #'append usable-extensions-t))
	     (enable-features (get-physical-device-features physical-device t))
	     (enable-layer-count (length usable-layers))
	     (enable-extension-count (length usable-extensions)))
	(when (null next)
	  (setf next (null-pointer)))
	(if (null usable-layers)
	    (setf device-layers (null-pointer))
	    (loop for layer in usable-layers
		  for i from 0
		  do
		     (setf (mem-aref device-layers :string i) layer)))
	(if (null usable-extensions)
	    (setf device-extensions (null-pointer))
	    (loop for extension in (remove-duplicates usable-extensions :test #'string=)
		  for i from 0
		  do
		     (setf (mem-aref device-extensions :string i) extension)))
	(when (null allocator)
	  (setf allocator (null-pointer)))
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
	      enable-layer-count
	      (foreign-slot-value device-create-info '(:struct vk-device-create-info) :layers)
	      device-layers
	      (foreign-slot-value device-create-info '(:struct vk-device-create-info) :extension-count)
	      enable-extension-count
	      (foreign-slot-value device-create-info '(:struct vk-device-create-info) :extensions)
	      device-extensions
	      (foreign-slot-value device-create-info '(:struct vk-device-create-info) :enable-features)
	      enable-features)
	(check-reslute-type (vkCreateDevice physical-device device-create-info allocator device))
	(mem-ref device 'vk-device)))))

(defmacro with-device ((device physical-device &key
						 (next nil)
						 (flags 0)
						 (queue-create-infos nil)
						 (layers nil)
						 (extensions nil)
						 (allocator nil))
		       &body body)
  `(let ((,device (create-device ,physical-device :next ,next
						  :flags ,flags
						  :queue-create-infos ,queue-create-infos
						  :layers ,layers
						  :extensions ,extensions
						  :allocator ,allocator)))
     ,@body
     (destroy-device ,device)))

(defun enumerate-instance-version ()
  (with-foreign-object (api-version :uint32)
    (check-reslute-type (foreign-funcall "vkEnumerateInstanceVersion"
					 :pointer api-version
					 VkResult))
    (mem-ref api-version :uint32)))

(defcfun ("vkEnumerateInstanceLayerProperties" vkEnumerateInstanceLayerProperties) VkResult
  (count (:pointer :uint32))
  (properties (:pointer (:struct vk-layer-properties))))

(defun enumerate-instance-layer-properties ()
  (with-foreign-object (count :uint32)
    (check-reslute-type (vkEnumerateInstanceLayerProperties count (null-pointer)))
    (let ((ct (mem-ref count :uint32)))
      (with-foreign-object (properties '(:struct vk-layer-properties) ct)
	(check-reslute-type (vkEnumerateInstanceLayerProperties count properties))
	(let ((props (loop for i upto (1- ct)
			   collect (mem-aref properties '(:struct vk-layer-properties) i))))
	  (loop for p in props
		for i upto (1- ct)
		do
		   (setf (getf p :description)
			 (c-array-to-lisp-string (foreign-slot-value (mem-aptr properties '(:struct vk-layer-properties) i) '(:struct vk-layer-properties) :description) 256)
			 (getf p :layer-name)
			 (c-array-to-lisp-string (foreign-slot-value (mem-aptr properties '(:struct vk-layer-properties) i) '(:struct vk-layer-properties) :layer-name) 256))
		finally
		   (return props)))))))

(defcfun ("vkEnumerateInstanceExtensionProperties" vkEnumerateInstanceExtensionProperties) VkResult
  (layer-name :string)
  (count (:pointer :uint32))
  (properties (:pointer (:struct vk-extension-properties))))

(defun enumerate-instance-extension-properties (layer-name)
  (with-foreign-objects ((count :uint32)
			 (properties '(:struct vk-extension-properties)))
    (with-foreign-pointer-as-string (name (length layer-name))
      (lisp-string-to-foreign layer-name name (length layer-name))
      (check-reslute-type (vkEnumerateInstanceExtensionProperties layer-name count (null-pointer)))
      (let ((ct (mem-ref count :uint32)))
	(check-reslute-type (vkEnumerateInstanceExtensionProperties layer-name count properties))
	(let ((props (loop for i upto (1- ct)
			   collect (mem-aref properties '(:struct vk-extension-properties) i))))
	  (loop for p in props
		for i upto (1- ct)
		do
		   (setf (getf p :extension-name)
			 (c-array-to-lisp-string (foreign-slot-value (mem-aptr properties '(:struct vk-extension-properties) i) '(:struct vk-extension-properties) :extension-name) 256))
		finally
		   (return props)))))))

(defcfun ("vkEnumerateDeviceLayerProperties" vkEnumerateDeviceLayerProperties) VkResult
  (physical-device vk-physical-device)
  (count (:pointer :uint32))
  (properties (:pointer (:struct vk-layer-properties))))

(defun enumerate-device-layer-properties (physical-device)
  (with-foreign-objects ((count :uint32)
			 (properties '(:struct vk-layer-properties)))
    (check-reslute-type (vkEnumerateDeviceLayerProperties physical-device count (null-pointer)))
    (let ((ct (mem-aref count :uint32)))
      (when (zerop ct)
	(return-from enumerate-device-layer-properties nil)) 
      (check-reslute-type (vkEnumerateDeviceLayerProperties physical-device count properties))
      (let ((props (loop for i upto (1- ct)
			 collect (mem-aref properties '(:struct vk-layer-properties) i))))
	(loop for p in props
	      for i upto (1- ct)
	      do
		 (setf (getf p :description)
		       (c-array-to-lisp-string (foreign-slot-value (mem-aptr properties '(:struct vk-layer-properties) i) '(:struct vk-layer-properties) :description) 256)
		       (getf p :layer-name)
		       (c-array-to-lisp-string (foreign-slot-value (mem-aptr properties '(:struct vk-layer-properties) i) '(:struct vk-layer-properties) :layer-name) 256))
	      finally
		 (return props))))))
  
(defcfun ("vkEnumerateDeviceExtensionProperties" vkEnumerateDeviceExtensionProperties) VkResult
  (physical-device vk-physical-device)
  (layer-name :string)
  (count (:pointer :uint32))
  (properties (:pointer (:struct vk-extension-properties))))

(defun enumerate-device-extesnion-properties (physical-device layer-name)
  (with-foreign-objects ((count :uint32)
			 (properties '(:struct vk-extension-properties)))
    (with-foreign-pointer-as-string (name (length layer-name))
      (lisp-string-to-foreign layer-name name (length layer-name))
      (check-reslute-type (vkEnumerateDeviceExtensionProperties physical-device name count (null-pointer)))
      (let ((ct (mem-ref count :uint32)))
	(when (zerop ct)
	  (return-from enumerate-device-extesnion-properties nil))
	(check-reslute-type (vkEnumerateDeviceExtensionProperties physical-device name count properties))
	(let ((props (loop for i upto (1- ct)
			   collect (mem-aref properties '(:struct vk-extension-properties) i))))
	  (loop for p in props
		for i upto (1- ct)
		do
		   (setf (getf p :extension-name)
			 (c-array-to-lisp-string (foreign-slot-value (mem-aptr properties '(:struct vk-extension-properties) i) '(:struct vk-extension-properties) :extension-name) 255))
		finally
		   (return props)))))))

(defun get-device-queue (device queue-family-index queue-index)
  (with-foreign-object (queue 'vk-queue)
    (foreign-funcall "vkGetDeviceQueue"
		     vk-device device
		     :uint32 queue-family-index
		     :uint32 queue-index
		     (:pointer vk-queue) queue
		     :void)
    (mem-ref queue 'vk-queue)))

(defun queue-submit (&key queue
		       submit-count
		       fence
		       (next nil)
		       (p-wait-semaphores nil)
		       (p-wait-dst-stage-masks nil)
		       (command-buffer-count 0)
		       (p-command-buffers nil)
		       (signal-semaphore-count 0)
		       (p-signal-semaphores nil))
  "submit-info is a list"
  (with-foreign-object (info '(:struct vk-submit-info))
    (when (null p-wait-semaphores)
      (setf p-wait-semaphores (null-pointer)))
    (when (null p-wait-dst-stage-masks)
      (setf p-wait-dst-stage-masks (null-pointer)))
    (when (null p-command-buffers)
      (setf p-command-buffers (null-pointer)))
    (when (null p-signal-semaphores)
      (setf p-signal-semaphores (null-pointer)))
    (when (null next)
      (setf next (null-pointer)))
    (setf (foreign-slot-value info '(:struct vk-submit-info) :type)
	  :structure-type-submit-info
	  (foreign-slot-value info '(:struct vk-submit-info) :next)
	  next
	  (foreign-slot-value info '(:struct vk-submit-info) :wait-semaphores)
	  p-wait-semaphores
	  (foreign-slot-value info '(:struct vk-submit-info) :wait-dst-stage-masks)
	  p-wait-dst-stage-masks
	  (foreign-slot-value info '(:struct vk-submit-info) :command-buffer-count)
	  command-buffer-count
	  (foreign-slot-value info '(:struct vk-submit-info) :command-buffers)
	  p-command-buffers
	  (foreign-slot-value info '(:struct vk-submit-info) :signal-semaphore-count)
	  signal-semaphore-count
	  (foreign-slot-value info '(:struct vk-submit-info) :signal-semaphores)
	  p-signal-semaphores)
    (check-reslute-type (foreign-funcall "vkQueueSubmit"
					 vk-queue queue
					 :uint32 submit-count
					 (:pointer (:struct vk-submit-info)) info
					 vk-fence fence
					 VkResult))))

(defun queue-wait-idle (queue)
  (check-reslute-type (foreign-funcall "vkQueueWaitIdle"
				       vk-queue queue
				       VkResult)))

(defun device-wait-idle (device)
  (check-reslute-type (foreign-funcall "vkDeviceWaitIdle"
				       vk-device device
				       VkResult)))

(defun allocate-memory (device &key
				 (next nil)
				 (allocation-size 0)
				 (memory-type-index 0)
				 (allocator nil))
  (when (null next)
    (setf next (null-pointer)))
  (when (null allocator)
    (setf allocator (null-pointer)))
  (with-foreign-objects ((info '(:struct vk-memory-allocate-info))
			 (memory 'vk-device-memory))
    (setf (foreign-slot-value info '(:struct vk-memory-allocate-info) :type)
	  :structure-type-memory-allocate-info
	  (foreign-slot-value info '(:struct vk-memory-allocate-info) :next)
	  next
	  (foreign-slot-value info '(:struct vk-memory-allocate-info) :allocation-size)
	  allocation-size
	  (foreign-slot-value info '(:struct vk-memory-allocate-info) :memory-type-index)
	  memory-type-index)
    (check-reslute-type (foreign-funcall "vkAllocateMemory"
					 vk-device device
					 (:pointer (:struct vk-memory-allocate-info)) info
					 (:pointer (:struct vk-allocation-callback)) allocator
					 (:pointer vk-device-memory) memory
					 VkResult))
    (mem-ref memory 'vk-device-memory)))

(defun free-memory (device memory &optional (allocator nil))
  (when (null allocator)
    (setf allocator (null-pointer)))
  (foreign-funcall "vkFreeMemory"
		   vk-device device
		   vk-device-memory memory
		   (:pointer (:struct vk-allocation-callback)) allocator
		   :void))

(defun map-memory (device memory offset size flags)
  (with-foreign-object (data '(:pointer :void))
    (check-reslute-type (foreign-funcall "vkMapMemory"
					 vk-device device
					 vk-device-memory memory
					 vk-device-size offset
					 vk-device-size size
					 vk-memory-map-flags flags
					 (:pointer (:pointer :void)) data
					 VkResult))))

(defun unmap-memory (device memory)
  (foreign-funcall "vkUnmapMemory"
		   vk-device device
		   vk-device-memory memory
		   :void))

(defun flush-mapped-memory-ranges (device memory-range-count memory offset size &key (next nil))
  (with-foreign-object (memory-ranges '(:struct vk-mapped-memory-range))
    (when (null next)
      (setf next (null-pointer)))
    (setf (foreign-slot-value memory-ranges '(:struct vk-mapped-memory-range) :type)
	  :structure-type-mapped-memory-range
	  (foreign-slot-value memory-ranges '(:struct vk-mapped-memory-range) :next)
	  next
	  (foreign-slot-value memory-ranges '(:struct vk-mapped-memory-range) :memory)
	  memory
	  (foreign-slot-value memory-ranges '(:struct vk-mapped-memory-range) :offset)
	  offset
	  (foreign-slot-value memory-ranges '(:struct vk-mapped-memory-range) :size)
	  size)
    (check-reslute-type (foreign-funcall "vkFlushMappedMemoryRanges"
					 vk-device device
					 :uint32 memory-range-count
					 (:pointer (:struct vk-mapped-memory-range)) memory-ranges
					 VkResult))))

(defun invalidate-mapped-memory-rannges (device memory-range-count memory offset size &key (next nil))
  (with-foreign-object (memory-ranges '(:struct vk-mapped-memory-range))
    (when (null next)
      (setf next (null-pointer)))
    (setf (foreign-slot-value memory-ranges '(:struct vk-mapped-memory-range) :type)
	  :structure-type-mapped-memory-range
	  (foreign-slot-value memory-ranges '(:struct vk-mapped-memory-range) :next)
	  next
	  (foreign-slot-value memory-ranges '(:struct vk-mapped-memory-range) :memory)
	  memory
	  (foreign-slot-value memory-ranges '(:struct vk-mapped-memory-range) :offset)
	  offset
	  (foreign-slot-value memory-ranges '(:struct vk-mapped-memory-range) :size)
	  size)
    (check-reslute-type (foreign-funcall "vkInvalidateMappedMemoryRanges"
					 vk-device device
					 :uint32 memory-range-count
					 (:pointer (:struct vk-mapped-memory-range)) memory-ranges
					 VkResult))))

(defun get-device-memory-commitment (device memory)
  (with-foreign-object (committed-memory-in-bytes 'vk-device-size)
    (foreign-funcall "vkGetDeviceMemoryCommitment"
		     vk-device device
		     vk-device-memory memory
		     (:pointer vk-device-size) committed-memory-in-bytes)
    (mem-ref committed-memory-in-bytes 'vk-device-size)))

(defun get-buffer-memory-requirements (device buffer)
  (with-foreign-object (memory-requirements '(:struct vk-memory-requirements))
    (foreign-funcall "vkGetBufferMemoryRequirements"
		     vk-device device
		     vk-buffer buffer
		     (:pointer (:struct vk-memory-requirements)) memory-requirements)
    (mem-ref memory-requirements '(:struct vk-memory-requirements))))

(defun bind-buffer-memory (device buffer memory memory-offset)
  (check-reslute-type (foreign-funcall "vkBindBufferMemory"
				       vk-device device
				       vk-buffer buffer
				       vk-device-memory memory
				       vk-device-size memory-offset)))

(defun get-image-memory-requirememt (device image)
  (with-foreign-object (image-requirement '(:struct vk-memory-requirements))
    (foreign-funcall "vkGetImageMemoryRequirements"
		     vk-device device
		     vk-image image
		     (:pointer (:struct vk-memory-requirements)) image-requirement
		     :void)
    (mem-ref image-requirement '(:struct vk-memory-requirements))))

(defun bind-image-memory (device image memory memory-offset)
  (check-reslute-type (foreign-funcall "vkBindImageMemory"
				       vk-device device
				       vk-image image
				       vk-device-memory memory
				       vk-device-size memory-offset
				       VkResult)))

(defcfun ("vkGetImageSparseMemoryRequirements" vkGetImageSparseMemoryRequirements) :void
  (device vk-device)
  (image vk-image)
  (count (:pointer :uint32))
  (sparse-memory-requirements (:pointer (:struct vk-sparse-image-memory-requirements))))

(defun get-image-sparse-memory-requirements (device image)
  (with-foreign-object (count :uint32)
    (vkGetImageSparseMemoryRequirements device image count (null-pointer))
    (let ((ct (mem-ref count :uint32)))
      (with-foreign-object (sparse-memory-requirements '(:struct vk-sparse-image-memory-requirements) ct)
	(vkGetImageSparseMemoryRequirements device image count sparse-memory-requirements)
	(loop for i from 0 upto (1- ct)
	      collect (mem-aref sparse-memory-requirements '(:struct vk-sparse-image-memory-requirements) i))))))

(defcfun ("vkGetPhysicalDeviceSparseImageFormatProperties" vkGetPhysicalDeviceSparseImageFormatProperties) :void
  (physical-device vk-physical-device)
  (format VkFormat)
  (type VkImageType)
  (samples VkSampleCountFlagBits)
  (usage vk-image-usage-flags)
  (tiling VkImageTiling)
  (count (:pointer :uint32))
  (properties (:pointer (:struct vk-sparse-image-format-properties))))

(defun get-physical-device-sparse-image-format-properties (physical-device format type samples usage tiling)
  (with-foreign-object (count :uint32)
    (vkGetPhysicalDeviceSparseImageFormatProperties physical-device format type samples usage tiling count (null-pointer))
    (let ((ct (mem-ref count :uint32)))
      (with-foreign-object (properties '(:struct vk-sparse-image-format-properties))
	(vkGetPhysicalDeviceSparseImageFormatProperties physical-device format type samples usage tiling count properties)
	(loop for i from 0 upto (1- ct)
	      collect (mem-aref properties i))))))

(defun queue-bind-sparse (queue count fence &key
					      (next nil)
					      (wait-semaphores-lst nil)
					      (buffer-binds-lst nil)
					      (image-opaque-binds-lst nil)
					      (image-binds-lst nil)
					      (signal-semaphores-lst nil))
  (let ((bind-info (create-bind-sparse-info :next next
					    :wait-semaphores-lst wait-semaphores-lst
					    :buffer-binds-lst buffer-binds-lst
					    :image-opaque-binds-lst image-opaque-binds-lst
					    :image-binds-lst image-binds-lst
					    :signal-semaphores-lst signal-semaphores-lst)))
    (check-reslute-type (foreign-funcall "vkQueueBindSparse"
					 vk-queue queue
					 :uint32 count
					 (:pointer (:struct vk-bind-sparse-info)) bind-info
					 vk-fence fence
					 VkResult))))

(defcfun ("vkCreateFence" vkCreateFence) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-fence-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (fence (:pointer vk-fence)))

(defun create-fence (device &key
			      (info-next nil)
			      (info-flags 0)
			      (allocator nil))
  (with-foreign-objects ((info '(:struct vk-fence-create-info))
			 (fence 'vk-fence))
    (when (null info-next)
      (setf info-next (null-pointer)))
    (when (null allocator)
      (setf allocator (null-pointer)))
    (setf (foreign-slot-value info '(:struct vk-fence-create-info) :type)
	  :structure-type-fence-create-info
	  (foreign-slot-value info '(:struct vk-fence-create-info) :next)
	  info-next
	  (foreign-slot-value info '(:struct vk-fence-create-info) :flags)
	  info-flags)
    (check-reslute-type (vkCreateFence device info allocator fence))
    (mem-ref fence 'vk-fence)))

(defun destroy-fence (device fence &optional (allocator nil))
  (when (null allocator)
    (setf allocator (null-pointer)))
  (foreign-funcall "vkDestroyFence"
		   vk-device device
		   vk-fence fence
		   (:pointer (:struct vk-allocation-callback)) allocator))

(defun reset-fence (device fence-list)
  (with-foreign-object (fences 'vk-fence (length fence-list))
    (loop for fence in fence-list
	  for i from 0
	  do
	     (setf (mem-ref fences 'vk-fence i) fence))
    (check-reslute-type (foreign-funcall "vkResetFences"
					 vk-device device
					 :uint32 (length fence-list)
					 (:pointer vk-fence) fences
					 VkResult))))

(defun get-fence-status (device fence)
  (check-reslute-type (foreign-funcall "vkGetFenceStatus"
				       vk-device device
				       vk-fence fence
				       VkResult)))

(defun wait-for-fence (device fence-list &key
					   (wait-all 0)
					   (timeout 1000))
  (with-foreign-object (fences 'vk-fence (length fence-list))
    (loop for fence in fence-list
	  for i from 0
	  do
	     (setf (mem-ref fences 'vk-fence i) fence))
    (check-reslute-type (foreign-funcall "vkWaitForFences"
					 vk-device device
					 :unsigned-int (length fence-list)
					 (:pointer vk-fence) fences
					 vk-bool-32 wait-all
					 :uint64 timeout
					 VkResult))))

(defun create-semaphore (device &key
				  (info-next nil)
				  (info-flags 0)
				  (allocator nil))
  (with-foreign-objects ((info '(:struct vk-semaphore-create-info))
			 (semaphore 'vk-semaphore))
    (when (null info-next)
      (setf info-next (null-pointer)))
    (when (null allocator)
      (setf allocator (null-pointer)))   
    (setf (foreign-slot-value info '(:struct vk-semaphore-create-info) :type)
	  :structure-type-semaphore-create-info
	  (foreign-slot-value info '(:struct vk-semaphore-create-info) :next)
	  info-next
	  (foreign-slot-value info '(:struct vk-semaphore-create-info) :flags)
	  info-flags)
    (check-reslute-type (foreign-funcall "vkCreateSemaphore"
					 vk-device device
					 (:pointer (:struct vk-semaphore-create-info)) info
					 (:pointer (:struct vk-allocation-callback)) allocator
					 (:pointer vk-semaphore) semaphore
					 VkResult))
    (mem-ref semaphore 'vk-semaphore)))

(defun destroy-semaphore (device semaphore &optional (allocator nil))
  (when (null allocator)
    (setf allocator (null-pointer)))
  (foreign-funcall "vkDestroySemaphore"
		   vk-device device
		   vk-semaphore semaphore
		   (:pointer (:struct vk-allocation-callback)) allocator
		   :void))

(defun create-event (device &key
			      (info-next nil)
			      (info-flags 0)
			      (allocator nil))
  (with-foreign-objects ((info '(:struct vk-event-create-info))
			 (event 'vk-event))
    (when (null info-next)
      (setf info-next (null-pointer)))
    (when (null allocator)
      (setf allocator (null-pointer)))   
    (setf (foreign-slot-value info '(:struct vk-event-create-info) :type)
	  :structure-type-event-create-info
	  (foreign-slot-value info '(:struct vk-event-create-info) :next)
	  info-next
	  (foreign-slot-value info '(:struct vk-event-create-info) :flags)
	  info-flags)
    (check-reslute-type (foreign-funcall "vkCreateEvent"
					 vk-device device
					 (:pointer (:struct vk-event-create-info)) info
					 (:pointer (:struct vk-allocation-callback)) allocator
					 (:pointer vk-event) event
					 VkResult))
    (mem-ref event 'vk-event)))

(defun destroy-evnet (device event &optional (allocator nil))
  (when (null allocator)
    (setf allocator (null-pointer)))
  (foreign-funcall "vkDestroyEvent"
		   vk-device device
		   vk-event event
		   (:pointer (:struct vk-allocation-callback)) allocator
		   :void))

(defun get-event-status (device event)
  (check-reslute-type (foreign-funcall "vkGetEventStatus"
				       vk-device device
				       vk-event event
				       VkResult)))

(defun set-event (device event)
  (check-reslute-type (foreign-funcall "vkSetEvent"
				       vk-device device
				       vk-event event
				       VkResult)))

(defun reset-event (device event)
  (check-reslute-type (foreign-funcall "vkResetEvent"
				       vk-device device
				       vk-event event
				       VkResult)))

(defcfun ("vkCreateQueryPool" vkCreateQueryPool) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-query-pool-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (pool (:pointer vk-query-pool)))

(defun create-query-pool (device &key
				   (info-next nil)
				   (info-flags 0)
				   (info-type 0)
				   (info-count 0)
				   (info-pipeline-statistics 0)
				   (allocator nil))
  (with-foreign-objects ((info '(:struct vk-query-pool-create-info))
			 (pool 'vk-query-pool))
    (when (null info-next)
      (setf info-next (null-pointer)))
    (when (null allocator)
      (setf allocator (null-pointer)))
    (setf (foreign-slot-value info '(:struct vk-query-pool-create-info) :type)
	  :structure-type-query-pool-create-info
	  (foreign-slot-value info '(:struct vk-query-pool-create-info) :next)
	  info-next
	  (foreign-slot-value info '(:struct vk-query-pool-create-info) :flags)
	  info-flags
	  (foreign-slot-value info '(:struct vk-query-pool-create-info) :query-type)
	  info-type
	  (foreign-slot-value info '(:struct vk-query-pool-create-info) :query-count)
	  info-count
	  (foreign-slot-value info '(:struct vk-query-pool-create-info) :pipeline-statistics)
	  info-pipeline-statistics)
    (check-reslute-type (vkCreateQueryPool device info allocator pool))
    (mem-ref pool 'vk-query-pool)))

(defun destroy-query-pool (device pool &optional (allocator nil))
  (when (null allocator)
    (setf allocator (null-pointer)))
  (foreign-funcall "vkDestroyQueryPool"
		   vk-device device
		   vk-query-pool pool
		   (:pointer (:struct vk-allocation-callback)) allocator
		   :void))

(defun get-query-pool-results (device pool first-query query-count data-size stride flags)
  (with-foreign-object (data '(:pointer :void))
    (check-reslute-type (foreign-funcall "vkGetQueryPoolResults"
					 vk-device device
					 vk-query-pool pool
					 :uint32 first-query
					 :uint32 query-count
					 :unsigned-int data-size
					 (:pointer :void) data
					 vk-device-size stride
					 vk-query-result-flags flags
					 VkResult))
    (mem-ref data '(:pointer :void))))

(defun reset-query-pool (device pool first-query query-count)
  (foreign-funcall "vkResetQueryPool"
		   vk-device device
		   vk-query-pool pool
		   :uint32 first-query
		   :uint32 query-count
		   :void))

(defmacro with-query-pool ((pool device &key
					 (info-next nil)
					 (info-flags 0)
					 (info-type 0)
					 (info-count 0)
					 (info-pipeline-statistics 0)
					  (allocator nil))
			   &body body)
  `(let ((,pool (create-query-pool ,device
				   :info-next ,info-next
				   :info-flags ,info-flags
				   :info-type ,info-type
				   :info-count ,info-count
				   :info-pipeline-statistics ,info-pipeline-statistics
				   :allocator ,allocator)))
     ,@body
     (destroy-query-pool ,device ,pool)))

(defun create-buffer (device &key
			       (info-next nil)
			       (info-flags 0)
			       (info-size 0)
			       (info-usage 0)
			       (info-sharing-mode 0)
			       (info-queue-family-index 0)
			       (info-queue-family-indices 0)
			       (allocator nil))
  (with-foreign-objects ((info '(:struct vk-buffer-create-info))
			 (buffer 'vk-buffer)
			 (info-indices :uint32))
    (when (null info-next)
      (setf info-next (null-pointer)))
    (when (null allocator)
      (setf allocator (null-pointer)))
    (setf (mem-ref info-indices :uint32) info-queue-family-indices)
    (setf (foreign-slot-value info '(:struct vk-buffer-create-info) :type)
	  :structure-type-buffer-create-info
	  (foreign-slot-value info '(:struct vk-buffer-create-info) :next)
	  info-next
	  (foreign-slot-value info '(:struct vk-buffer-create-info) :flags)
	  info-flags
	  (foreign-slot-value info '(:struct vk-buffer-create-info) :size)
	  info-size
	  (foreign-slot-value info '(:struct vk-buffer-create-info) :usage)
	  info-usage
	  (foreign-slot-value info '(:struct vk-buffer-create-info) :sharing-mode)
	  info-sharing-mode
	  (foreign-slot-value info '(:struct vk-buffer-create-info) :queue-family-count)
	  info-queue-family-index
	  (foreign-slot-value info '(:struct vk-buffer-create-info) :queue-family-indices)
	  info-indices)
    (check-reslute-type (foreign-funcall "vkCreateBuffer"
					 vk-device device
					 (:pointer (:struct vk-buffer-create-info)) info
					 (:pointer (:struct vk-allocation-callback)) allocator
					 (:pointer vk-buffer) buffer
					 VkResult))
    (mem-ref buffer 'vk-buffer)))

(defun destroy-buffer (device buffer &optional (allocator nil))
  (when (null allocator)
    (setf allocator (null-pointer)))
  (foreign-funcall "vkDestroyBuffer"
		   vk-device device
		   vk-buffer buffer
		   (:pointer (:struct vk-allocation-callback)) allocator
		   :void))

(defun create-buffer-view (device info-buffer &key
						(info-next nil)
						(info-flags 0)
						(info-format 0)
						(info-offset 0)
						(info-range 0)
						(allocator nil))
  (with-foreign-objects ((info '(:struct vk-buffer-view-create-info))
			 (buffer-view 'vk-buffer-view))
    (when (null info-next)
      (setf info-next (null-pointer)))
    (when (null allocator)
      (setf allocator (null-pointer)))
    (setf (foreign-slot-value info '(:struct vk-buffer-view-create-info) :type)
	  :structure-type-buffer-view-create-info
	  (foreign-slot-value info '(:struct vk-buffer-view-create-info) :next)
	  info-next
	  (foreign-slot-value info '(:struct vk-buffer-view-create-info) :flags)
	  info-flags
	  (foreign-slot-value info '(:struct vk-buffer-view-create-info) :buffer)
	  info-buffer
	  (foreign-slot-value info '(:struct vk-buffer-view-create-info) :format)
	  info-format
	  (foreign-slot-value info '(:struct vk-buffer-view-create-info) :offset)
	  info-offset
	  (foreign-slot-value info '(:struct vk-buffer-view-create-info) :range)
	  info-range)
    (check-reslute-type (foreign-funcall "vkCreateBufferView"
					 vk-device device
					 (:pointer (:struct vk-buffer-view-create-info)) info
					 (:pointer (:struct vk-allocation-callback)) allocator
					 (:pointer vk-buffer-view) buffer-view
					 VkResult))
    (mem-ref buffer-view 'vk-buffer-view)))

(defun destroy-buffer-view (device buffer-view &optional (allocator nil))
  (when (null allocator)
    (setf allocator (null-pointer)))
  (foreign-funcall "vkDestroyBufferView"
		   vk-device device
		   vk-buffer-view buffer-view
		   (:pointer (:struct vk-allocation-callback)) allocator
		   :void))

(defun create-image (device &key
			      (info-next nil)
			      (info-flags 0)
			      (info-image-type :image-type-2d)
			      (info-format 0)
			      (info-extent nil)
			      (info-mip-levels 0)
			      (info-array-layers 0)
			      (info-samples 0)
			      (info-tiling 0)
			      (info-usage 0)
			      (info-sharing-mode 0)
			      (info-queue-family-index-count 0)
			      (info-queue-family-indices 0)
			      (info-layout :image-layout-general)
			      (allocator nil))
  (with-foreign-objects ((info '(:struct vk-image-create-info))
			 (extent '(:struct vk-extent-3d))
			 (indices :uint32)
			 (image 'vk-image))
    (make-3d-extent extent info-extent)
    (setf (mem-ref indices :uint32) info-queue-family-indices)
    (when (null info-next)
      (setf info-next (null-pointer)))
    (when (null allocator)
      (setf allocator (null-pointer)))
    (setf (foreign-slot-value info '(:struct vk-image-create-info) :type)
	  :structure-type-image-create-info
	  (foreign-slot-value info '(:struct vk-image-create-info) :next)
	  info-next
	  (foreign-slot-value info '(:struct vk-image-create-info) :flags)
	  info-flags
	  (foreign-slot-value info '(:struct vk-image-create-info) :image-type)
	  info-image-type
	  (foreign-slot-value info '(:struct vk-image-create-info) :format)
	  info-format
	  (foreign-slot-value info '(:struct vk-image-create-info) :extent)
	  (mem-ref extent '(:struct vk-extent-3d))
	  (foreign-slot-value info '(:struct vk-image-create-info) :mip-levels)
	  info-mip-levels
	  (foreign-slot-value info '(:struct vk-image-create-info) :array-layers)
	  info-array-layers
	  (foreign-slot-value info '(:struct vk-image-create-info) :samples)
	  info-samples
	  (foreign-slot-value info '(:struct vk-image-create-info) :tiling)
	  info-tiling
	  (foreign-slot-value info '(:struct vk-image-create-info) :usage)
	  info-usage
	  (foreign-slot-value info '(:struct vk-image-create-info) :sharing-mode)
	  info-sharing-mode
	  (foreign-slot-value info '(:struct vk-image-create-info) :queue-family-index-count)
	  info-queue-family-index-count
	  (foreign-slot-value info '(:struct vk-image-create-info) :queue-family-indices)
	  indices
	  (foreign-slot-value info '(:struct vk-image-create-info) :initial-layout)
	  info-layout)
    (check-reslute-type (foreign-funcall "vkCreateImage"
					 vk-device device
					 (:pointer (:struct vk-image-create-info)) info
					 (:pointer (:struct vk-allocation-callback)) allocator
					 (:pointer vk-image) image
					 VkResult))
    (mem-ref image 'vk-image)))

(defun destroy-image (device image &optional (allocator nil))
  (when (null allocator)
    (setf allocator (null-pointer)))
  (foreign-funcall "vkDestroyImage"
		   vk-device device
		   vk-image image
		   (:pointer (:struct vk-allocation-callback)) allocator))

(defun get-image-subresource-layout (device image aspect-mask mip-level array-layer)
  (with-foreign-objects ((subresource '(:struct vk-image-subresource))
			 (layout '(:struct vk-subresource-layout)))
    (setf (foreign-slot-value subresource '(:struct vk-image-subresource) :aspect-mask)
	  aspect-mask
	  (foreign-slot-value subresource '(:struct vk-image-subresource) :mip-level)
	  mip-level
	  (foreign-slot-value subresource '(:struct vk-image-subresource) :array-layer)
	  array-layer)
    (foreign-funcall "vkGetImageSubresourceLayout"
		     vk-device device
		     vk-image image
		     (:pointer (:struct vk-image-subresource)) subresource
		     (:pointer (:struct vk-subresource-layout)) layout
		     :void)
    (mem-ref layout '(:struct vk-subresource-layout))))

(defun create-image-view (device info-image &key
					      (info-next nil)
					      (info-flags 0)
					      (info-view-type 0)
					      (info-format 0)
					      (info-components nil)
					      (info-image-subresource-range nil)
					      (allocator nil))
  (with-foreign-objects ((info '(:struct vk-image-view-create-info))
			 (components '(:struct vk-component-mapping))
			 (subresource-range '(:struct vk-image-subresource-range))
			 (image-view 'vk-image-view))
    (create-vk-object components '(:struct vk-component-mapping) info-components)
    (create-vk-object subresource-range '(:struct vk-image-subresource-range) info-image-subresource-range)
    (when (null info-next)
      (setf info-next (null-pointer)))
    (when (null allocator)
      (setf allocator (null-pointer)))
    (setf (foreign-slot-value info '(:struct vk-image-view-create-info) :type)
	  :structure-type-image-view-create-info
	  (foreign-slot-value info '(:struct vk-image-view-create-info) :next)
	  info-next
	  (foreign-slot-value info '(:struct vk-image-view-create-info) :flags)
	  info-flags
	  (foreign-slot-value info '(:struct vk-image-view-create-info) :image)
	  info-image
	  (foreign-slot-value info '(:struct vk-image-view-create-info) :view-type)
	  info-view-type
	  (foreign-slot-value info '(:struct vk-image-view-create-info) :format)
	  info-format
	  (foreign-slot-value info '(:struct vk-image-view-create-info) :components)
	  (mem-ref components '(:struct vk-component-mapping))
	  (foreign-slot-value info '(:struct vk-image-view-create-info) :subresource-range)
	  (mem-ref subresource-range '(:struct vk-image-subresource-range)))
    (check-reslute-type (foreign-funcall "vkCreateImageView"
					 vk-device device
					 (:pointer (:struct vk-image-view-create-info)) info
					 (:pointer (:struct vk-allocation-callback)) allocator
					 (:pointer vk-image-view) image-view
					 VkResult))
    (mem-ref image-view 'vk-image-view)))

(defun destroy-image-view (device image-view &optional (allocator nil))
  (when (null allocator)
    (setf allocator (null-pointer)))
  (foreign-funcall "vkDestroyImageView"
		   vk-device device
		   vk-image-view image-view
		   (:pointer (:struct vk-allocation-callback)) allocator
		   :void))

(defun create-sharder-module (device &key
				       (info-next nil)
				       (info-flags 0)
				       (info-code-size 0)
				       (info-code 0)
				       (allocator nil))
  (with-foreign-objects ((info '(:struct vk-shader-module-create-info))
			 (code :uint32)
			 (module 'vk-shader-module))
    (when (null info-next)
      (setf info-next (null-pointer)))
    (when (null allocator)
      (setf allocator (null-pointer)))
    (setf (mem-ref code :uint32) info-code)
    (setf (foreign-slot-value info '(:struct vk-shader-module-create-info) :type)
	  :structure-type-shader-module-create-info
	  (foreign-slot-value info '(:struct vk-shader-module-create-info) :next)
	  info-next
	  (foreign-slot-value info '(:struct vk-shader-module-create-info) :flags)
	  info-flags
	  (foreign-slot-value info '(:struct vk-shader-module-create-info) :code-size)
	  info-code-size
	  (foreign-slot-value info '(:struct vk-shader-module-create-info) :code)
	  code)
    (check-reslute-type (foreign-funcall "vkCreateShaderModule"
					 vk-device device
					 (:pointer (:struct vk-shader-module-create-info)) info
					 (:pointer (:struct vk-allocation-callback)) allocator
					 (:pointer vk-shader-module) module
					 VkResult))
    (mem-ref module 'vk-shader-module)))

(defun destroy-shader-module (device shader-module &optional (allocator nil))
  (foreign-funcall "vkDestroyShaderModule"
		   vk-device device
		   vk-shader-module shader-module
		   (:pointer (:struct vk-allocation-callback)) allocator
		   :void))

(defun create-pipeline-cache (device &key
				       (info-next nil)
				       (info-flags 0)
				       (info-initialize-data-size 0)
				       (info-initialize-data nil)
				       (allocator nil))
  (with-foreign-objects ((info '(:struct vk-pipeline-cache-create-info))
			 (pipeline-cache 'vk-pipeline-cache))
    (when (null info-next)
      (setf info-next (null-pointer)))
    (when (null info-initialize-data)
      (setf info-initialize-data (null-pointer)))
    (when (null allocator)
      (setf allocator (null-pointer)))
    (setf (foreign-slot-value info '(:struct vk-pipeline-cache-create-info) :type)
	  :structure-type-pipeline-cache-create-info
	  (foreign-slot-value info '(:struct vk-pipeline-cache-create-info) :next)
	  info-next
	  (foreign-slot-value info '(:struct vk-pipeline-cache-create-info) :flags)
	  info-flags
	  (foreign-slot-value info '(:struct vk-pipeline-cache-create-info) :initial-date-size)
	  info-initialize-data-size
	  (foreign-slot-value info '(:struct vk-pipeline-cache-create-info) :init-data)
	  info-initialize-data)
    (check-reslute-type (foreign-funcall "vkCreatePipelineCache"
					 vk-device device
					 (:pointer (:struct vk-pipeline-cache-create-info)) info
					 (:pointer (:struct vk-allocation-callback)) allocator
					 (:pointer vk-pipeline-cache) pipeline-cache))
    (mem-ref pipeline-cache 'vk-pipeline-cache)))

(defun destroy-pipeline-cache (device pipeline-cache &optional (allocator nil))
  (when (null allocator)
    (setf allocator (null-pointer)))
  (foreign-funcall "vkDestroyPipelineCache"
		   vk-device device
		   vk-pipeline-cache pipeline-cache
		   (:pointer (:struct vk-allocation-callback)) allocator))

(defcfun ("vkGetPipelineCacheData" vkGetPipelineCacheData) VkResult
  (device vk-device)
  (pipeline-cache vk-pipeline-cache)
  (data-size (:pointer :unsigned-int))
  (data (:pointer :void)))

(defun get-pipeline-cache-data (device pipeline-cache)
  (with-foreign-objects ((data-size :unsigned-int)
			 (data '(:pointer :void)))
    (check-reslute-type (vkGetPipelineCacheData device pipeline-cache data-size (null-pointer)))
    (check-reslute-type (vkGetPipelineCacheData device pipeline-cache data-size data-size))
    (mem-ref data '(:pointer :void))))

(defun merge-pipeline-caches (device dst-cache cache-list)
  (with-foreign-object (src-cache 'vk-pipeline-cache (length cache-list))
    (loop for cache in cache-list
	  for i from 0
	  do
	     (setf (mem-aref src-cache 'vk-pipeline-cache i) cache))
    (check-reslute-type (foreign-funcall "vkMergePipelineCaches"
					 vk-device device
					 vk-pipeline-cache dst-cache
					 :uint32 (length cache-list)
					 (:pointer vk-pipeline-cache) src-cache
					 VkResult))))

(defun create-graphics-pipelines (device
				  pipeline-cache
				  count
				  info-layout
				  info-render-pass
				  info-sub-pass
				  info-base-pipeline-handle
				  info-base-pipeline-index
				  &key
				    (info-next nil)
				    (info-flags 0)
				    (info-stage-count 0)
				    (info-stages nil)
				    (info-vertex-input-states nil)
				    (info-input-assembly-states nil)
				    (info-tessellation-states nil)
				    (info-view-port-states nil)
				    (info-rasterization-states nil)
				    (info-multisample-states nil)
				    (info-depth-stencil-states nil)
				    (info-color-blend-states nil)
				    (info-dynamic-states nil)
				    (allocator nil))
  (with-foreign-objects ((info '(:struct vk-graphics-pipeline-create-info))
			 (stages '(:struct vk-pipeline-shader-stage-create-info) info-stage-count)
			 (vertexs '(:struct vk-pipeline-vertex-input-state-create-info) info-stage-count)
			 (input-assemblies '(:struct vk-pipeline-input-assembly-state-create-info) info-stage-count)
			 (tessellations '(:struct vk-pipeline-tessellation-state-create-info) info-stage-count)
			 (view-ports '(:struct vk-pipeline-viewport-state-create-info) info-stage-count)
			 (rasterizations '(:struct vk-pipeline-rasterization-state-create-info) info-stage-count)
			 (multiple-samples '(:struct vk-pipeline-multisample-state-create-info) info-stage-count)
			 (depth-stencils '(:struct vk-pipeline-depth-stencil-state-create-info) info-stage-count)
			 (color-blends '(:struct vk-pipeline-color-blend-state-create-info) info-stage-count)
			 (dynamics '(:struct vk-pipeline-dynamic-state-create-info) info-stage-count)
			 (pipeline 'vk-pipeline))
    (when (null info-next)
      (setf info-next (null-pointer)))
    (when (null allocator)
      (setf allocator (null-pointer)))
    (loop for stage in info-stages
	  for i from 0
	  for cstage = (mem-aptr stages '(:struct vk-pipeline-shader-stage-create-info) i)
	  do
	     (create-vk-object cstage '(:struct vk-pipeline-shader-stage-create-info) stage))
    (loop for states in info-vertex-input-states
	  for i from 0
	  for cstates = (mem-aptr vertexs '(:struct vk-pipeline-vertex-input-state-create-info) i)
	  do
	     (create-vk-object cstates '(:struct vk-pipeline-vertex-input-state-create-info) states))
    (loop for states in info-input-assembly-states
	  for i from 0
	  for cstates = (mem-aptr input-assemblies '(:struct vk-pipeline-input-assembly-state-create-info) i)
	  do
	     (create-vk-object cstates '(:struct vk-pipeline-input-assembly-state-create-info) states))    
    (loop for states in info-tessellation-states
	  for i from 0
	  for cstates = (mem-aptr tessellations '(:struct vk-pipeline-tessellation-state-create-info) i)
	  do
	     (create-vk-object cstates '(:struct vk-pipeline-tessellation-state-create-info) states))
    (loop for states in info-view-port-states
	  for i from 0
	  for cstates = (mem-aptr view-ports '(:struct vk-pipeline-viewport-state-create-info) i)
	  do
	     (create-vk-object cstates '(:struct vk-pipeline-viewport-state-create-info) states))
    (loop for states in info-rasterization-states
	  for i from 0
	  for cstates = (mem-aptr rasterizations '(:struct vk-pipeline-rasterization-state-create-info) i)
	  do
	     (create-vk-object cstates '(:struct vk-pipeline-rasterization-state-create-info) states))
    (loop for states in info-multisample-states
	  for i from 0
	  for cstates = (mem-aptr multiple-samples '(:struct vk-pipeline-multisample-state-create-info) i)
	  do
	     (create-vk-object cstates '(:struct vk-pipeline-multisample-state-create-info) states))

    (loop for states in info-depth-stencil-states
	  for i from 0
	  for cstates = (mem-aptr depth-stencils '(:struct vk-pipeline-depth-stencil-state-create-info) i)
	  do
	     (create-vk-object cstates '(:struct vk-pipeline-depth-stencil-state-create-info) states))
    (loop for states in info-color-blend-states
	  for i from 0
	  for cstates = (mem-aptr color-blends '(:struct vk-pipeline-color-blend-state-create-info) i)
	  do
	     (create-vk-object cstates '(:struct vk-pipeline-color-blend-state-create-info) states))
    (loop for states in info-dynamic-states
	  for i from 0
	  for cstates = (mem-aptr dynamics '(:struct vk-pipeline-dynamic-state-create-info) i)
	  do
	     (create-vk-object cstates '(:struct vk-pipeline-dynamic-state-create-info) states))
    (setf (foreign-slot-value info '(:struct vk-graphics-pipeline-create-info) :type)
	  :structure-type-graphics-pipeline-create-info
	  (foreign-slot-value info '(:struct vk-graphics-pipeline-create-info) :next)
	  info-next
	  (foreign-slot-value info '(:struct vk-graphics-pipeline-create-info) :flags)
	  info-flags
	  (foreign-slot-value info '(:struct vk-graphics-pipeline-create-info) :stage-count)
	  info-stage-count
	  (foreign-slot-value info '(:struct vk-graphics-pipeline-create-info) :layout)
	  info-layout
	  (foreign-slot-value info '(:struct vk-graphics-pipeline-create-info) :render-pass)
	  info-render-pass
	  (foreign-slot-value info '(:struct vk-graphics-pipeline-create-info) :subpass)
	  info-sub-pass
	  (foreign-slot-value info '(:struct vk-graphics-pipeline-create-info) :base-pipeline-handle)
	  info-base-pipeline-handle
	  (foreign-slot-value info '(:struct vk-graphics-pipeline-create-info) :base-pipeline-index)
	  info-base-pipeline-index
	  (foreign-slot-value info '(:struct vk-graphics-pipeline-create-info) :stages)
	  stages
	  (foreign-slot-value info '(:struct vk-graphics-pipeline-create-info) :vertex-input-state)
	  vertexs
	  (foreign-slot-value info '(:struct vk-graphics-pipeline-create-info) :input-assembly-state)
	  input-assemblies
	  (foreign-slot-value info '(:struct vk-graphics-pipeline-create-info) :tessellation-state)
	  tessellations
	  (foreign-slot-value info '(:struct vk-graphics-pipeline-create-info) :viewport-state)
	  view-ports
	  (foreign-slot-value info '(:struct vk-graphics-pipeline-create-info) :rasterization-state)
	  rasterizations
	  (foreign-slot-value info '(:struct vk-graphics-pipeline-create-info) :multisample-state)
	  multiple-samples
	  (foreign-slot-value info '(:struct vk-graphics-pipeline-create-info) :depth-stencil-state)
	  depth-stencils
	  (foreign-slot-value info '(:struct vk-graphics-pipeline-create-info) :color-blend-state)
	  color-blends
	  (foreign-slot-value info '(:struct vk-graphics-pipeline-create-info) :dynamic-state)
	  dynamics)
    (check-reslute-type (foreign-funcall "vkCreateGraphicsPipelines"
					 vk-device device
					 vk-pipeline-cache pipeline-cache
					 :uint32 count
					 (:pointer (:struct vk-graphics-pipeline-create-info)) info
					 (:pointer (:struct vk-allocation-callback)) allocator
					 (:pointer vk-pipeline) pipeline
					 VkResult))
    (mem-ref pipeline 'vk-pipeline)))

(defun create-compute-pipelines (device pipeline-cache count &key
							       (create-infos nil)
							       (allocator nil))
  (with-foreign-objects ((infos '(:struct vk-compute-pipeline-create-info))
			 (pipeline 'vk-pipeline))
    (create-vk-object infos '(:struct vk-compute-pipeline-create-info) create-infos)
    (when (null allocator)
      (setf allocator (null-pointer)))
    (check-reslute-type (foreign-funcall "vkCreateComputePipelines"
					 vk-device device
					 vk-pipeline-cache pipeline-cache
					 :uint32 count
					 (:pointer (:struct vk-compute-pipeline-create-info)) infos
					 (:pointer (:struct vk-allocation-callback)) allocator
					 (:pointer vk-pipeline) pipeline
					 VkResult))
    (mem-ref pipeline 'vk-pipeline)))

(defun destroy-pipeline (device pipeline &optional (allocator nil))
  (when (null allocator)
    (setf allocator (null-pointer)))
  (foreign-funcall "vkDestroyPipeline"
		   vk-device device
		   vk-pipeline pipeline
		   (:pointer (:struct vk-allocation-callback)) allocator))

(defun create-pipeline-layout (device &key
				       (info-next nil)
				       (info-flags 0)
				       (info-layouts nil)
				       (info-push-constant-range nil)
				       (allocator nil))
  (with-foreign-objects ((info '(:struct vk-pipeline-layout-create-info))
			 (layouts 'vk-descriptor-set-layout (length info-layouts))
			 (push-constant-rang '(:struct vk-push-constant-range) (length info-push-constant-range))
			 (layout 'vk-pipeline-layout))
    (loop for layout in info-layouts
	  for i from 0
	  do
	     (setf (mem-aref layouts 'vk-descriptor-set-layout i) layout))
    (loop for range in info-push-constant-range
	  for i from 0
	  for crange = (mem-aptr push-constant-rang '(:struct vk-push-constant-range) i)
	  do
	     (create-vk-object crange '(:struct vk-push-constant-range) range))
    (when (null info-layouts)
      (setf layouts (null-pointer)))
    (when (null info-push-constant-range)
      (setf push-constant-rang (null-pointer)))
    (when (null allocator)
      (setf allocator (null-pointer)))
    (setf (foreign-slot-value info '(:struct vk-pipeline-layout-create-info) :type)
	  :structure-type-pipeline-layout-create-info
	  (foreign-slot-value info '(:struct vk-pipeline-layout-create-info) :next)
	  info-next
	  (foreign-slot-value info '(:struct vk-pipeline-layout-create-info) :flags)
	  info-flags
	  (foreign-slot-value info '(:struct vk-pipeline-layout-create-info) :set-layout-count)
	  (length info-layouts)
	  (foreign-slot-value info '(:struct vk-pipeline-layout-create-info) :set-layouts)
	  layouts
	  (foreign-slot-value info '(:struct vk-pipeline-layout-create-info) :push-constant-range-count)
	  (length info-push-constant-range)
	  (foreign-slot-value info '(:struct vk-pipeline-layout-create-info) :push-constant-ranges)
	  push-constant-rang)
    (check-reslute-type (foreign-funcall "vkCreatePipelineLayout"
					 vk-device device
					 (:pointer (:struct vk-pipeline-layout-create-info)) info
					 (:pointer (:struct vk-allocation-callback)) allocator
					 (:pointer vk-pipeline-layout) layout
					 VkResult))
    (mem-ref layout 'vk-pipeline-layout)))

(defun destroy-pipeline-layout (device pipeline-layout &optional (allocator nil))
  (when (null allocator)
    (setf allocator (null-pointer)))
  (foreign-funcall "vkDestroyPipelineLayout"
		   vk-device device
		   vk-pipeline-layout pipeline-layout
		   (:pointer (:struct vk-allocation-callback)) allocator
		   :void))

(defun create-sampler (device &key
				(info-next nil)
				(info-flags 0)
				(info-mag-filter :filter-nearest)
				(info-min-filter :filter-nearest)
				(info-mipmap-mode :sampler-mipmap-mode-nearest)
				(info-address-mode-u :sampler-mipmap-mode-nearest)
				(info-address-mode-v :sampler-mipmap-mode-nearest)
				(info-address-mode-w :sampler-mipmap-mode-nearest)
				(info-mip-lod-bias 0.0)
				(info-anisotropy-enable 0)
				(info-max-anisotropy 0.0)
				(info-compare-enable 0)
				(info-compare-op :compare-op-never)
				(info-min-lod 0.0)
				(info-max-lod 0.0)
				(info-border-color :border-color-float-transparent-black)
				(info-unnormalized-coordinates 0)
				(allocator nil))
  (with-foreign-objects ((info '(:struct vk-sampler-create-info))
			 (sampler 'vk-sampler))
    (when (null info-next)
      (setf info-next (null-pointer)))
    (when (null allocator)
      (setf allocator (null-pointer)))
    (setf (foreign-slot-value info '(:struct vk-sampler-create-info) :type)
	  :structure-type-sampler-create-info
	  (foreign-slot-value info '(:struct vk-sampler-create-info) :next)
	  info-next
	  (foreign-slot-value info '(:struct vk-sampler-create-info) :flags)
	  info-flags
	  (foreign-slot-value info '(:struct vk-sampler-create-info) :mag-filter)
	  info-mag-filter
	  (foreign-slot-value info '(:struct vk-sampler-create-info) :min-filter)
	  info-min-filter
	  (foreign-slot-value info '(:struct vk-sampler-create-info) :mipmap-mode)
	  info-mipmap-mode
	  (foreign-slot-value info '(:struct vk-sampler-create-info) :address-mode-u)
	  info-address-mode-u
	  (foreign-slot-value info '(:struct vk-sampler-create-info) :address-mode-v)
	  info-address-mode-v
	  (foreign-slot-value info '(:struct vk-sampler-create-info) :address-mode-w)
	  info-address-mode-w
	  (foreign-slot-value info '(:struct vk-sampler-create-info) :mip-lod-bias)
	  info-mip-lod-bias
	  (foreign-slot-value info '(:struct vk-sampler-create-info) :anisotropy-enable)
	  info-anisotropy-enable
	  (foreign-slot-value info '(:struct vk-sampler-create-info) :max-anisotropy)
	  info-max-anisotropy
	  (foreign-slot-value info '(:struct vk-sampler-create-info) :compare-enable)
	  info-compare-enable
	  (foreign-slot-value info '(:struct vk-sampler-create-info) :compare-op)
	  info-compare-op
	  (foreign-slot-value info '(:struct vk-sampler-create-info) :min-lod)
	  info-min-lod
	  (foreign-slot-value info '(:struct vk-sampler-create-info) :max-lod)
	  info-max-lod
	  (foreign-slot-value info '(:struct vk-sampler-create-info) :border-color)
	  info-border-color
	  (foreign-slot-value info '(:struct vk-sampler-create-info) :unnormalized-coordinates)
	  info-unnormalized-coordinates)
    (check-reslute-type (foreign-funcall "vkCreateSampler"
					 vk-device device
					 (:pointer (:struct vk-sampler-create-info)) info
					 (:pointer (:struct vk-allocation-callback)) allocator
					 (:pointer vk-sampler) sampler
					 VkResult))
    (mem-ref sampler 'vk-sampler)))

(defun destroy-sampler (device sampler &optional (allocator nil))
  (when (null allocator)
    (setf allocator (null-pointer)))
  (foreign-funcall "vkDestroySampler"
		   vk-device device
		   vk-sampler sampler
		   (:pointer (:struct vk-allocation-callback)) allocator
		   :void))

(defun create-descriptor-set-layout (device &key
					      (info-next nil)
					      (info-flags 0)
					      (info-bindings nil)
					      (allocator nil))
  (with-foreign-objects ((info '(:struct vk-descriptor-set-layout-create-info))
			 (bindings '(:struct vk-descriptor-set-layout-binding) (length info-bindings))
			 (set-layout 'vk-descriptor-set-layout))
    (loop for bind in info-bindings
	  for i from 0
	  for cbind = (mem-aptr '(:struct vk-descriptor-set-layout-binding) i)
	  do
	     (create-vk-object cbind '(:struct vk-descriptor-set-layout-binding) bind))
    (when (null info-bindings)
      (setf bindings (null-pointer)))
    (when (null allocator)
      (setf allocator (null-pointer)))
    (setf (foreign-slot-value info '(:struct vk-descriptor-set-layout-create-info) :type)
	  :structure-type-descriptor-set-layout-create-info
	  (foreign-slot-value info '(:struct vk-descriptor-set-layout-create-info) :next)
	  info-next
	  (foreign-slot-value info '(:struct vk-descriptor-set-layout-create-info) :flags)
	  info-flags
	  (foreign-slot-value info '(:struct vk-descriptor-set-layout-create-info) :binding-count)
	  (length info-bindings)
	  (foreign-slot-value info '(:struct vk-descriptor-set-layout-create-info) :bindings)
	  bindings)
    (check-reslute-type (foreign-funcall "vkCreateDescriptorSetLayout"
					 vk-device device
					 (:pointer (:struct vk-descriptor-set-layout-create-info)) info
					 (:pointer (:struct vk-allocation-callback)) allocator
					 (:pointer vk-descriptor-set-layout) set-layout
					 VkResult))
    (mem-ref set-layout 'vk-descriptor-set-layout)))

(defun destroy-descriptor-set-layout (device set-layout &optional (allocator nil))
  (when (null allocator)
    (setf allocator nil))
  (foreign-funcall "vkDestroyDescriptorSetLayout"
		   vk-device device
		   vk-descriptor-set-layout set-layout
		   (:pointer (:struct vk-allocation-callback)) allocator
		   :void))

(defun create-descriptor-pool (device &key
					(info-next nil)
					(info-flags 0)
					(info-max-sets 0)
					(info-pool-sizes nil)
					(allocator nil))
  (with-foreign-objects ((info '(:struct vk-descriptor-pool-create-info))
			 (pool-sizes '(:struct vk-descriptor-pool-size) (length info-pool-sizes))
			 (pool 'vk-descriptor-pool))
    (loop for pool-size in info-pool-sizes
	  for i from 0
	  for cpool-size = (mem-aptr pool-sizes '(:struct vk-descriptor-pool-size))
	  do
	     (create-vk-object cpool-size '(:struct vk-descriptor-pool-size) pool-sizes))
    (when (null info-next)
      (setf info-next (null-pointer)))
    (when (null info-pool-sizes)
      (setf pool-sizes (null-pointer)))
    (when (null allocator)
      (setf allocator (null-pointer)))
    (setf (foreign-slot-value info '(:struct vk-descriptor-pool-create-info) :type)
	  :structure-type-descriptor-pool-create-info
	  (foreign-slot-value info '(:struct vk-descriptor-pool-create-info) :next)
	  info-next
	  (foreign-slot-value info '(:struct vk-descriptor-pool-create-info) :flags)
	  info-flags
	  (foreign-slot-value info '(:struct vk-descriptor-pool-create-info) :max-sets)
	  info-max-sets
	  (foreign-slot-value info '(:struct vk-descriptor-pool-create-info) :pool-size-count)
	  (length info-pool-sizes)
	  (foreign-slot-value info '(:struct vk-descriptor-pool-create-info) :pool-sizes)
	  pool-sizes)
    (check-reslute-type (foreign-funcall "vkCreateDescriptorPool"
					 vk-device device
					 (:pointer (:struct vk-descriptor-pool-create-info)) info
					 (:pointer (:struct vk-allocation-callback)) allocator
					 (:pointer vk-descriptor-pool) pool
					 VkResult))
    (mem-ref pool 'vk-descriptor-pool)))

(defun destroy-descriptor-pool (device pool &optional (allocator nil))
  (when (null allocator)
    (setf allocator (null-pointer)))
  (foreign-funcall "vkDestroyDescriptorPool"
		   vk-device device
		   vk-descriptor-pool pool
		   (:pointer (:struct vk-allocation-callback)) allocator
		   :void))

(defun reset-descriptor-pool (device pool flags)
  (check-reslute-type (foreign-funcall "vkResetDescriptorPool"
				       vk-device device
				       vk-descriptor-pool pool
				       vk-descriptor-pool-reset-flags flags
				       VkResult)))

(defun allocate-descriptor-sets (device &optional allocator)
  (when (null allocator)
    (setf allocator (null-pointer)))
  (with-foreign-object (descriptor-set 'vk-descriptor-set)
    (check-reslute-type (foreign-funcall "vkAllocateDescriptorSets"
					 vk-device device
					 (:pointer (:struct vk-allocation-callback)) allocator
					 (:pointer vk-descriptor-set) descriptor-set
					 VkResult))
    (mem-ref descriptor-set 'vk-descriptor-set)))

(defun free-descriptor-sets (device pool descriptor-sets)
  (with-foreign-object (sets 'vk-descriptor-set (length descriptor-sets))
    (loop for set in descriptor-sets
	  for i from 0
	  do
	     (setf (mem-ref sets 'vk-descriptor-set i) set))
    (check-reslute-type (foreign-funcall "vkFreeDescriptorSets"
					 vk-device device
					 vk-descriptor-pool pool
					 :uint32 (length descriptor-sets)
					 (:pointer vk-descriptor-set) sets
					 VkResult))))

(defun update-descriptor-sets (device &key
					(descriptor-writes nil)
					(descriptor-copies nil))
  (with-foreign-objects ((writes '(:struct vk-write-descriptor-set) (length descriptor-writes))
			 (copies '(:struct vk-copy-descriptor-set) (length descriptor-copies)))
    (loop for write in descriptor-writes
	  for i from 0
	  for cwrite = (mem-aptr writes '(:struct vk-write-descriptor-set) i)
	  do
	     (create-vk-object cwrite '(:struct vk-write-descriptor-set) write))
    (loop for copy in descriptor-copies
	  for i from 0
	  for ccopy = (mem-aptr copies '(:struct vk-copy-descriptor-set) i)
	  do
	     (create-vk-object ccopy '(:struct vk-copy-descriptor-set) copy))
    (check-reslute-type (foreign-funcall "vkUpdateDescriptorSets"
					 vk-device device
					 :uint32 (length descriptor-writes)
					 (:pointer (:struct vk-write-descriptor-set)) writes
					 :uint32 (length descriptor-copies)
					 (:pointer (:struct vk-copy-descriptor-set)) copies
					 VkResult))))

(defun create-surface-khr (win instance allocate)
  (with-foreign-object (surface 'vk-surface-khr)
    (check-reslute-type (foreign-funcall "glfwCreateWindowSurface"
					 vk-instance instance
					 :pointer win
					 (:pointer (:struct vk-allocation-callback)) allocate
					 (:pointer vk-surface-khr) surface
					 VkResult))
    (mem-ref surface 'vk-surface-khr)))

(defun destroy-surface-khr (instance surface allocator)
  (foreign-funcall "vkDestroySurfaceKHR"
		   vk-instance instance
		   vk-surface-khr surface
		   (:pointer (:struct vk-allocation-callback)) allocator
		   :void))

(defmacro with-surface ((surface win instance) &body body)
  `(let ((,surface (create-surface-khr ,win ,instance (null-pointer))))
     (progn
       ,@body
       (destroy-surface-khr ,instance ,surface (null-pointer)))))

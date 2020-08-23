(in-package :vkle)

(export '(make-vulkan-version
	  create-instance
	  destroy-instance
	  with-instance))

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
			  (extensions nil)
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


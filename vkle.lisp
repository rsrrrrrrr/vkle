(in-package :vkle)

(export
 '(create-vulkan-surface-khr
   with-surface
   queue-family-index-support-present-p
   get-instance-extensions))

(defun get-surface-type ()
  (if (= 8 (foreign-type-size :pointer))
      :pointer
      :uint64))

(defun create-vulkan-surface-khr (win instance allocate)
  (let ((surface-type (get-surface-type)))
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

(defcfun ("glfwVulkanSupported" get-vulkan-support) :boolean
  "return true if vulkan is available")

(defctype vk-handle (:pointer :void))

(defcfun ("glfwGetPhysicalDevicePresentationSupport" queue-family-index-support-present-p) :boolean
  (instance vk-handle)
  (physical-device vk-handle)
  (index :uint32))

(defun get-instance-extensions ()
  (with-foreign-object (count :uint32)
    (let* ((extensions (foreign-funcall "glfwGetRequiredInstanceExtensions"
					:pointer count
					:pointer))
	   (extensions-count (- (mem-ref count :uint32) 1)))
      (loop for i from 0 upto extensions-count
	    collect (mem-aref extensions :string i)))))




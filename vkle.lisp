(in-package :vkle)

(export
 '(with-surface
   queue-family-index-support-present-p
   get-instance-extensions
   get-physical-device-surface-capabilities))

(defctype vk-handle (:pointer :void))

(defcstruct extent-2d
  (:width :uint32)
  (:height :uint32))

(defcstruct surface-capabilities
  (:min-image-count :uint32)
  (:max-image-count :uint32)
  (:current-extent (:struct extent-2d))
  (:min-image-extent (:struct extent-2d))
  (:max-image-extent (:struct extent-2d))
  (:max-image-array-layers :uint32)
  (:supported-transforms :uint32)
  (:current-transform :uint32)
  (:supported-composite-alpha :uint32)
  (:supported-usage-flags :uint32))

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

(defun get-instance-extensions ()
  (with-foreign-object (count :uint32)
    (let* ((extensions (foreign-funcall "glfwGetRequiredInstanceExtensions"
					:pointer count
					:pointer))
	   (extensions-count (- (mem-ref count :uint32) 1)))
      (loop for i from 0 upto extensions-count
	    collect (mem-aref extensions :string i)))))

(defcfun ("vkGetPhysicalDeviceSurfaceCapabilitiesKHR" get-physical-device-surface-capabilities-t) :uint32
  (physical-device vk-handle)
  (surface vk-handle)
  (capability vk-handle))

(defun get-physical-device-surface-capabilities (physical-device surface)
  (with-foreign-object (capability '(:struct surface-capabilities))
    (get-physical-device-surface-capabilities-t physical-device surface capability)
    (let* ((min-image-count (foreign-slot-value capability '(:struct surface-capabilities) :min-image-count))
	   (max-image-count (foreign-slot-value capability '(:struct surface-capabilities) :max-image-count))
	   (current-extent (foreign-slot-value capability '(:struct surface-capabilities) :current-extent))
	   (min-image-extent (foreign-slot-value capability '(:struct surface-capabilities) :min-image-extent))
	   (max-image-extent (foreign-slot-value capability '(:struct surface-capabilities) :max-image-extent))
	   (max-image-array-layers (foreign-slot-value capability '(:struct surface-capabilities) :max-image-array-layers))
	   (supported-transforms (foreign-slot-value capability '(:struct surface-capabilities) :supported-transforms))
	   (current-transform (foreign-slot-value capability '(:struct surface-capabilities) :current-transform))
	   (supported-composite-alpha (foreign-slot-value capability '(:struct surface-capabilities) :supported-composite-alpha))
	   (supported-usage-flags (foreign-slot-value capability '(:struct surface-capabilities) :supported-usage-flags)))
      (list :min-image-count min-image-count
	    :max-image-count max-image-count
	    :current-extent current-extent
	    :min-image-extent min-image-extent
	    :max-image-extend max-image-extent
	    :max-image-array-layers max-image-array-layers
	    :supported-transforms supported-transforms
	    :current-transform current-transform
	    :supported-composite-alpha supported-composite-alpha
	    :supported-usage-flags supported-usage-flags))))

(defcfun ("glfwVulkanSupported" get-vulkan-support) :boolean
  "return true if vulkan is available")

(defcfun ("glfwGetPhysicalDevicePresentationSupport" queue-family-index-support-present-p) :uint64
  (instance vk-handle)
  (physical-device vk-handle)
  (index :uint32))

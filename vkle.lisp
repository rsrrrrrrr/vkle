(in-package :vkle)

(export
 '(with-surface
   queue-family-index-support-present-p
   get-instance-extensions
   get-physical-device-surface-capabilities))

(defctype vk-handle (:pointer :void))

(defcenum (surface-transform-flag-bits)
  (:identity-bit #X00000001)
  (:rotate-90-bit #X00000002)
  (:rotate-180-bit #X00000004)
  (:rotate-270-bit #X00000008)
  (:horizontal-mirror-bit #X00000010)
  (:horizontal-mirror-rotate-90-bit #X00000020)
  (:horizontal-mirror-rotate-180-bit #X00000040)
  (:horizontal-mirror-rotate-270-bit #X00000080)
  (:inherit-bit #X00000100))

(defcenum (image-usage-flag-bits)
  (:transfer-src-bit #X00000001)
  (:transfer-dst-bit #X00000002)
  (:sampled-bit #X00000004)
  (:storage-bit #X00000008)
  (:color-attachment-bit #X00000010)
  (:depth-stencil-attachment-bit #X00000020)
  (:transient-attachment-bit #X00000040)
  (:input-attachment-bit #X00000080)
  (:shading-rate-image-bit-nv #X00000100)
  (:fragment-density-map-bit-ext #X00000200))

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
	   ;;(current-extent-w (foreign-slot-value current-extent '(:struct extent-2d) :width))
	   ;;(current-extent-h (foreign-slot-value current-extent '(:struct extent-2d) :height))
	   (min-image-extent (foreign-slot-value capability '(:struct surface-capabilities) :min-image-extent))
	   ;;(min-image-extent-w (foreign-slot-value min-image-extent '(:struct extent-2d) :width))
	   ;;(min-image-extent-h (foreign-slot-value min-image-extent '(:struct extent-2d) :height))
	   (max-image-extent (foreign-slot-value capability '(:struct surface-capabilities) :max-image-extent))
	   ;;(max-image-extent-w (foreign-slot-value max-image-extent '(:struct extent-2d) :width))
	   ;;(max-image-extent-h (foreign-slot-value max-image-extent '(:struct extent-2d) :height))
	   (max-image-array-layers (foreign-slot-value capability '(:struct surface-capabilities) :max-image-array-layers))
	   (supported-transforms (foreign-slot-value capability '(:struct surface-capabilities) :supported-transforms))
	   (current-transform (foreign-slot-value capability '(:struct surface-capabilities) :current-transform))
	   (supported-composite-alpha (foreign-slot-value capability '(:struct surface-capabilities) :supported-composite-alpha))
	   (supported-usage-flags (foreign-slot-value capability '(:struct surface-capabilities) :supported-usage-flags)))
      (list :min-image-count min-image-count
	    :max-image-count max-image-count
#|	    
	    :current-extent (list :current-extent-w current-extent-w
				  :current-extent-h current-extent-h)
	    :min-image-extent (list :min-image-extent-w min-image-extent-w
				    :min-image-extent-h min-image-extent-h)
	    :max-image-extend (list :max-image-extend-w max-image-extent-w
				    :max-image-extend-h max-image-extent-h)
	    |#
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













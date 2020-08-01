(defpackage :vkle
  (:use :cl :cffi :cl-vulkan :cl-glfw3))

(in-package :vkle)

(define-foreign-library libvulkan
  (:windows "vulkan-1.dll")
  (:unix (:or "libvulkan.so")))

(define-foreign-library libglfw3
     (:unix (:or "libglfw.so.3.1" "libglfw.so.3"))
     (:windows "glfw3.dll")
     (t (:or (:default "libglfw3") (:default "libglfw"))))

(use-foreign-library libvulkan)
(use-foreign-library libglfw3)

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

(defun queue-family-index-support-present-p (instance physical-device index)
  (foreign-funcall "glfwGetPhysicalDevicePresentationSupport"
		   :pointer instance
		   :pointer physical-device
		   :uint32 index
		   :boolean))

(defun get-instance-extensions ()
  (with-foreign-object (count :uint32)
    (let* ((extensions (foreign-funcall "glfwGetRequiredInstanceExtensions"
					:pointer count
					:pointer))
	   (extensions-count (- (mem-ref count :uint32) 1)))
      (loop for i from 0 upto extensions-count
	    collect (mem-aref extensions :string i)))))




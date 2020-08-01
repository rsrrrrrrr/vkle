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


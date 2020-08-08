(asdf:defsystem :vkle
  :depends-on (:cffi :cl-glfw3)
  :serial t
  :pathname "src"
  :components ((:file "package")
	       (:file "vulkan-enum-type")
	       (:file "vulkan-basic-type")
	       (:file "vulkan-struct-type")
	       (:file "vulkan-functions")
	       (:file "vkle")))

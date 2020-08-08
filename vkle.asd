(asdf:defsystem :vkle
  :depends-on (:cffi :cl-glfw3)
  :serial t
  :components ((:file "src/package")
	       (:file "src/vulkan-enum-type")
	       (:file "src/vkle")))



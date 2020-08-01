(asdf:defsystem :vkle
  :depends-on (:cffi :cl-vulkan :cl-glfw3)
  :serial t
  :components ((:file "package")
	       (:file "vkle")))

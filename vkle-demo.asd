(asdf:defsystem :vkle-demo
  :depends-on (:cl-vulkan :cl-glfw3 :vkle)
  :serial t
  :pathname "demo"
  :components ((:file "package")
	       (:file "basic-window")
	       (:file "instance")
	       (:file "physical-device")
	       (:file "surface")))

(asdf:defsystem :vkle-demo
  :depends-on (:cl-glfw3 :vkle)
  :serial t
  :pathname "demo"
  :components ((:file "package")
	       (:file "basic-window")
	       (:file "instance")
	       (:file "physical-device")
	       (:file "surface")
	       (:file "logic-device")
	       (:file "swapchain")))

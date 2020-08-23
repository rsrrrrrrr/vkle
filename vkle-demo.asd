(asdf:defsystem :vkle-demo
  :depends-on (:cl-glfw3 :vkle)
  :serial t
  :pathname "demo"
  :components ((:file "test")))

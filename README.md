# vkle
## 1.Install depends 
### 1.1 Instance cffi
```
in repl
(ql:quickload :cffi)
```
### 1.2 Install cl-vulkan
```
cd you-cl-vulkan-path
git clone https://github.com/3b/cl-vulkan.git

in repl 
(push #P"you-cl-vulkan-path" asdf:*central-registry*)
(ql:quickload :cl-glfw3)
```
### 1.3 Install cl-glfw3
```
in repl 
(ql:quickload :cl-glfw3)

because cl-glfw3 use opengl for default, and not support vulkan, so you should add the follow things:
in glfw-bindings.lisp add :no-gl-api in enum opengl-api
(defcenum (opengl-api)
  (:no-gl-api #X00000000)
  (:opengl-api #X00030001)
  (:opengl-es-api #X00030002))
  
in cl-glfw3.lisp you should change function create-window
(if (eq client-api :no-gl-api)
    (setf *window* window)
    (make-context-current window)))))
```
## 2.Load vkel
```
in repl 
(push #P"you-vkel-path" asdf:*central-registry*)
(ql:quickload :vkel)
(ql:quickload :vkel-demo)
```
## 3.Run The demo
|function name|is ok|
|:---|:---|
|instance-demo|OK|
|print-physical-devices-info-demo|OK|

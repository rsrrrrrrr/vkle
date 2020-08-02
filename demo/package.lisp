(defpackage :vkle-demo
  (:use :cl :cl-vulkan :cl-glfw3 :vkle)
  (:export :instance-demo
	   :print-physical-devices-info-demo
	   :surface-demo))

(in-package :vkle-demo)

(defstruct vk-info
  (instance nil)                      ;;The instance
  (physical-devices nil)              ;;The list your gpus
  (physical-devices-properties nil)   ;;The gpus's properties
  (physical-devices-features nil)     ;;The gpus's features             
  (surface nil))                   ;;The vulkan surface
                          

(defparameter *validation-layers*
  (loop for l in '("VK_LAYER_LUNARG_threading"
                   "VK_LAYER_LUNARG_param_checker"
                   "VK_LAYER_LUNARG_device_limits"
                   "VK_LAYER_LUNARG_object_tracker"
                   "VK_LAYER_LUNARG_image"
                   "VK_LAYER_LUNARG_mem_tracker"
                   "VK_LAYER_LUNARG_draw_state"
                   "VK_LAYER_LUNARG_swapchain"
                   "VK_LAYER_GOOGLE_unique_objects")
        collect (list l :optional t)))

(defparameter *instance-extensions* nil)
(defparameter *instance-layer-names*
  `(,@*validation-layers*
    ("VK_LAYER_LUNARG_api_dump" :optional t)))


(defparameter *info* (make-vk-info))

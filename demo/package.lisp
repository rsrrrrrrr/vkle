(defpackage :vkle-demo
  (:use :cl :cl-vulkan :cl-glfw3 :vkle)
  (:export :instance-demo
	   :print-physical-devices-info-demo
	   :surface-demo
	   :logic-device-demo))

(in-package :vkle-demo)

(defstruct vk-info
  (instance nil)                      ;;The instance
  (physical-devices nil)              ;;The list your gpus
  (physical-devices-properties nil)   ;;The gpus's properties
  (physical-devices-features nil)     ;;The gpus's features
  (gpu nil)                           ;;The gpu whitch you use
  (gpu-properties nil)                ;;The gpu properties
  (gpu-features nil)                  ;;The gpu features
  (gpu-queue-families nil)            ;;The gpu queue families
  (gpu-graphics-queues nil)           ;;The gpu graphics queues
  (gpu-transfer-queues nil)           ;;The gpu transfer queues
  (gpu-present-queues)                ;;The gpu oresent queues
  (queue-families nil)
  (queue-family-index nil)
  (queue-properties nil)
  (logic-device nil)
  (surface nil))                      ;;The vulkan surface
                          

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

(defparameter *device-layer-names* *validation-layers*)
(defparameter *device-extension-names*
  '(:khr-swapchain))

(defparameter *queue-priorities* '(:present 1.0 :graphics 0.5 :transfer 0.0))

(defparameter *info* (make-vk-info))

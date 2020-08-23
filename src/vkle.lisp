(in-package :vkle)

(export '(queue-family-support-mode-p))

(defun queue-family-support-mode-p (val &key (mode :queue-graphics-bit))
  "val is a type of uint32, mode is a enumerate type of VkQueueFlagBits"
  (when (/= (logand val (foreign-enum-value 'VkQueueFlagBits mode)) 0)
    t))

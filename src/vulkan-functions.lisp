(in-package :vkle)

(export '(get-vulkan-support
	  queue-family-index-support-present-p
	  destroy-instance
	  get-device-proc-addr
	  get-instance-proc-addr
	  destroy-device
	  queue-wait-idle
	  device-wait-idle
	  free-memory
	  unmap-memory
	  bind-buffer-memory
	  bind-image-memor
	  get-fence-status
	  destroy-semaphore
	  get-event-status
	  set-event
	  reset-event))

(defcfun ("glfwVulkanSupported" get-vulkan-support) :boolean
  "return true if vulkan is available")

(defcfun ("glfwGetPhysicalDevicePresentationSupport" queue-family-index-support-present-p) :int
  (instance vk-handle)
  (physical-device vk-handle)
  (index :uint32))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;create function area;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defcfun ("vkCreateInstance" vkCreateInstance) VkResult
  (info (:pointer (:struct vk-instance-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (position vk-instance))

(defcfun ("vkDestroyInstance" destroy-instance) :void
  (instance vk-instance)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreateDevice" vkCreateDevice) VkResult
  (physical-device vk-physical-device)
  (info (:pointer (:struct vk-device-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (device (:pointer vk-device)))

(defcfun ("vkDestroyDevice" destroy-device) :void
  (device vk-device)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreateFence" vkCreateFence) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-fence-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (fence (:pointer vk-fence)))

(defcfun ("vkDestroyFence" destroy-fence) :void
  (device vk-device)
  (fence vk-fence)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreateSemaphore" vkCreateSemaphore) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-semaphore-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (semaphore (:pointer vk-semaphore)))

(defcfun ("vkDestroySemaphore" destroy-semaphore) :void
  (device vk-device)
  (semaphore vk-semaphore)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreateEvent" vkCreateEvent) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-event-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (event (:pointer vk-event)))

(defcfun ("vkDestroyEvent" destroy-event) :void
  (device vk-device)
  (event vk-event)
  (allocator (:pointer (:struct vk-allocation-callback))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;get function area;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defcfun ("vkEnumeratePhysicalDevices" vkEnumeratePhysicalDevices) VkResult
  (instance vk-instance)
  (count (:pointer :uint32))
  (physical-devices (:pointer vk-physical-device)))

(defcfun ("vkGetDeviceProcAddr" get-device-proc-addr) (:pointer :void)
  (device vk-device)
  (name :string))

(defcfun ("vkGetInstanceProcAddr" get-instance-proc-addr) (:pointer :void)
  (instance vk-instance)
  (name :string))

(defcfun ("vkGetPhysicalDeviceProperties" vkGetPhysicalDeviceProperties) :void
  (physical-device vk-physical-device)
  (properties (:pointer (:struct vk-physical-device-properties))))

(defcfun ("vkGetPhysicalDeviceQueueFamilyProperties" vkGetPhysicalDeviceQueueFamilyProperties) :void
  (physical-device vk-physical-device)
  (count (:pointer :uint32))
  (properties (:pointer (:struct vk-queue-family-properties))))

(defcfun ("vkGetPhysicalDeviceMemoryProperties" vkGetPhysicalDeviceMemoryProperties) :void
  (physical-device vk-physical-device)
  (properties (:pointer (:struct vk-physical-device-memory-properties))))

(defcfun ("vkGetPhysicalDeviceFeatures" vkGetPhysicalDeviceFeatures) :void
  (physical-device vk-physical-device)
  (features (:pointer (:struct vk-physical-device-features))))

(defcfun ("vkGetPhysicalDeviceFormatProperties" vkGetPhysicalDeviceFormatProperties) :void
  (physical-device vk-physical-device)
  (format VkFormat)
  (properties (:pointer (:struct vk-format-properties))))

(defcfun ("vkGetPhysicalDeviceImageFormatProperties" vkGetPhysicalDeviceImageFormatProperties) :void
  (physical-device vk-physical-device)
  (format VkFormat)
  (type VkImageType)
  (tiling VkImageTiling)
  (usage vk-image-usage-flags)
  (flags vk-image-create-flags)
  (properties (:pointer (:struct vk-image-format-properties))))

(defcfun ("vkEnumerateInstanceVersion" vkEnumerateInstanceVersion) VkResult
  (version (:pointer :uint32)))

(defcfun ("vkEnumerateInstanceLayerProperties" vkEnumerateInstanceLayerProperties) VkResult
  (count (:pointer :uint32))
  (properties (:pointer (:struct vk-layer-properties))))

(defcfun ("vkEnumerateInstanceExtensionProperties" vkEnumerateInstanceExtensionProperties) VkResult
  (layer-name :string)
  (count (:pointer :uint32))
  (properties (:pointer (:struct vk-extension-properties))))

(defcfun ("vkEnumerateDeviceLayerProperties" vkEnumerateDeviceLayerProperties) VkResult
  (physical-device vk-physical-device)
  (count (:pointer :uint32))
  (properties (:pointer (:struct vk-layer-properties))))

(defcfun ("vkEnumerateDeviceExtensionProperties" vkEnumerateDeviceExtensionProperties) VkResult
  (physical-device vk-physical-device)
  (layer-name :string)
  (count (:pointer :uint32))
  (properties (:pointer (:struct vk-extension-properties))))

(defcfun ("vkGetDeviceMemoryCommitment" vkGetDeviceMemoryCommitment) :void
  (device vk-device)
  (memory vk-device-memory)
  (commitment-in-bytes (:pointer vk-device-size)))

(defcfun ("vkGetBufferMemoryRequirements" vkGetBufferMemoryRequirements) :void
  (device vk-device)
  (buffer vk-buffer)
  (requirements (:pointer (:struct vk-memory-requirements))))

(defcfun ("vkGetImageMemoryRequirements" vkGetImageMemoryRequirements) :void
  (device vk-device)
  (image vk-image)
  (requirements (:pointer (:struct vk-memory-requirements))))

(defcfun ("vkGetImageSparseMemoryRequirements" vkGetImageSparseMemoryRequirements) :void
  (device vk-device)
  (image vk-image)
  (count (:pointer :uint32))
  (requirements (:pointer (:struct vk-sparse-image-memory-requirements))))

(defcfun ("vkGetPhysicalDeviceSparseImageFormatProperties" vkGetPhysicalDeviceSparseImageFormatProperties) :void
  (physical-device vk-physical-device)
  (format VkFormat)
  (type VkImageType)
  (samples VkSampleCountFlagBits)
  (usage vk-image-usage-flags)
  (tiling VkImageTiling)
  (count (:pointer :uint32))
  (properties (:pointer (:struct vk-sparse-image-format-properties))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;queue operation function area;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defcfun ("vkGetDeviceQueue" vkGetDeviceQueue) :void
  (device vk-device)
  (family-index :uint32)
  (index :uint32)
  (queue (:pointer vk-queue)))

(defcfun ("vkQueueSubmit" vkQueueSubmit) VkResult
  (queue vk-queue)
  (count :uint32)
  (info (:pointer (:struct vk-submit-info)))
  (fence vk-fence))

(defcfun ("vkQueueBindSparse" vkQueueBindSparse) VkResult
  (queue vk-queue)
  (count :uint32)
  (bind-info (:pointer (:struct vk-bind-sparse-info)))
  (fence vk-fence))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;memory function area;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defcfun ("vkAllocateMemory" vkAllocateMemory) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-memory-allocate-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (memory (:pointer vk-device-memory)))

(defcfun ("vkFreeMemory" free-memory) :void
  (device vk-device)
  (memory vk-device-memory)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkMapMemory" vkMapMemory) VkResult
  (device vk-device)
  (memory vk-device-memory)
  (offset vk-device-size)
  (size vk-device-size)
  (flags vk-memory-map-flags)
  (data (:pointer (:pointer :void))))

(defcfun ("vkUnmapMemory" unmap-memory) :void
  (device vk-device)
  (memory vk-device-memory))

(defcfun ("vkFlushMappedMemoryRanges" vkFlushMappedMemoryRanges) VkResult
  (device vk-device)
  (count :uint32)
  (memory-ranges (:pointer (:struct vk-mapped-memory-range))))

(defcfun ("vkInvalidateMappedMemoryRanges" vkInvalidateMappedMemoryRanges) VkResult
  (device vk-device)
  (count :uint32)
  (memory-ranges (:pointer (:struct vk-mapped-memory-range))))

(defcfun ("vkBindBufferMemory" bind-buffer-memory) VkResult
  (device vk-device)
  (buffer vk-buffer)
  (memory vk-device-memory)
  (offset vk-device-size))

(defcfun ("vkBindImageMemory" bind-image-memory) VkResult
  (device vk-device)
  (image vk-image)
  (memory vk-device-memory)
  (offset vk-device-size))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;fence function area;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defcfun ("vkResetFences" vkResetFences) VkResult
  (device vk-device)
  (count :uint32)
  (fence (:pointer vk-fence)))

(defcfun ("vkGetFenceStatus" get-fence-status) VkResult
  (device vk-device)
  (fence vk-fence))

(defcfun ("vkWaitForFences" vkWaitForFences) VkResult
  (device vk-device)
  (count :uint32)
  (fence (:pointer vk-fence))
  (wait-all vk-bool-32)
  (timeout :uint64))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;event function area;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defcfun ("vkGetEventStatus" get-event-status) VkResult
  (device vk-device)
  (evnet vk-event))

(defcfun ("vkSetEvent" set-event) VkResult
  (device vk-device)
  (event vk-event))

(defcfun ("vkResetEvent" reset-event) VkResult
  (device vk-device)
  (event vk-event))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;normal function area;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defcfun ("vkQueueWaitIdle" queue-wait-idle) VkResult
  (queue vk-queue))

(defcfun ("vkDeviceWaitIdle" device-wait-idle) VkResult
  (device vk-device))

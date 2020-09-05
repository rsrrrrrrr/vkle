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
n	  get-event-status
	  set-event
	  reset-event
	  reset-query-pool
	  destroy-buffer
	  destroy-buffer-view
	  destroy-image
	  destroy-image-view
	  destroy-shader-module
	  destroy-pipeline-cache
	  destroy-pipeline
	  destroy-descriptor-set-layout
	  destroy-descriptor-pool
	  reset-descriptor-pool
	  destroy-framebuffer
	  destroy-render-pass
	  destroy-command-pool
	  reset-command-pool
	  end-command-buffer
	  cmd-bind-pipeline
	  cmd-set-line-width
	  cmd-set-depth-bias
	  cmd-set-depth-bounds
	  cmd-set-stencil-cpmpare-mask
	  cmd-set-stencil-write-mask
	  cmd-set-stencil-reference
	  cmd-bind-index-buffer
	  cmd-draw
	  cmd-draw-indexed
	  cmd-draw-indirect
	  cmd-draw-indexed-indirect
	  cmd-dispatch
	  cmd-dispatch-indirect
	  cmd-fill-buffer
	  cmd-set-evnet
	  cmd-reset-event
	  cmd-begin-query
	  cmd-end-query
	  cmd-end-conditional-rendering-ext
	  cmd-reset-query-pool
	  cmd-write-timestamp
	  cmd-copy-query-pool-results
	  cmd-next-subpass
	  cmd-end-render-pass
	  destroy-surface-khr
	  destroy-swapchain-khr
	  destroy-degbu-report-callback-ext
	  debug-report-message-ext
	  cmd-debug-marker-end-ext
	  cmd-bind-pipeline-shader-group-nv))

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

(defcfun ("vkCreateQueryPool" vkCreateQueryPool) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-query-pool-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (pool (:pointer vk-query-pool)))

(defcfun ("vkDestroyQueryPool" destroy-query-pool) :void
  (device vk-device)
  (pool vk-query-pool)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreateBuffer" vkCreateBuffer) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-buffer-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (buffer (:pointer vk-buffer)))

(defcfun ("vkDestroyBuffer" destroy-buffer) :void
  (device vk-device)
  (buffer vk-bool-32)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreateBufferView" vkCreateBufferView) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-buffer-view-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (buffer-view (:pointer vk-buffer-view)))

(defcfun ("vkDestroyBufferView" destroy-buffer-view) :void
  (device vk-device)
  (buffer-view vk-buffer-view)
  (allocator (:pointer vk-buffer-view)))

(defcfun ("vkCreateImage" vkCreateImage) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-image-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (image (:pointer vk-image)))

(defcfun ("vkDestroyImage" destroy-image) :void
  (device vk-device)
  (image vk-image)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreateImageView" vkCreateImageView) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-image-view-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (image-view (:pointer vk-image-view)))

(defcfun ("vkDestroyImageView" destroy-image-view) :void
  (device vk-device)
  (image-view vk-image-view)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreateShaderModule" vkCreateShaderModule) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-shader-module-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (module (:pointer vk-shader-module)))

(defcfun ("vkDestroyShaderModule" destroy-shader-module) :void
  (device vk-device)
  (module vk-shader-module)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreatePipelineCache" vkCreatePipelineCache) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-pipeline-cache-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (pipeline-cache (:pointer vk-pipeline-cache)))

(defcfun ("vkDestroyPipelineCache" destroy-pipeline-cache) :void
  (device vk-device)
  (pipeline-cache vk-pipeline-cache)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreateGraphicsPipelines" vkCreateGraphicsPipelines) VKResult
  (device vk-device)
  (cache vk-pipeline-cache)
  (info-count :uint32)
  (infos (:pointer (:struct vk-graphics-pipeline-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (pipeline (:pointer vk-pipeline)))

(defcfun ("vkCreateComputePipelines" vkCreateComputePipelines) VkResult
  (device vk-device)
  (cache vk-pipeline-cache)
  (info-count :uint32)
  (infos (:pointer (:struct vk-compute-pipeline-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (pipeline (:pointer vk-pipeline)))

(defcfun ("vkDestroyPipeline" destroy-pipeline) :void
  (device vk-device)
  (pipeline vk-pipeline)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreateFramebuffer" vkCreateFramebuffer) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-framebuffer-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (framebuffer (:pointer vk-framebuffer)))

(defcfun ("vkDestroyFramebuffer" destroy-framebuffer) :void
  (device vk-device)
  (framebuffer vk-framebuffer)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreateRenderPass" vkCreateRenderPass) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-render-pass-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (render-pass (:pointer vk-render-pass)))

(defcfun ("vkDestroyRenderPass" destroy-render-pass) :void
  (device vk-device)
  (render-pass vk-render-pass)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreatePipelineLayout" vkCreatePipelineLayout) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-pipeline-layout-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (layout (:pointer vk-pipeline-layout)))

(defcfun ("vkDestroyPipelineLayout" destroy-pipeline-layout) :void
  (device vk-device)
  (pipeline vk-pipeline)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreateSampler" vkCreateSampler) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-sampler-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (sampler (:pointer vk-sampler)))

(defcfun ("vkDestroySampler" destroy-sampler) :void
  (device vk-device)
  (sampler vk-sampler)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreateDescriptorSetLayout" vkCreateDescriptorSetLayout) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-descriptor-set-layout-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (layout (:pointer vk-descriptor-set-layout)))

(defcfun ("vkDestroyDescriptorSetLayout" destroy-descriptor-set-layout) :void
  (device vk-device)
  (layout vk-descriptor-set-layout)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreateDescriptorPool" vkCreateDescriptorPool) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-descriptor-pool-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (pool (:pointer vk-descriptor-pool)))

(defcfun ("vkDestroyDescriptorPool" destroy-descriptor-pool) :void
  (device vk-device)
  (pool vk-descriptor-pool)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreateCommandPool" vkCreateCommandPool) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-command-pool-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (pool (:pointer vk-command-pool)))

(defcfun ("vkDestroyCommandPool" destroy-command-pool) :void
  (device vk-device)
  (pool vk-command-pool)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreateDisplayModeKHR" vkCreateDisplayModeKHR) VkResult
  (physical-device vk-physical-device)
  (display vk-display-khr)
  (info (:pointer (:struct vk-display-mode-create-info-khr)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (mode (:pointer vk-display-mode-khr)))

(defcfun ("vkCreateDisplayPlaneSurfaceKHR" vkCreateDisplayPlaneSurfaceKHR) VkResult
  (instance vk-instance)
  (info (:pointer (:struct vk-display-surface-create-info-khr)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (surface (:pointer vk-surface-khr)))

(defcfun ("vkDestroySurfaceKHR" destroy-surface-khr) :void
  (instace vk-instance)
  (surface vk-surface-khr)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreateSharedSwapchainsKHR" vkCreateSharedSwapchainsKHR) VKResult
  (device vk-device)
  (swapchain-count :uint32)
  (infos (:pointer (:struct vk-swapchain-create-info-khr)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (swapchain (:pointer vk-swapchain-khr)))

(defcfun ("vkCreateSwapchainKHR" vkCreateSwapchainKHR) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-swapchain-create-info-khr)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (swapchain (:pointer vk-swapchain-khr)))

(defcfun ("vkDestroySwapchainKHR" destroy-swapchain-khr) :void
  (device vk-device)
  (swapchain vk-swapchain-khr)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreateDebugReportCallbackEXT" vkCreateDebugReportCallbackEXT) VkResult
  (instance vk-instance)
  (info (:pointer (:struct vk-debug-report-callback-create-info-ext)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (callback (:pointer vk-debug-report-callback-ext)))

(defcfun ("vkDestroyDebugReportCallbackEXT" destroy-degbu-report-callback-ext) :void
  (instance vk-instance)
  (callback vk-debug-report-callback-ext)
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

(defcfun ("vkGetQueryPoolResults" vkGetQueryPoolResults) VkResult
  (device vk-device)
  (pool vk-query-pool)
  (fire-query :uint32)
  (count :uint32)
  (data-size :unsigned-int)
  (data (:pointer :void))
  (stride vk-device-size)
  (flags vk-query-result-flags))

(defcfun ("vkGetImageSubresourceLayout" vkGetImageSubresourceLayout) :void
  (device vk-device)
  (image vk-image)
  (subresource (:pointer (:struct vk-image-subresource)))
  (layout (:pointer (:struct vk-subresource-layout))))

(defcfun ("vkGetPipelineCacheData" vkGetPipelineCacheData) VkResult
  (device vk-device)
  (pipeline-cache vk-pipeline-cache)
  (size (:pointer :unsigned-int))
  (data (:pointer :void)))

(defcfun ("vkGetRenderAreaGranularity" vkGetRenderAreaGranularity) :void
  (device vk-device)
  (render-pass vk-render-pass)
  (granularity (:pointer (:struct vk-extent-2d))))

(defcfun ("vkGetPhysicalDeviceDisplayPropertiesKHR" vkGetPhysicalDeviceDisplayPropertiesKHR) VkResult
  (physical-device vk-physical-device)
  (count (:pointer :uint32))
  (properties (:pointer (:struct vk-display-properties-khr))))

(defcfun ("vkGetPhysicalDeviceDisplayPlanePropertiesKHR" vkGetPhysicalDeviceDisplayPlanePropertiesKHR) VkResult
  (physical-device vk-physical-device)
  (count (:pointer :uint32))
  (properties (:pointer (:struct vk-display-plane-properties-khr))))

(defcfun ("vkGetDisplayPlaneSupportedDisplaysKHR" vkGetDisplayPlaneSupportedDisplaysKHR) VkResult
  (physical-device vk-physical-device)
  (index :uint32)
  (count (:pointer :uint32))
  (dsiplay-khr (:pointer vk-display-khr)))

(defcfun ("vkGetDisplayModePropertiesKHR" vkGetDisplayModePropertiesKHR) VkResult
  (physical-device vk-physical-device)
  (display vk-display-khr)
  (count :uint32)
  (properties (:pointer (:struct vk-display-mode-properties-khr))))

(defcfun ("vkGetDisplayPlaneCapabilitiesKHR" vkGetDisplayPlaneCapabilitiesKHR) VKResult
  (physical-device vk-physical-device)
  (mode vk-display-mode-khr)
  (index :uint32)
  (capabilities (:pointer (:struct vk-display-plane-capabilities-khr))))

(defcfun ("vkGetPhysicalDeviceSurfaceSupportKHR" vkGetPhysicalDeviceSurfaceSupportKHR) VkResult
  (physical-device vk-physical-device)
  (queue-family-index :uint32)
  (surface vk-surface-khr)
  (support-p (:pointer vk-bool-32)))

(defcfun ("vkGetPhysicalDeviceSurfaceCapabilitiesKHR" vkGetPhysicalDeviceSurfaceCapabilitiesKHR) VkResult
  (physical-device vk-physical-device)
  (surface vk-surface-khr)
  (capabilities (:pointer (:struct vk-surface-capabilities-khr))))

(defcfun ("vkGetPhysicalDeviceSurfaceFormatsKHR" vkGetPhysicalDeviceSurfaceFormatsKHR) VkResult
  (physical-device vk-physical-device)
  (surface vk-surface-khr)
  (count (:pointer :uint32))
  (format (:pointer (:struct vk-surface-format-khr))))

(defcfun ("vkGetPhysicalDeviceSurfacePresentModesKHR" vkGetPhysicalDeviceSurfacePresentModesKHR) VkResult
  (physical-device vk-physical-device)
  (surface vk-surface-khr)
  (count (:pointer :uint32))
  (present-mode (:pointer VkPresentModeKHR)))

(defcfun ("vkGetSwapchainImagesKHR" vkGetSwapchainImagesKHR) VkResult
  (device vk-device)
  (swapchain vk-swapchain-khr)
  (count (:pointer :uint32))
  (swapchain-images (:pointer vk-image)))

(defcfun ("vkAcquireNextImageKHR" vkAcquireNextImageKHR) VkResult
  (device vk-device)
  (swapchain vk-swapchain-khr)
  (timeout :uint64)
  (semaphore vk-semaphore)
  (fence vk-fence)
  (image-index (:pointer :uint32)))

(defcfun ("vkGetPhysicalDeviceExternalImageFormatPropertiesNV" vkGetPhysicalDeviceExternalImageFormatPropertiesNV) VKResult
  (physical-device vk-physical-device)
  (format VkFormat)
  (type VkImageType)
  (tiling VkImageTiling)
  (usage vk-image-usage-flags)
  (flags vk-image-create-flags)
  (external-handle-type vk-external-memory-handle-type-flags-nv)
  (external-image-format-properties (:pointer (:struct vk-external-image-format-properties-nv))))

(defcfun ("vkGetMemoryWin32HandleNV" vkGetMemoryWin32HandleNV) VkResult
  (device vk-device)
  (memory vk-device-memory)
  (handler-type vk-external-memory-handle-type-flags-nv)
  (handle (:pointer (:pointer :uint16))))
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

(defcfun ("vkQueuePresentKHR" vkQueuePresentKHR) VkResult
  (queue vk-queue)
  (info (:pointer (:struct vk-present-info-khr))))
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

(defcfun ("vkAllocateDescriptorSets" vkAllocateDescriptorSets) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-descriptor-set-allocate-info)))
  (sets (:pointer vk-descriptor-set)))

(defcfun ("vkFreeDescriptorSets" vkFreeDescriptorSets) VkResult
  (device vk-device)
  (pool vk-descriptor-pool)
  (count :uint32)
  (sets (:pointer vk-descriptor-set)))

(defcfun ("vkUpdateDescriptorSets" vkUpdateDescriptorSets) VkResult
  (device vk-device)
  (wirte-count :uint32)
  (write-sets (:pointer (:struct vk-write-descriptor-set)))
  (copy-count :uint32)
  (copy-sets (:pointer (:struct vk-copy-descriptor-set))))
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
;;;;;;;;;;;;;;;;;;;query pool function area;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defcfun ("vkResetQueryPool" reset-query-pool) :void
  (device vk-device)
  (pool vk-query-pool)
  (first-query :uint32)
  (count :uint32))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;descriptor pool function area;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defcfun ("vkResetDescriptorPool" reset-descriptor-pool) VKResult
  (device vk-device)
  (pool vk-descriptor-pool)
  (flags vk-descriptor-pool-reset-flags))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;pipeline cache function area;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defcfun ("vkMergePipelineCaches" vkMergePipelineCaches) VkResult
  (device vk-device)
  (dst-cache vk-pipeline-cache)
  (count :uint32)
  (src-cache (:pointer vk-pipeline-cache)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;command pool function area;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defcfun ("vkResetCommandPool" reset-command-pool) VkResult
  (device vk-device)
  (pool vk-command-pool)
  (flags vk-command-pool-reset-flags))

(defcfun ("vkAllocateCommandBuffers" vkAllocateCommandBuffers) VkResult
  (device vk-device)
  (allocator (:pointer (:struct vk-command-buffer-allocate-info)))
  (command-buffers (:pointer vk-command-buffer)))

(defcfun ("vkFreeCommandBuffers" vkFreeCommandBuffers) :void
  (device vk-device)
  (command-pool vk-command-pool)
  (count :uint32)
  (command-buffers (:pointer vk-command-buffer)))

(defcfun ("vkBeginCommandBuffer" vkBeginCommandBuffer) VkResult
  (command-buffer vk-command-buffer)
  (info (:pointer (:struct vk-command-buffer-begin-info))))

(defcfun ("vkEndCommandBuffer" end-command-buffer) VkResult
  (command-buffer vk-command-buffer))

(defcfun ("vkResetCommandBuffer" reset-command-buffer) VkResult
  (command-buffer vk-command-buffer)
  (flags vk-command-buffer-reset-flags))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;cmd function area;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defcfun ("vkCmdBindPipeline" cmd-bind-pipeline) :void
  (command-buffer vk-command-buffer)
  (pipeline-bind-point VkPipelineBindPoint)
  (pipeline vk-pipeline))

(defcfun ("vkCmdSetViewport" vkCmdSetViewport) :void
  (command-buffer vk-command-buffer)
  (first-viewport :uint32)
  (count :uint32)
  (viewports (:pointer (:struct vk-viewport))))

(defcfun ("vkCmdSetScissor" vkCmdSetScissor) :void
  (command-buffer vk-command-buffer)
  (first-scissor :uint32)
  (count :uint32)
  (scissors (:pointer (:struct vk-rect-2d))))

(defcfun ("vkCmdSetLineWidth" cmd-set-line-width) :void
  (command-buffer vk-command-buffer)
  (width :float))

(defcfun ("vkCmdSetDepthBias" cmd-set-depth-bias) :void
  (command-buffer vk-command-buffer)
  (constant-factor :float)
  (clamp :float)
  (slope-factor :float))

(defcfun ("vkCmdSetBlendConstants" vkCmdSetBlendConstants) :void
  (command-buffer vk-command-buffer)
  (blend-constants :float :count 4))

(defcfun ("vkCmdSetDepthBounds" cmd-set-depth-bounds) :void
  (command-buffer vk-command-buffer)
  (min :float)
  (max :float))

(defcfun ("vkCmdSetStencilCompareMask" cmd-set-stencil-cpmpare-mask) :void
  (command-buffer vk-command-buffer)
  (face-mask vk-stencil-face-flags)
  (compare-mask :uint32))

(defcfun ("vkCmdSetStencilWriteMask" cmd-set-stencil-write-mask) :void
  (command-buffer vk-command-buffer)
  (face-mask vk-stencil-face-flags)
  (write-mask :uint32))

(defcfun ("vkCmdSetStencilReference" cmd-set-stencil-reference) :void
  (command-buffer vk-command-buffer)
  (face-mask vk-stencil-face-flags)
  (reference :uint32))

(defcfun ("vkCmdBindDescriptorSets" vkCmdBindDescriptorSets) :void
  (command-buffer vk-command-buffer)
  (pipeline-bind-point VkPipelineBindPoint)
  (layout vk-pipeline-layout)
  (first :uint32)
  (set-count :uint32)
  (sets (:pointer vk-descriptor-set))
  (offset-count :uint32)
  (offsets (:pointer :uint32)))

(defcfun ("vkCmdBindIndexBuffer" cmd-bind-index-buffer) :void
  (command-buffer vk-command-buffer)
  (buffer vk-buffer)
  (offset vk-device-size)
  (index-type VkIndexType))

(defcfun ("vkCmdBindVertexBuffers" vkCmdBindVertexBuffers) :void
  (command-buffer vk-command-buffer)
  (first-binding :uint32)
  (count :uint32)
  (buffers (:pointer vk-buffer))
  (offsets (:pointer vk-device-size)))

(defcfun ("vkCmdDraw" cmd-draw) :void
  (command-buffer vk-command-buffer)
  (vertex-count :uint32)
  (instance-count :uint32)
  (first-vertex :uint32)
  (first-instance :uint32))

(defcfun ("vkCmdDrawIndexed" cmd-draw-indexed) :void
  (command-buffer vk-command-buffer)
  (index-count :uint32)
  (instance-count :uint32)
  (firset-index :uint32)
  (vertex-offset :int32)
  (firset-instance :uint32))

(defcfun ("vkCmdDrawIndirect" cmd-draw-indirect) :void
  (command-buffer vk-command-buffer)
  (buffer vk-buffer)
  (offset vk-device-size)
  (draw-count :uint32)
  (stride :uint32))

(defcfun ("vkCmdDrawIndexedIndirect" cmd-draw-indexed-indirect) :void
  (command-buffer vk-command-buffer)
  (buffer vk-buffer)
  (offset vk-device-size)
  (draw-count :uint32)
  (stride :uint32))

(defcfun ("vkCmdDispatch" cmd-dispatch) :void
  (command-buffer vk-command-buffer)
  (count-x :uint32)
  (count-y :uint32)
  (count-z :uint32))

(defcfun ("vkCmdDispatchIndirect" cmd-dispatch-indirect) :void
  (command-buffer vk-command-buffer)
  (buffer vk-buffer)
  (offset vk-device-size))

(defcfun ("vkCmdCopyBuffer" vkCmdCopyBuffer) :void
  (command-buffer vk-command-buffer)
  (src-buffer vk-buffer)
  (dst-buffer vk-buffer)
  (count :uint32)
  (regions (:pointer (:struct vk-buffer-copy))))

(defcfun ("vkCmdCopyImage" vkCmdCopyImage) :void
  (command-buffer vk-command-buffer)
  (src-image vk-image)
  (src-image-layout VkImageLayout)
  (dst-image vk-image)
  (dst-image-layout VkImageLayout)
  (count :uint32)
  (regions (:pointer (:struct vk-image-copy))))

(defcfun ("vkCmdBlitImage" vkCmdBlitImage) :void
  (command-buffer vk-command-buffer)
  (src-image vk-image)
  (src-image-layout VkImageLayout)
  (dst-image vk-image)
  (dst-image-layout VkImageLayout)
  (count :uint32)
  (regions (:pointer (:struct vk-image-blit)))
  (filter VkFilter))

(defcfun ("vkCmdCopyBufferToImage" vkCmdCopyBufferToImage) :void
  (command-buffer vk-command-buffer)
  (src-buffer vk-buffer)
  (dst-image vk-image)
  (dst-image-layout VkImageLayout)
  (count :uint32)
  (regions (:pointer (:struct vk-buffer-image-copy))))

(defcfun ("vkCmdCopyImageToBuffer" vkCmdCopyImageToBuffer) :void
  (command-buffer vk-command-buffer)
  (src-image vk-image)
  (src-image-layout VkImageLayout)
  (dst-buffer vk-buffer)
  (count :uint32)
  (regions (:pointer (:struct vk-buffer-image-copy))))

(defcfun ("vkCmdUpdateBuffer" vkCmdUpdateBuffer) :void
  (command-buffer vk-command-buffer)
  (dst-buffer vk-buffer)
  (dst-offset vk-device-size)
  (data-size vk-device-size)
  (data (:pointer :void)))

(defcfun ("vkCmdFillBuffer" cmd-fill-buffer) :void
  (command-buffer vk-command-buffer)
  (dst-buffer vk-buffer)
  (dst-offset vk-device-size)
  (size vk-device-size)
  (data :uint32))

(defcfun ("vkCmdClearColorImage" vkCmdClearColorImage) :void
  (command-buffer vk-command-buffer)
  (image vk-image)
  (image-layout VkImageLayout)
  (color (:pointer (:union vk-clear-color-value)))
  (count :uint32)
  (ranges (:pointer (:struct vk-image-subresource-range))))

(defcfun ("vkCmdClearDepthStencilImage" vkCmdClearDepthStencilImage) :void
  (command-buffer vk-command-buffer)
  (image vk-image)
  (image-layout VkImageLayout)
  (depth-stencil (:pointer (:struct vk-clear-depth-stencil-value)))
  (count :uint32)
  (ranges (:pointer (:struct vk-image-subresource-range))))

(defcfun ("vkCmdClearAttachments" vkCmdClearAttachments) :void
  (command-buffer vk-command-buffer)
  (attachment-count :uint32)
  (attachments (:pointer (:struct vk-clear-attachment)))
  (rect-count :uint32)
  (rects (:pointer (:struct vk-clear-rect))))

(defcfun ("vkCmdResolveImage" vkCmdResolveImage) :void
  (command-buffer vk-command-buffer)
  (src-image vk-image)
  (src-image-layout VkImageLayout)
  (dst-image vk-image)
  (dst-image-layout VkImageLayout)
  (count :uint32)
  (regions (:pointer (:struct vk-image-resloved))))

(defcfun ("vkCmdSetEvent" cmd-set-evnet) :void
  (command-buffers vk-command-buffer)
  (event vk-event)
  (mask vk-pipeline-stage-flags))

(defcfun ("vkCmdResetEvent" cmd-reset-event) :void
  (command-buffer vk-command-buffer)
  (event vk-event)
  (mask vk-pipeline-stage-flags))

(defcfun ("vkCmdWaitEvents" vkCmdWaitEvents) :void
  (command-buffer vk-command-buffer)
  (event-count :uint32)
  (events (:pointer vk-event))
  (src-stage-mask vk-pipeline-stage-flags)
  (dst-stage-mask vk-pipeline-stage-flags)
  (memory-barrier-count :uint32)
  (memory-barriers (:pointer (:struct vk-memory-barrier)))
  (buffer-memory-barrier-count :uint32)
  (buffer-memory-barriers (:pointer (:struct vk-buffer-memory-barrier)))
  (image-memory-barrier-count :uint32)
  (image-memory-barriers (:pointer (:struct vk-image-memory-barrier))))

(defcfun ("vkCmdPipelineBarrier" vkCmdPipelineBarrier) :void
  (command-buffer vk-command-buffer)
  (src-stage-mask vk-pipeline-stage-flags)
  (dst-stage-mask vk-pipeline-stage-flags)
  (dependency-flags vk-dependency-flags)
  (memory-barrier-count :uint32)
  (memory-barriers (:pointer (:struct vk-memory-barrier)))
  (buffer-memory-barrier-count :uint32)
  (buffer-memory-barriers (:pointer (:struct vk-buffer-memory-barrier)))
  (image-memory-barrier-count :uint32)
  (image-memory-barriers (:pointer (:struct vk-image-memory-barrier))))

(defcfun ("vkCmdBeginQuery" cmd-begin-query) :void
  (command-buffer vk-command-buffer)
  (pool vk-query-pool)
  (query :uint32)
  (flags vk-query-control-flags))

(defcfun ("vkCmdEndQuery" cmd-end-query) :void
  (command-buffer vk-command-buffer)
  (query-pool vk-query-pool)
  (query :uint32))

(defcfun ("vkCmdBeginConditionalRenderingEXT" vkCmdBeginConditionalRenderingEXT) :void
  (command-buffer vk-buffer)
  (conditional-rendering-begin (:pointer (:struct vk-conditional-rendering-begin-info-ext))))

(defcfun ("vkCmdEndConditionalRenderingEXT" cmd-end-conditional-rendering-ext) :void
  (command-buffer vk-command-buffer))

(defcfun ("vkCmdResetQueryPool" cmd-reset-query-pool) :void
  (command-buffer vk-command-buffer)
  (query-pool vk-query-pool)
  (first-query :uint32)
  (query-count :uint32))

(defcfun ("vkCmdWriteTimestamp" cmd-write-timestamp) :void
  (command-buffer vk-command-buffer)
  (pipeline-stage VkPipelineStageFlagBits)
  (quert-pool vk-query-pool)
  (query :uint32))

(defcfun ("vkCmdCopyQueryPoolResults" cmd-copy-query-pool-results) :void
  (command-buffer vk-command-buffer)
  (query-pool vk-query-pool)
  (first-query :uint32)
  (query-count :uint32)
  (dst-buffer vk-buffer)
  (dst-offset vk-device-size)
  (stride vk-device-size)
  (flags vk-query-result-flags))

(defcfun ("vkCmdPushConstants" vkCmdPushConstants) :void
  (command-buffer vk-command-buffer)
  (layout vk-pipeline-layout)
  (stage-flags vk-shader-stage-flags)
  (offset :uint32)
  (size :uint32)
  (values (:pointer :void)))

(defcfun ("vkCmdBeginRenderPass" vkCmdBeginRenderPass) :void
  (command-buffer vk-command-buffer)
  (begin-info (:pointer (:struct vk-render-pass-begin-info)))
  (constents VkSubpassContents))

(defcfun ("vkCmdNextSubpass" cmd-next-subpass) :void
  (command-buffer vk-command-buffer)
  (constents VkSubpassContents))

(defcfun ("vkCmdEndRenderPass" cmd-end-render-pass) :void
  (command-buffer vk-command-buffer))

(defcfun ("vkCmdExecuteCommands" vkCmdExecuteCommands) :void
  (command-buffer vk-command-buffer)
  (count :uint32)
  (command-buffers (:pointer vk-command-buffer)))

(defcfun ("vkCmdExecuteGeneratedCommandsNV" vkCmdExecuteGeneratedCommandsNV) :void
  (command-buffer vk-command-buffer)
  (perprocessed vk-bool-32)
  (info (:pointer (:struct vk-generated-commands-info-nv))))

(defcfun ("vkCmdPreprocessGeneratedCommandsNV" vkCmdPreprocessGeneratedCommandsNV) :void
  (command-buffer vk-command-buffer)
  (info (:pointer (:struct vk-generated-commands-info-nv))))

(defcfun ("vkCmdBindPipelineShaderGroupNV" cmd-bind-pipeline-shader-group-nv) :void
  (commabd-buffer vk-command-buffer)
  (pipeline-bind-point VkPipelineBindPoint)
  (pipeline vk-pipeline)
  (index :uint32))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;normal function area;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defcfun ("vkQueueWaitIdle" queue-wait-idle) VkResult
  (queue vk-queue))

(defcfun ("vkDeviceWaitIdle" device-wait-idle) VkResult
  (device vk-device))

(defcfun ("vkDebugReportMessageEXT" debug-report-message-ext) :void
  (instance vk-instance)
  (flags vk-debug-report-flags-ext)
  (object-type VkDebugReportObjectTypeEXT)
  (object :uint64)
  (location :unsigned-int)
  (message-code :int32)
  (layer-prefix :string)
  (message :string))

(defcfun ("vkDebugMarkerSetObjectNameEXT" vkDebugMarkerSetObjectNameEXT) VKResult
  (device vk-device)
  (info (:pointer (:struct vk-debug-marker-object-name-info-ext))))

(defcfun ("vkDebugMarkerSetObjectTagEXT" vkDebugMarkerSetObjectTagEXT) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-debug-marker-object-tag-info-ext))))

(defcfun ("vkCmdDebugMarkerBeginEXT" vkCmdDebugMarkerBeginEXT) :void
  (command-buffers vk-command-buffer)
  (info (:pointer (:struct vk-debug-marker-marker-info-ext))))

(defcfun ("vkCmdDebugMarkerEndEXT" cmd-debug-marker-end-ext) :void
  (command-buffer vk-command-buffer))

(defcfun ("vkCmdDebugMarkerInsertEXT" vkCmdDebugMarkerInsertEXT) :void
  (command-buffer vk-command-buffer)
  (info (:pointer (:struct vk-debug-marker-marker-info-ext))))

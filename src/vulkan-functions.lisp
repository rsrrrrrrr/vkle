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
	  cmd-bind-pipeline-shader-group-nv
	  destroy-indirect-commands-layout-nv
	  release-display-ext
	  cmd-set-device-mask
	  cmd-dispatch-base
	  destroy-descriptor-update-template
	  get-swapchain-status-khr
	  set-locak-dimming-amd
	  queue-end-debug-utils-label-ext
	  cmd-end-debug-utils-label-ext
	  destroy-debuf-utils-messenger-ext
	  cmd-write-buffer-marker-amd
	  cmd-draw-indirect-count
	  cmd-draw-indexed-indirect-count
	  cmd-begin-query-indexed-ext
	  cmd-end-query-indexed-ext
	  cmd-draw-indirect-byte-count-ext
	  cmd-bind-shading-rate-image-nv
	  cmd-draw-mesh-tasks-nv
	  cmd-draw-mesh-tasks-indirect-nv
	  cmd-draw-mesh-tasks-indirect-count-nv
	  compiler-deferred-nv
	  cmd-copy-acceleration-structure-nv
	  cmd-trace-rays-nv
	  cmd-set-line-stipple-ext
	  get-deferred-operation-max-concurrency-khr
	  get-deferred-operation-result-khr
	  destroy-deferred-operation-khr
	  acquire-full-screen-exclusive-mode-ext
	  release-full-screen-exclusive-mode-ext
	  release-profiling-lock-khr
	  relesae-performance-configration-intel
	  uninitialize-performance-api-intel
	  deferred-operation-join-khr
	  set-private-data-ext))

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

(defcfun ("vkCreateIndirectCommandsLayoutNV" vkCreateIndirectCommandsLayoutNV) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-indirect-commands-layout-create-info-nv)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (layout (:pointer vk-indirect-commands-layout-nv)))

(defcfun ("vkDestroyIndirectCommandsLayoutNV" destroy-indirect-commands-layout-nv) :void
  (device vk-device)
  (layout vk-indirect-commands-layout-nv)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkRegisterDeviceEventEXT" vkRegisterDeviceEventEXT) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-device-event-info-ext)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (fence (:pointer vk-fence)))

(defcfun ("vkRegisterDisplayEventEXT" vkRegisterDisplayEventEXT) VkResult
  (device vk-device)
  (display vk-display-khr)
  (info (:pointer (:struct vk-display-event-info-ext)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (fence (:pointer vk-fence)))

(defcfun ("vkCreateDescriptorUpdateTemplate" vkCreateDescriptorUpdateTemplate) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-descriptor-update-template-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (template (:pointer vk-descriptor-update-template)))

(defcfun ("vkDestroyDescriptorUpdateTemplate" destroy-descriptor-update-template) :void
  (device vk-device)
  (template vk-descriptor-update-template)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreateSamplerYcbcrConversion" vkCreateSamplerYcbcrConversion) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-sampler-ycbcr-conversion-create-info)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (ycbcr-coversion (:pointer vk-sampler-ycbcr-conversion)))

(defcfun ("vkDestroySamplerYcbcrConversion" destroy-sampler-ycbcr-conversion) :void
  (device vk-device)
  (ycbcr-coversion vk-sampler-ycbcr-conversion)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreateValidationCacheEXT" vkCreateValidationCacheEXT) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-validation-cache-create-info-ext)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (validation-cache (:pointer vk-validation-cache-ext)))

(defcfun ("vkDestroyValidationCacheEXT" destroy-validation-cache-ext) :void
  (device vk-device)
  (validation-cache vk-validation-cache-ext)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreateDebugUtilsMessengerEXT" vkCreateDebugUtilsMessengerEXT) VKResult
  (instance vk-instance)
  (info (:pointer (:struct vk-debug-utils-messenger-create-info-ext)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (message (:pointer vk-debug-utils-messenger-ext)))

(defcfun ("vkDestroyDebugUtilsMessengerEXT" destroy-debuf-utils-messenger-ext) :void
  (instance vk-instance)
  (messenger vk-debug-utils-messenger-ext)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreateRenderPass2" vkCreateRenderPass2) VkResult
  (device vk-device)
  (infp (:pointer (:struct vk-render-pass-create-info2)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (render-pass (:pointer vk-render-pass)))

(defcfun ("vkCreateAccelerationStructureNV" vkCreateAccelerationStructureNV) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-acceleration-structure-info-nv)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (acceleration-structure (:pointer vk-acceleration-structure-khr)))

(defcfun ("vkDestroyAccelerationStructureKHR" destroy-acceleration-structure-khr) VkResult
  (device vk-device)
  (acceleration-structure vk-acceleration-structure-khr)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreateRayTracingPipelinesNV" vkCreateRayTracingPipelinesNV) VkResult
  (device vk-device)
  (pipeline-cache vk-pipeline-cache)
  (count :uint32)
  (infos (:pointer (:struct vk-ray-tracing-pipeline-create-info-nv)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (pipeline (:pointer vk-pipeline)))

(defcfun ("vkCreateRayTracingPipelinesKHR" vkCreateRayTracingPipelinesKHR) VkResult
  (device vk-device)
  (pipeline-cache vk-pipeline-cache)
  (count :uint32)
  (infos (:pointer (:struct vk-ray-tracing-pipeline-create-info-khr)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (pipeline (:pointer vk-pipeline)))

(defcfun ("vkCreateAccelerationStructureKHR" vkCreateAccelerationStructureKHR) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-acceleration-structure-create-info-khr)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (acceleration-structure (:pointer vk-acceleration-structure-khr)))

(defcfun ("vkCreateDeferredOperationKHR" vkCreateDeferredOperationKHR) VkResult
  (device vk-device)
  (allocator (:pointer (:struct vk-allocation-callback)))
  (operations (:pointer vk-deferred-operation-khr)))

(defcfun ("vkDestroyDeferredOperationKHR" destroy-deferred-operation-khr) :void
  (device vk-device)
  (operation vk-deferred-operation-khr)
  (allocator (:pointer (:struct vk-allocation-callback))))

(defcfun ("vkCreatePrivateDataSlotEXT" vkCreatePrivateDataSlotEXT) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-private-data-slot-create-info-ext)))
  (allocator (:pointer (:struct vk-allocation-callback)))
  (private-data (:pointer vk-private-date-slot-ext)))

(defcfun ("vkDestroyPrivateDataSlotEXT" destroy-private-data-slot-ext) :void
  (device vk-device)
  (data vk-private-date-slot-ext)
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
  (handle (:pointer (:pointer :void))))

(defcfun ("vkGetGeneratedCommandsMemoryRequirementsNV" vkGetGeneratedCommandsMemoryRequirementsNV) :void
  (device vk-device)
  (info (:pointer (:struct vk-generated-commands-memory-requirements-info-nv)))
  (memory-requirements (:pointer (:struct vk-memory-requirements2))))

(defcfun ("vkGetPhysicalDeviceFeatures2" vkGetPhysicalDeviceFeatures2) :void
  (physical-device vk-physical-device)
  (features (:pointer (:struct vk-physical-device-features2))))

(defcfun ("vkGetPhysicalDeviceProperties2" vkGetPhysicalDeviceProperties2) :void
  (physical-device vk-physical-device)
  (properties (:pointer (:struct vk-physical-device-properties2))))

(defcfun ("vkGetPhysicalDeviceFormatProperties2" vkGetPhysicalDeviceFormatProperties2) :void
  (physical-device vk-physical-device)
  (format VkFormat)
  (properties (:pointer (:struct vk-format-properties2))))

(defcfun ("vkGetPhysicalDeviceImageFormatProperties2" vkGetPhysicalDeviceImageFormatProperties2) VKResult
  (physical-device vk-physical-device)
  (info (:pointer (:struct vk-physical-device-image-format-info2)))
  (properties (:pointer (:struct vk-image-format-properties2))))

(defcfun ("vkGetPhysicalDeviceQueueFamilyProperties2" vkGetPhysicalDeviceQueueFamilyProperties2) :void
  (physical-device vk-physical-device)
  (count (:pointer :uint32))
  (properties (:pointer (:struct vk-queue-family-properties2))))

(defcfun ("vkGetPhysicalDeviceMemoryProperties2" vkGetPhysicalDeviceMemoryProperties2) :void
  (physical-device vk-physical-device)
  (properties (:pointer (:struct vk-physical-device-memory-properties2))))

(defcfun ("vkGetPhysicalDeviceSparseImageFormatProperties2" vkGetPhysicalDeviceSparseImageFormatProperties2) :void
  (physical-device vk-physical-device)
  (info (:pointer (:struct vk-physical-device-sparse-image-format-info2)))
  (count :uint32)
  (properties (:pointer (:struct vk-sparse-image-format-properties2))))

(defcfun ("vkGetPhysicalDeviceExternalBufferProperties" vkGetPhysicalDeviceExternalBufferProperties) :void
  (physical-device vk-physical-device)
  (info (:pointer (:struct vk-physical-device-external-buffer-info)))
  (properties (:pointer (:struct vk-external-buffer-properties))))

(defcfun ("vkGetMemoryWin32HandleKHR" vkGetMemoryWin32HandleKHR) VkResult
  (device vk-device)
  (handle-info (:pointer (:struct vk-memory-get-win32-handle-info-khr)))
  (handle (:pointer (:pointer :void))))

(defcfun ("vkGetMemoryWin32HandlePropertiesKHR" vkGetMemoryWin32HandlePropertiesKHR) VkResult
  (device vk-device)
  (handle-type VkExternalMemoryHandleTypeFlagBits)
  (handle (:pointer :void))
  (properties (:pointer (:struct vk-memory-win32-handle-properties-khr))))

(defcfun ("vkGetMemoryFdKHR" vkGetMemoryFdKHR) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-memory-get-fd-info-khr)))
  (fd (:pointer :int)))

(defcfun ("vkGetMemoryFdPropertiesKHR" vkGetMemoryFdPropertiesKHR) VkResult
  (device vk-device)
  (handle-type VkExternalMemoryHandleTypeFlagBits)
  (fd :int)
  (properties (:pointer (:struct vk-memory-fd-properties-khr))))

(defcfun ("vkGetPhysicalDeviceExternalSemaphoreProperties" vkGetPhysicalDeviceExternalSemaphoreProperties) :void
  (physical-device vk-physical-device)
  (info (:pointer (:struct vk-physical-device-external-semaphore-info)))
  (properties (:pointer (:struct vk-external-semaphore-properties))))

(defcfun ("vkGetSemaphoreWin32HandleKHR" vkGetSemaphoreWin32HandleKHR) VkResult
  (device vk-device)
  (handle-info (:pointer (:struct vk-semaphore-get-win32-handle-info-khr)))
  (handle (:pointer (:pointer :void))))

(defcfun ("vkImportSemaphoreWin32HandleKHR" vkImportSemaphoreWin32HandleKHR) VkResult
  (device vk-device)
  (handle-info (:pointer (:struct vk-import-semaphore-win32-handle-info-khr))))

(defcfun ("vkGetSemaphoreFdKHR" vkGetSemaphoreFdKHR) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-semaphore-get-fd-info-khr)))
  (fd (:pointer :int)))

(defcfun ("vkGetPhysicalDeviceExternalFenceProperties" vkGetPhysicalDeviceExternalFenceProperties) :void
  (physical-device vk-physical-device)
  (info (:pointer (:struct vk-physical-device-external-fence-info)))
  (properties (:pointer (:struct vk-external-fence-properties))))

(defcfun ("vkGetFenceWin32HandleKHR" vkGetFenceWin32HandleKHR) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-fence-get-win32-handle-info-khr)))
  (handle (:pointer (:pointer :void))))

(defcfun ("vkGetFenceFdKHR" vkGetFenceFdKHR) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-fence-get-info-khr)))
  (fd (:pointer :int)))
#|
(defcfun ("vkGetRandROutputDisplayEXT" vkGetRandROutputDisplayEXT) VkResult
  (physical-device vk-physical-device)
  (dpy (:pointer display))
  (rroutput rroutput)
  (display vk-display-khr))
|#
(defcfun ("vkGetSwapchainCounterEXT" vkGetSwapchainCounterEXT) VkResult
  (device vk-device)
  (swapchain vk-swapchain-khr)
  (countr VkSurfaceCounterFlagBitsEXT)
  (counter-value (:pointer :uint64)))

(defcfun ("vkGetPhysicalDeviceSurfaceCapabilities2EXT" vkGetPhysicalDeviceSurfaceCapabilities2EXT) VkResult
  (physical-device vk-physical-device)
  (surface vk-surface-khr)
  (capabilities (:pointer (:struct vk-surface-capabilities2-ext))))

(defcfun ("vkEnumeratePhysicalDeviceGroups" vkEnumeratePhysicalDeviceGroups) VkResult
  (instance vk-instance)
  (count :uint32)
  (properties (:pointer (:struct vk-physical-device-group-properties))))

(defcfun ("vkGetDeviceGroupPeerMemoryFeatures" vkGetDeviceGroupPeerMemoryFeatures) :void
  (device vk-device)
  (heap-index :uint32)
  (local-device-index :uint32)
  (remote-device-index :uint32)
  (features (:pointer vk-peer-memory-feature-flags)))

(defcfun ("vkGetDeviceGroupPresentCapabilitiesKHR" vkGetDeviceGroupPresentCapabilitiesKHR) VkResult
  (device vk-device)
  (capabilities (:pointer (:struct vk-device-group-present-capabilities-khr))))

(defcfun ("vkGetDeviceGroupSurfacePresentModesKHR" vkGetDeviceGroupSurfacePresentModesKHR) VkResult
  (device vk-device)
  (surface vk-surface-khr)
  (modes (:pointer vk-device-group-present-mode-flags-khr)))

(defcfun ("vkGetPhysicalDevicePresentRectanglesKHR" vkGetPhysicalDevicePresentRectanglesKHR) VkResult
  (physical-device vk-physical-device)
  (surface vk-surface-khr)
  (count (:pointer :uint32))
  (rects (:pointer (:struct vk-rect-2d))))

(defcfun ("vkGetSwapchainStatusKHR" get-swapchain-status-khr) VkResult
  (device vk-device)
  (swapchain vk-swapchain-khr))

(defcfun ("vkGetRefreshCycleDurationGOOGLE" vkGetRefreshCycleDurationGOOGLE) VkResult
  (device vk-device)
  (swapchain vk-swapchain-khr)
  (properties (:pointer (:struct vk-refresh-cycle-duration-google))))

(defcfun ("vkGetPastPresentationTimingGOOGLE" vkGetPastPresentationTimingGOOGLE) VkResult
  (device vk-device)
  (swapchain vk-swapchain-khr)
  (count :uint32)
  (timings (:pointer (:struct vk-past-presentation-timing-google))))

(defcfun ("vkGetPhysicalDeviceMultisamplePropertiesEXT" vkGetPhysicalDeviceMultisamplePropertiesEXT) :void
  (physical-device vk-physical-device)
  (samples VkSampleCountFlagBits)
  (properties (:pointer (:struct vk-multisample-properties-ext))))

(defcfun ("vkGetPhysicalDeviceSurfaceCapabilities2KHR" vkGetPhysicalDeviceSurfaceCapabilities2KHR) VkResult
  (physical-device vk-physical-device)
  (surface-info (:pointer (:struct vk-physical-device-surface-info2-khr)))
  (capabilities (:pointer (:struct vk-surface-capabilities2-khr))))

(defcfun ("vkGetPhysicalDeviceSurfaceFormats2KHR" vkGetPhysicalDeviceSurfaceFormats2KHR) VKResult
  (physical-device vk-physical-device)
  (surface-info (:pointer (:struct vk-physical-device-surface-info2-khr)))
  (count (:pointer :uint32))
  (surface-format (:pointer (:struct vk-surface-format2-khr))))

(defcfun ("vkGetPhysicalDeviceDisplayProperties2KHR" vkGetPhysicalDeviceDisplayProperties2KHR) VkResult
  (physical-device vk-physical-device)
  (count :uint32)
  (properties (:pointer (:struct vk-display-properties2-khr))))

(defcfun ("vkGetPhysicalDeviceDisplayPlaneProperties2KHR" vkGetPhysicalDeviceDisplayPlaneProperties2KHR) VKResult
  (physical-device vk-physical-device)
  (count :uint32)
  (properties (:pointer (:struct vk-display-plane-properties2-khr))))

(defcfun ("vkGetDisplayModeProperties2KHR" vkGetDisplayModeProperties2KHR) VkResult
  (physical-device vk-physical-device)
  (display vk-display-khr)
  (count (:pointer :uint32))
  (properties (:pointer (:struct vk-display-mode-properties2-khr))))

(defcfun ("vkGetDisplayPlaneCapabilities2KHR" vkGetDisplayPlaneCapabilities2KHR) VkResult
  (physical-device vk-physical-device)
  (info (:pointer (:struct vk-display-plane-info2-khr)))
  (capabilities (:pointer (:struct vk-display-plane-capabilities2-khr))))

(defcfun ("vkGetBufferMemoryRequirements2" vkGetBufferMemoryRequirements2) :void
  (device vk-device)
  (info (:pointer (:struct vk-buffer-memory-requirements-info2)))
  (requirements (:pointer (:struct vk-memory-requirements2))))

(defcfun ("vkGetImageMemoryRequirements2" vkGetImageMemoryRequirements2) :void
  (device vk-device)
  (info (:pointer (:struct vk-image-memory-requirements-info2)))
  (requirements (:pointer (:struct vk-memory-requirements2))))

(defcfun ("vkGetImageSparseMemoryRequirements2" vkGetImageSparseMemoryRequirements2) :void
  (device vk-device)
  (info (:pointer (:struct vk-image-sparse-memory-requirements-info2)))
  (count :uint32)
  (requirements (:pointer (:struct vk-sparse-image-memory-requirements2))))

(defcfun ("vkGetDeviceQueue" vkGetDeviceQueue) :void
  (device vk-device)
  (family-index :uint32)
  (index :uint32)
  (queue (:pointer vk-queue)))

(defcfun ("vkGetDeviceQueue2" vkGetDeviceQueue2) :void
  (device vk-device)
  (info (:pointer (:struct vk-device-queue-info2)))
  (queue (:pointer vk-queue)))

(defcfun ("vkGetValidationCacheDataEXT" vkGetValidationCacheDataEXT) VkResult
  (device vk-device)
  (cache vk-validation-cache-ext)
  (data-size (:pointer :unsigned-int))
  (data (:pointer :void)))

(defcfun ("vkGetDescriptorSetLayoutSupport" vkGetDescriptorSetLayoutSupport) :void
  (device vk-device)
  (info (:pointer (:struct vk-descriptor-set-layout-create-info)))
  (support-p (:pointer (:struct vk-descriptor-set-layout-support))))

(defcfun ("vkGetShaderInfoAMD" vkGetShaderInfoAMD) VkResult
  (device vk-device)
  (pipeline vk-pipeline)
  (shader-stage VkShaderStageFlagBits)
  (info-type VkShaderInfoTypeAMD)
  (size (:pointer :unsigned-int))
  (info (:pointer :void)))

(defcfun ("vkGetPhysicalDeviceCalibrateableTimeDomainsEXT" vkGetPhysicalDeviceCalibrateableTimeDomainsEXT) VkResult
  (physical-device vk-physical-device)
  (count :uint32)
  (domains (:pointer VkTimeDomainEXT)))

(defcfun ("vkGetCalibratedTimestampsEXT" vkGetCalibratedTimestampsEXT) VkResult
  (device vk-device)
  (count :uint32)
  (info (:pointer (:struct vk-calibrated-timestamp-info-ext)))
  (timestamps (:pointer :uint64))
  (max-deviation (:pointer :uint64)))

(defcfun ("vkGetMemoryHostPointerPropertiesEXT" vkGetMemoryHostPointerPropertiesEXT) VkResult
  (device vk-device)
  (handle-type VkExternalMemoryHandleTypeFlagBits)
  (host-pointer (:pointer :void))
  (properties (:pointer (:struct vk-memory-host-pointer-properties-ext))))

(defcfun ("vkGetSemaphoreCounterValue" vkGetSemaphoreCounterValue) VkResult
  (device vk-device)
  (semaphore vk-semaphore)
  (value (:pointer :uint64)))

(defcfun ("vkGetQueueCheckpointDataNV" vkGetQueueCheckpointDataNV) :void
  (queue vk-queue)
  (count (:pointer :uint32))
  (data (:pointer (:struct vk-checkpoint-data-nv))))

(defcfun ("vkGetAccelerationStructureMemoryRequirementsKHR" vkGetAccelerationStructureMemoryRequirementsKHR) :void
  (device vk-device)
  (info (:pointer (:struct vk-acceleration-structure-memory-requirements-info-nv)))
  (memory-requirements (:pointer (:struct vk-memory-requirements2))))

(defcfun ("vkGetAccelerationStructureMemoryRequirementsNV" vkGetAccelerationStructureMemoryRequirementsNV) :void
  (device vk-device)
  (info (:pointer (:struct vk-acceleration-structure-memory-requirements-info-nv)))
  (memory-requirements (:pointer (:struct vk-memory-requirements2))))

(defcfun ("vkGetRayTracingShaderGroupHandlesKHR" vkGetRayTracingShaderGroupHandlesKHR) VkResult
  (device vk-device)
  (pipeline vk-pipeline)
  (first-group :uint32)
  (count :uint32)
  (size :unsigned-int)
  (data (:pointer :void)))

(defcfun ("vkGetRayTracingCaptureReplayShaderGroupHandlesKHR" vkGetRayTracingCaptureReplayShaderGroupHandlesKHR) VkResult
  (device vk-device)
  (pipeline vk-pipeline)
  (first-group :uint32)
  (count :uint32)
  (size :unsigned-int)
  (data (:pointer :void)))

(defcfun ("vkGetAccelerationStructureHandleNV" vkGetAccelerationStructureHandleNV) VkResult
  (device vk-device)
  (acceleration-structure vk-acceleration-structure-khr)
  (size :unsigned-int)
  (data  (:pointer :void)))

(defcfun ("vkGetPhysicalDeviceCooperativeMatrixPropertiesNV" vkGetPhysicalDeviceCooperativeMatrixPropertiesNV) VkResult
  (physical-device vk-physical-device)
  (count :uint32)
  (properties (:pointer (:struct vk-cooperative-matrix-properties-nv))))

(defcfun ("vkGetDeviceAccelerationStructureCompatibilityKHR" vkGetDeviceAccelerationStructureCompatibilityKHR) VkResult
  (device vk-device)
  (version (:pointer (:struct vk-acceleration-structure-version-khr))))

(defcfun ("vkGetImageViewHandleNVX" vkGetImageViewHandleNVX) :uint32
  (device vk-device)
  (info (:pointer (:struct vk-image-view-handle-info-nvx))))

(defcfun ("vkGetImageViewAddressNVX" vkGetImageViewAddressNVX) VkResult
  (device vk-device)
  (image-view vk-image-view)
  (properties (:pointer (:struct vk-image-view-address-properties-nvx))))

(defcfun ("vkGetPhysicalDeviceSurfacePresentModes2EXT" vkGetPhysicalDeviceSurfacePresentModes2EXT) VkResult
  (physical-device vk-physical-device)
  (surface-info (:pointer (:struct vk-physical-device-surface-info2-khr)))
  (count :uint32)
  (modes (:pointer VkPresentModeKHR)))

(defcfun ("vkGetDeviceGroupSurfacePresentModes2EXT" vkGetDeviceGroupSurfacePresentModes2EXT) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-physical-device-surface-info2-khr)))
  (modes (:pointer vk-device-group-present-mode-flags-khr)))

(defcfun ("vkGetPhysicalDeviceQueueFamilyPerformanceQueryPassesKHR" vkGetPhysicalDeviceQueueFamilyPerformanceQueryPassesKHR) :void
  (physical-device vk-physical-device)
  (info (:pointer (:struct vk-query-pool-performance-create-info-khr)))
  (nyn-pass (:pointer :uint32)))

(defcfun ("vkGetImageDrmFormatModifierPropertiesEXT" vkGetImageDrmFormatModifierPropertiesEXT) VkResult
  (device vk-device)
  (image vk-image)
  (properties (:pointer (:struct vk-image-drm-format-modifier-properties-ext))))

(defcfun ("vkGetBufferOpaqueCaptureAddress" vkGetBufferOpaqueCaptureAddress) :uint64
  (device vk-device)
  (info (:pointer (:struct vk-buffer-device-address-info))))

(defcfun ("vkGetBufferDeviceAddress" vkGetBufferDeviceAddress) vk-device-address
  (device vk-device)
  (info (:pointer (:struct vk-buffer-device-address-info))))

(defcfun ("vkGetPhysicalDeviceSupportedFramebufferMixedSamplesCombinationsNV" vkGetPhysicalDeviceSupportedFramebufferMixedSamplesCombinationsNV) VkResult
  (physical-device vk-physical-device)
  (count (:pointer :uint32))
  (combinations (:pointer (:struct vk-framebuffer-mixed-samples-combination-nv))))

(defcfun ("vkGetPerformanceParameterINTEL" vkGetPerformanceParameterINTEL) VkResult
  (device vk-device)
  (parameter VkPerformanceParameterTypeINTEL)
  (value (:pointer (:struct vk-performance-value-intel))))

(defcfun ("vkGetDeviceMemoryOpaqueCaptureAddress" vkGetDeviceMemoryOpaqueCaptureAddress) :uint64
  (device vk-device)
  (info (:pointer (:struct vk-device-memory-opaque-capture-address-info))))

(defcfun ("vkGetPipelineExecutablePropertiesKHR" vkGetPipelineExecutablePropertiesKHR) VkResult
  (device vk-device)
  (pipeline-info (:pointer (:struct vk-pipeline-info-khr)))
  (count (:pointer :uint32))
  (properties (:pointer (:struct vk-pipeline-executable-properties-khr))))

(defcfun ("vkGetPipelineExecutableStatisticsKHR" vkGetPipelineExecutableStatisticsKHR) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-pipeline-executable-info-khr)))
  (count :uint32)
  (statstics (:pointer (:struct vk-pipeline-executable-statistic-khr))))

(defcfun ("vkGetPipelineExecutableInternalRepresentationsKHR" vkGetPipelineExecutableInternalRepresentationsKHR) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-pipeline-executable-info-khr)))
  (count :uint32)
  (representations (:pointer (:struct vk-pipeline-executable-internal-representation-khr))))

(defcfun ("vkGetPhysicalDeviceToolPropertiesEXT" vkGetPhysicalDeviceToolPropertiesEXT) VkResult
  (physical-device vk-physical-device)
  (count (:pointer :uint32))
  (properties (:pointer (:struct vk-physical-device-tool-properties-ext))))

(defcfun ("vkGetAccelerationStructureDeviceAddressKHR" vkGetAccelerationStructureDeviceAddressKHR) vk-device-address
  (device vk-device)
  (info (:pointer (:struct vk-acceleration-structure-device-address-info-khr))))

(defcfun ("vkGetDeferredOperationMaxConcurrencyKHR" get-deferred-operation-max-concurrency-khr) :uint32
  (device vk-device)
  (operation vk-deferred-operation-khr))

(defcfun ("vkGetDeferredOperationResultKHR" get-deferred-operation-result-khr) VkResult
  (device vk-device)
  (operation vk-deferred-operation-khr))

(defcfun ("vkGetPrivateDataEXT" vkGetPrivateDataEXT) :void
  (device vk-device)
  (type VkObjectType)
  (handle :uint64)
  (data-slot vk-private-date-slot-ext)
  (data (:pointer :uint64)))

(defcfun ("vkEnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHR" vkEnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHR) VKResult
  (physical-device vk-physical-device)
  (queue-family-index :uint32)
  (count (:pointer :uint32))
  (counters (:pointer (:struct vk-performance-counter-khr)))
  (descriptor (:pointer (:struct vk-performance-counter-description-khr))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;queue operation function area;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

(defcfun ("vkQueueSetPerformanceConfigurationINTEL" queue-set-performance-configuration-intel) VkResult
  (queue vk-queue)
  (configureation vk-performance-configuration-intel))
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

(defcfun ("vkCmdPushDescriptorSetKHR" vkCmdPushDescriptorSetKHR) :void
  (command-buffer vk-command-buffer)
  (pipeline-bind-point VkPipelineBindPoint)
  (layout vk-pipeline-layout)
  (set :uint32)
  (write-count :uint32)
  (writes (:pointer (:struct vk-write-descriptor-set))))

(defcfun ("vkCmdSetDeviceMask" cmd-set-device-mask) :void
  (command-buffer vk-command-buffer)
  (device-mask :uint32))

(defcfun ("vkCmdDispatchBase" cmd-dispatch-base) :void
  (command-buffer vk-command-buffer)
  (base-x :uint32)
  (base-y :uint32)
  (base-z :uint32)
  (count-x :uint32)
  (count-y :uint32)
  (count-z :uint32))

(defcfun ("vkCmdPushDescriptorSetWithTemplateKHR" vkCmdPushDescriptorSetWithTemplateKHR) :void
  (commabd-buffer vk-command-buffer)
  (template vk-descriptor-update-template)
  (layout vk-pipeline-layout)
  (set :uint32)
  (data (:pointer :void)))

(defcfun ("vkCmdSetViewportWScalingNV" vkCmdSetViewportWScalingNV) :void
  (command-buffers vk-command-buffer)
  (first-viewport :uint32)
  (count :uint32)
  (viewport-scalings (:pointer (:struct vk-viewport-w-scaling-nv))))

(defcfun ("vkCmdSetDiscardRectangleEXT" vkCmdSetDiscardRectangleEXT) :void
  (command-buffer vk-command-buffer)
  (first-discard-rectangle :uint32)
  (discard-rectangle-count :uint32)
  (discard-rectangle (:pointer (:struct vk-rect-2d))))

(defcfun ("vkCmdSetSampleLocationsEXT" vkCmdSetSampleLocationsEXT) :void
  (command-buffer vk-command-buffer)
  (info (:pointer (:struct vk-sample-locations-info-ext))))

(defcfun ("vkCmdWriteBufferMarkerAMD" cmd-write-buffer-marker-amd) :void
  (command-buffer vk-command-buffer)
  (stage VkPipelineStageFlagBits)
  (buffer vk-buffer)
  (dst-offset vk-device-size)
  (marker :uint32))

(defcfun ("vkCmdBeginRenderPass2" vkCmdBeginRenderPass2) :void
  (command-buffer vk-command-buffer)
  (begin-info (:pointer (:struct vk-render-pass-begin-info)))
  (subpass-begin-info (:pointer (:struct vk-subpass-begin-info))))

(defcfun ("vkCmdNextSubpass2" vkCmdNextSubpass2) :void
  (command-buffer vk-command-buffer)
  (begin-info (:pointer (:struct vk-subpass-begin-info)))
  (end-info (:pointer (:struct vk-subpass-end-info))))

(defcfun ("vkCmdEndRenderPass2" vkCmdEndRenderPass2) :void
  (command-buffer vk-command-buffer)
  (end-info (:pointer (:struct vk-subpass-end-info))))

(defcfun ("vkCmdDrawIndirectCount" cmd-draw-indirect-count) :void
  (command-buffer vk-command-buffer)
  (buffer vk-buffer)
  (offset vk-device-size)
  (count-buffer vk-buffer)
  (count-buffer-offset vk-device-size)
  (max-draw-count :uint32)
  (stride :uint32))

(defcfun ("vkCmdDrawIndexedIndirectCount" cmd-draw-indexed-indirect-count) :void
  (command-buffer vk-command-buffer)
  (buffer vk-buffer)
  (offset vk-device-size)
  (count-buffer vk-buffer)
  (count-buffer-offset vk-device-size)
  (max-draw-count :uint32)
  (stride :uint32))

(defcfun ("vkCmdSetCheckpointNV" vkCmdSetCheckpointNV) :void
  (command-buffer vk-command-buffer)
  (check-pointer-marker (:pointer :void)))

(defcfun ("vkCmdBindTransformFeedbackBuffersEXT" vkCmdBindTransformFeedbackBuffersEXT) :void
  (command-buffer vk-command-buffer)
  (first-binding :uint32)
  (count :uint32)
  (buffers (:pointer vk-buffer))
  (offsets (:pointer vk-device-size))
  (sizes (:pointer vk-device-size)))

(defcfun ("vkCmdBeginTransformFeedbackEXT" vkCmdBeginTransformFeedbackEXT) :void
  (command-buffer vk-command-buffer)
  (firset-counter-buffer :uint32)
  (counter-buffer-count :uint32)
  (buffers (:pointer vk-buffer))
  (offset (:pointer vk-device-size)))

(defcfun ("vkCmdEndTransformFeedbackEXT" vkCmdEndTransformFeedbackEXT) :void
  (command-buffer vk-command-buffer)
  (firset-counter-buffer :uint32)
  (counter-buffer-count :uint32)
  (buffers (:pointer vk-buffer))
  (offset (:pointer vk-device-size)))

(defcfun ("vkCmdBeginQueryIndexedEXT" cmd-begin-query-indexed-ext) :void
  (command-buffer vk-command-buffer)
  (pool vk-query-pool)
  (query :uint32)
  (flags vk-query-control-flags)
  (index :uint32))

(defcfun ("vkCmdEndQueryIndexedEXT" cmd-end-query-indexed-ext) :void
  (command-buffer vk-command-buffer)
  (pool vk-query-pool)
  (query :uint32)
  (index :uint32))

(defcfun ("vkCmdDrawIndirectByteCountEXT" cmd-draw-indirect-byte-count-ext) :void
  (command-buffer vk-command-buffer)
  (instance-count :uint32)
  (first-instance :uint32)
  (count-buffer vk-buffer)
  (count-buffer-offset vk-device-size)
  (count-offset :uint32)
  (vertex-stride :uint32))

(defcfun ("vkCmdSetExclusiveScissorNV" vkCmdSetExclusiveScissorNV) :void
  (command-buffer vk-command-buffer)
  (first-scissor :uint32)
  (scissor-count :uint32)
  (scissors (:pointer (:struct vk-rect-2d))))

(defcfun ("vkCmdBindShadingRateImageNV" cmd-bind-shading-rate-image-nv) :void
  (command-buffer vk-command-buffer)
  (image-view vk-image-view)
  (layout VkImageLayout))

(defcfun ("vkCmdSetViewportShadingRatePaletteNV" vkCmdSetViewportShadingRatePaletteNV) :void
  (command-buffer vk-command-buffer)
  (first-viewport :uint32)
  (viewport-count :uint32)
  (shading-rate-palettes (:pointer (:struct vk-shading-rate-palette-nv))))

(defcfun ("vkCmdSetCoarseSampleOrderNV" vkCmdSetCoarseSampleOrderNV) :void
  (command-buffer vk-command-buffer)
  (type VkCoarseSampleOrderTypeNV)
  (count :uint32)
  (custom-sample-orders (:pointer (:struct vk-coarse-sample-order-custom-nv))))

(defcfun ("vkCmdDrawMeshTasksNV" cmd-draw-mesh-tasks-nv) :void
  (command-buffer vk-command-buffer)
  (count :uint32)
  (first-task :uint32))

(defcfun ("vkCmdDrawMeshTasksIndirectNV" cmd-draw-mesh-tasks-indirect-nv) :void
  (command-buffer vk-command-buffer)
  (buffer vk-buffer)
  (offset vk-device-size)
  (count :uint32)
  (stride :uint32))

(defcfun ("vkCmdDrawMeshTasksIndirectCountNV" cmd-draw-mesh-tasks-indirect-count-nv) :void
  (command-buffer vk-command-buffer)
  (buffer vk-command-buffer)
  (offset vk-device-size)
  (count-buffer vk-buffer)
  (count-buffer-offset vk-device-size)
  (max-draw-count :uint32)
  (stride :uint32))

(defcfun ("vkCmdCopyAccelerationStructureNV" cmd-copy-acceleration-structure-nv) :void
  (command-buffer vk-command-buffer)
  (dst vk-acceleration-structure-khr)
  (src vk-acceleration-structure-khr)
  (mode VkCopyAccelerationStructureModeKHR))

(defcfun ("vkCmdCopyAccelerationStructureKHR" vkCmdCopyAccelerationStructureKHR) :void
  (command-buffer vk-command-buffer)
  (info (:pointer (:struct vk-copy-acceleration-structure-info-khr))))

(defcfun ("vkCmdCopyAccelerationStructureToMemoryKHR" vkCmdCopyAccelerationStructureToMemoryKHR) :void
  (command-buffer vk-command-buffer)
  (info (:pointer (:struct vk-copy-acceleration-structure-info-khr))))

(defcfun ("vkCmdCopyMemoryToAccelerationStructureKHR" vkCmdCopyMemoryToAccelerationStructureKHR) :void
  (command-buffer vk-command-buffer)
  (info (:pointer (:struct vk-copy-memory-to-acceleration-structure-info-khr))))

(defcfun ("vkCmdWriteAccelerationStructuresPropertiesKHR" vkCmdWriteAccelerationStructuresPropertiesKHR) :void
  (command-buffer vk-command-buffer)
  (count :uint32)
  (acceleration-structures (:pointer vk-acceleration-structure-khr))
  (type VkQueryType)
  (pool vk-query-pool)
  (first-query :uint32))

(defcfun ("vkCmdBuildAccelerationStructureNV" vkCmdBuildAccelerationStructureNV) :void
  (command-buffer vk-command-buffer)
  (info (:pointer (:struct vk-acceleration-structure-info-nv)))
  (instance-data vk-buffer)
  (offset vk-device-size)
  (update vk-bool-32)
  (dst vk-acceleration-structure-khr)
  (src vk-acceleration-structure-khr)
  (scratch vk-buffer)
  (scratch-offset vk-device-size))

(defcfun ("vkCmdTraceRaysKHR" vkCmdTraceRaysKHR) :void
  (command-buffer vk-command-buffer)
  (raygen-shader-binding-table (:pointer (:struct vk-strided-buffer-region-khr)))
  (miss-shader-binding-table (:pointer (:struct vk-strided-buffer-region-khr)))
  (hit-shader-binding-table (:pointer (:struct vk-strided-buffer-region-khr)))
  (callable-shader-binding-table (:pointer (:struct vk-strided-buffer-region-khr)))
  (width :uint32)
  (height :uint32)
  (depth :uint32))

(defcfun ("vkCmdTraceRaysNV" cmd-trace-rays-nv) :void
  (command-buffer vk-command-buffer)
  (raygen-shader-binding-table-buffer vk-buffer)
  (raygen-shader-binding-offset vk-device-size)
  (miss-shader-binding-table-buffer vk-buffer)
  (miss-shader-binding-offset vk-device-size)
  (miss-shader-binding-stride vk-device-size)
  (hit-shader-binding-table-buffer vk-buffer)
  (hit-shader-binding-offset vk-device-size)
  (hit-shader-binding-stride vk-device-size)
  (callable-shader-binding-table-buffer vk-buffer)
  (callable-shader-binding-offset vk-device-size)
  (callable-shader-binding-stride vk-device-size)
  (width :uint32)
  (height :uint32)
  (depth :uint32))

(defcfun ("vkCmdTraceRaysIndirectKHR" vkCmdTraceRaysIndirectKHR) :void
  (command-buffer vk-command-buffer)
  (raygen-shader-binding-table (:pointer (:struct vk-strided-buffer-region-khr)))
  (miss-shader-binding-table (:pointer (:struct vk-strided-buffer-region-khr)))
  (hit-shader-binding-table (:pointer (:struct vk-strided-buffer-region-khr)))
  (callable-shader-binding-table (:pointer (:struct vk-strided-buffer-region-khr)))
  (buffer vk-buffer)
  (offset vk-device-size))

(defcfun ("vkCmdSetPerformanceMarkerINTEL" vkCmdSetPerformanceMarkerINTEL) VkResult
  (command-buffer vk-command-buffer)
  (info (:pointer (:struct vk-performance-marker-info-intel))))

(defcfun ("vkCmdSetPerformanceStreamMarkerINTEL" vkCmdSetPerformanceStreamMarkerINTEL) VkResult
  (command-buffer vk-command-buffer)
  (info (:pointer (:struct vk-performance-stream-marker-info-intel))))

(defcfun ("vkCmdSetPerformanceOverrideINTEL" vkCmdSetPerformanceOverrideINTEL) VkResult
  (command-buffer vk-command-buffer)
  (info (:pointer (:struct vk-performance-override-info-intel))))

(defcfun ("vkCmdSetLineStippleEXT" cmd-set-line-stipple-ext) :void
  (command-buffer vk-command-buffer)
  (factory :uint32)
  (pattern :uint16))

(defcfun ("vkCmdBuildAccelerationStructureKHR" vkCmdBuildAccelerationStructureKHR) :void
  (commabd-buffer vk-command-buffer)
  (count :uint32)
  (infos (:pointer (:struct vk-acceleration-structure-build-geometry-info-khr)))
  (offset-infos (:pointer (:pointer (:struct vk-acceleration-structure-build-offset-info-khr)))))

(defcfun ("vkCmdBuildAccelerationStructureIndirectKHR" vkCmdBuildAccelerationStructureIndirectKHR) :void
  (command-buffer vk-command-buffer)
  (info (:pointer (:struct vk-acceleration-structure-build-geometry-info-khr)))
  (buffer vk-buffer)
  (offset vk-device-size)
  (stride :uint32))
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

(defcfun ("vkTrimCommandPool" trim-command-pool) :void
  (device vk-device)
  (command-pool vk-command-pool)
  (flags vk-command-pool-trim-flags))

(defcfun ("vkImportSemaphoreFdKHR" vkImportSemaphoreFdKHR) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-import-semaphore-fd-info-khr))))

(defcfun ("vkImportFenceWin32HandleKHR" vkImportFenceWin32HandleKHR) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-import-fence-win32-handle-info-khr))))

(defcfun ("vkImportFenceFdKHR" vkImportFenceFdKHR) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-import-fence-fd-info-khr))))

(defcfun ("vkReleaseDisplayEXT" release-display-ext) VkResult
  (physical-device vk-physical-device)
  (display vk-display-khr))
#|
(defcfun ("vkAcquireXlibDisplayEXT" vkAcquireXlibDisplayEXT) VkResult
  (physical-device vk-physical-device)
  (dpy (:pointer display))
  (display vk-display-khr))
|#
(defcfun ("vkDisplayPowerControlEXT" vkDisplayPowerControlEXT) VkResult
  (device vk-device)
  (display vk-display-khr)
  (info (:pointer (:struct vk-display-power-info-ext))))

(defcfun ("vkBindBufferMemory2" vkBindBufferMemory2) VkResult
  (device vk-device)
  (count :uint32)
  (info (:pointer (:struct vk-bind-buffer-memory-info))))

(defcfun ("vkBindImageMemory2" vkBindImageMemory2) VkResult
  (device vk-device)
  (count :uint32)
  (info (:pointer (:struct vk-bind-image-memory-info))))

(defcfun ("vkAcquireNextImageKHR" vkAcquireNextImageKHR) VkResult
  (device vk-device)
  (swapchain vk-swapchain-khr)
  (timeout :uint64)
  (semaphore vk-semaphore)
  (fence vk-fence)
  (image-index (:pointer :uint32)))

(defcfun ("vkAcquireNextImage2KHR" vkAcquireNextImage2KHR) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-acquire-next-image-info-khr)))
  (index :uint32))

(defcfun ("vkUpdateDescriptorSetWithTemplate" vkUpdateDescriptorSetWithTemplate) :void
  (device vk-device)
  (set vk-descriptor-set)
  (template vk-descriptor-update-template)
  (data (:pointer :void)))

(defcfun ("vkSetHdrMetadataEXT" vkSetHdrMetadataEXT) :void
  (device vk-device)
  (count :uint32)
  (swapchains (:pointer vk-swapchain-khr))
  (metadata (:pointer (:struct vk-hdr-metadata-ext))))

(defcfun ("vkMergeValidationCachesEXT" vkMergeValidationCachesEXT) VkResult
  (device vk-device)
  (dst-cache vk-validation-cache-ext)
  (count :uint32)
  (src-cache (:pointer vk-validation-cache-ext)))

(defcfun ("vkSetLocalDimmingAMD" set-locak-dimming-amd) :void
  (device vk-device)
  (swapchain vk-swapchain-khr)
  (enable vk-bool-32))

(defcfun ("vkSetDebugUtilsObjectNameEXT" vkSetDebugUtilsObjectNameEXT) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-debug-utils-object-name-info-ext))))

(defcfun ("vkSetDebugUtilsObjectTagEXT" vkSetDebugUtilsObjectTagEXT) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-debug-utils-object-tag-info-ext))))

(defcfun ("vkQueueBeginDebugUtilsLabelEXT" vkQueueBeginDebugUtilsLabelEXT) :void
  (queue vk-queue)
  (info (:pointer (:struct vk-debug-utils-label-ext))))

(defcfun ("vkQueueEndDebugUtilsLabelEXT" queue-end-debug-utils-label-ext) :void
  (queue vk-queue))

(defcfun ("vkQueueInsertDebugUtilsLabelEXT" vkQueueInsertDebugUtilsLabelEXT) :void
  (queue vk-queue)
  (info (:pointer (:struct vk-debug-utils-label-ext))))

(defcfun ("vkCmdBeginDebugUtilsLabelEXT" vkCmdBeginDebugUtilsLabelEXT) :void
  (command-buffer vk-command-buffer)
  (info (:pointer (:struct vk-debug-utils-label-ext))))

(defcfun ("vkCmdEndDebugUtilsLabelEXT" cmd-end-debug-utils-label-ext) :void
  (command-buffer vk-command-buffer))

(defcfun ("vkCmdInsertDebugUtilsLabelEXT" vkCmdInsertDebugUtilsLabelEXT) :void
  (command-buffer vk-command-buffer)
  (info (:pointer (:struct vk-debug-utils-label-ext))))

(defcfun ("vkSubmitDebugUtilsMessageEXT" vkSubmitDebugUtilsMessageEXT) :void
  (instance vk-instance)
  (message-severity VkDebugUtilsMessageSeverityFlagBitsEXT)
  (message-types vk-debug-utils-message-type-flags-ext)
  (data (:pointer (:struct vk-debug-utils-messenger-callback-data-ext))))

(defcfun ("vkWaitSemaphores" vkWaitSemaphores) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-semaphore-wait-info)))
  (timeout :uint64))

(defcfun ("vkSignalSemaphore" vkSignalSemaphore) VkResult
  (device vk-device)
  (infp (:pointer (:struct vk-semaphore-signal-info))))

(defcfun ("vkCompileDeferredNV" compiler-deferred-nv) VkResult
  (device vk-device)
  (pipeline vk-pipeline)
  (shader :uint32))

(defcfun ("vkBindAccelerationStructureMemoryKHR" vkBindAccelerationStructureMemoryKHR) VkResult
  (device vk-device)
  (count :uint32)
  (info (:pointer (:struct vk-bind-acceleration-structure-memory-info-khr))))

(defcfun ("vkCopyAccelerationStructureKHR" vkCopyAccelerationStructureKHR) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-copy-acceleration-structure-info-khr))))

(defcfun ("vkCopyAccelerationStructureToMemoryKHR" vkCopyAccelerationStructureToMemoryKHR) VKResult
  (device vk-device)
  (info (:pointer (:struct vk-copy-acceleration-structure-to-memory-info-khr))))

(defcfun ("vkCopyMemoryToAccelerationStructureKHR" vkCopyMemoryToAccelerationStructureKHR) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-copy-memory-to-acceleration-structure-info-khr))))

(defcfun ("vkAcquireFullScreenExclusiveModeEXT" acquire-full-screen-exclusive-mode-ext) VkResult
  (device vk-device)
  (swapchain vk-swapchain-khr))

(defcfun ("vkAcquireProfilingLockKHR" vkAcquireProfilingLockKHR) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-acquire-profiling-lock-info-khr))))

(defcfun ("vkAcquirePerformanceConfigurationINTEL" vkAcquirePerformanceConfigurationINTEL) VkResult
  (device vk-device)
  (info (:pointer (:struct vk-performance-configuration-acquire-info-intel)))
  (configureation (:pointer vk-performance-configuration-intel)))

(defcfun ("vkReleaseFullScreenExclusiveModeEXT" release-full-screen-exclusive-mode-ext) VkResult
  (device vk-device)
  (swapchain vk-swapchain-khr))

(defcfun ("vkReleaseProfilingLockKHR" release-profiling-lock-khr) VkResult
  (device vk-device))

(defcfun ("vkReleasePerformanceConfigurationINTEL" relesae-performance-configration-intel) VKResult
  (device vk-device)
  (configureation vk-performance-configuration-intel))

(defcfun ("vkWriteAccelerationStructuresPropertiesKHR" vkWriteAccelerationStructuresPropertiesKHR) VKResult
  (device vk-device)
  (count :uint32)
  (acceleration-structures (:pointer vk-acceleration-structure-khr))
  (type VkQueryType)
  (data-size :unsigned-int)
  (data (:pointer :void))
  (string :unsigned-int))

(defcfun ("vkInitializePerformanceApiINTEL" vkInitializePerformanceApiINTEL) VKResult
  (device vk-device)
  (info (:pointer (:struct vk-initialize-performance-api-info-intel))))

(defcfun ("vkUninitializePerformanceApiINTEL" uninitialize-performance-api-intel) :void
  (device vk-device))

(defcfun ("vkBuildAccelerationStructureKHR" vkBuildAccelerationStructureKHR) VkResult
  (device vk-device)
  (count :uint32)
  (infos (:pointer (:struct vk-acceleration-structure-build-geometry-info-khr)))
  (offset-info (:pointer (:pointer (:struct vk-acceleration-structure-build-offset-info-khr)))))

(defcfun ("vkDeferredOperationJoinKHR" deferred-operation-join-khr) VkResult
  (device vk-device)
  (operation vk-deferred-operation-khr))

(defcfun ("vkSetPrivateDataEXT" set-private-data-ext) VkResult
  (device vk-device)
  (type VkObjectType)
  (handle :uint64)
  (private-data-slot vk-private-date-slot-ext)
  (data :uint64))

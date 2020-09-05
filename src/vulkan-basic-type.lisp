(in-package :vkle)

(defctype vk-bool-32 :uint32)
(defctype vk-flags :uint32)

(defctype vk-handle :pointer)
#.(if (= 8 (foreign-type-size :pointer))
    `(defctype vk-non-dispatch-handle :pointer)
    `(defctype vk-non-dispatch-handle :uint64))

(defctype vk-instance vk-handle)
(defctype vk-physical-device vk-handle)
(defctype vk-device vk-handle)
(defctype vk-queue vk-handle)
(defctype vk-command-buffer vk-handle)

(defctype vk-command-pool vk-non-dispatch-handle)
(defctype vk-fence vk-non-dispatch-handle)
(defctype vk-semaphore vk-non-dispatch-handle)
(defctype vk-event vk-non-dispatch-handle)
(defctype vk-render-pass vk-non-dispatch-handle)
(defctype vk-framebuffer vk-non-dispatch-handle)
(defctype vk-shader-module vk-non-dispatch-handle)
(defctype vk-validation-cache-ext vk-non-dispatch-handle)
(defctype vk-pipeline vk-non-dispatch-handle)
(defctype vk-pipeline-cache vk-non-dispatch-handle)
(defctype vk-device-memory vk-non-dispatch-handle)
(defctype vk-buffer vk-non-dispatch-handle)
(defctype vk-buffer-view vk-non-dispatch-handle)
(defctype vk-image vk-non-dispatch-handle)
(defctype vk-image-view vk-non-dispatch-handle)
(defctype vk-acceleration-structure-khr vk-non-dispatch-handle)
(defctype vk-sampler vk-non-dispatch-handle)
(defctype vk-sampler-ycbcr-conversion vk-non-dispatch-handle)
(defctype vk-descriptor-set-layout vk-non-dispatch-handle)
(defctype vk-pipeline-layout vk-non-dispatch-handle)
(defctype vk-descriptor-pool vk-non-dispatch-handle)
(defctype vk-descriptor-set vk-non-dispatch-handle)
(defctype vk-descriptor-update-template vk-non-dispatch-handle)
(defctype vk-query-pool vk-non-dispatch-handle)
(defctype vk-performance-configuration-intel vk-non-dispatch-handle)
(defctype vk-indirect-commands-layout-nv vk-non-dispatch-handle)
(defctype vk-surface-khr vk-non-dispatch-handle)
(defctype vk-display-khr vk-non-dispatch-handle)
(defctype vk-display-mode-khr vk-non-dispatch-handle)
(defctype vk-swapchain-khr vk-non-dispatch-handle)
(defctype vk-deferred-operation-khr vk-non-dispatch-handle)
(defctype vk-private-date-slot-ext vk-non-dispatch-handle)
(defctype vk-debug-utils-messenger-ext vk-non-dispatch-handle)
(defctype vk-debug-report-callback-ext vk-non-dispatch-handle)

(defctype vk-device-size :uint64)
(defctype vk-device-address :uint64)
(defctype vk-sample-mask :uint32)

(defctype vk-void-function :pointer)
(defctype vk-allocation-function :pointer)
(defctype vk-reallocation-function :pointer)
(defctype vk-free-function :pointer)
(defctype vk-internal-allocation-notification :pointer)
(defctype vk-internal-free-notification :pointer)
(defctype pfn-vk-debug-utils-messenger-callback-ext :pointer)
(defctype pfn-vk-debug-report-callback-ext :pointer)

(defctype vk-instance-create-flags vk-flags)
(defctype vk-device-create-flags vk-flags)
(defctype vk-device-queue-create-flags vk-flags)
(defctype vk-fence-create-flags vk-flags)
(defctype vk-command-pool-create-flags vk-flags)
(defctype vk-semaphore-create-flags vk-flags)
(defctype vk-event-create-flags vk-flags)
(defctype vk-render-pass-create-flags vk-flags)
(defctype vk-framebuffer-create-flags vk-flags)
(defctype vk-image-create-flags vk-flags)
(defctype vk-module-create-flags vk-flags)
(defctype vk-validation-cache-create-flags-ext vk-flags)
(defctype vk-pipeline-create-flags vk-flags)
(defctype vk-pipeline-shader-stage-create-flags vk-flags)
(defctype vk-pipeline-vertex-input-state-create-flags vk-flags)
(defctype vk-pipeline-input-assembly-state-create-flags vk-flags)
(defctype vk-pipeline-tessellation-state-create-flags vk-flags)
(defctype vk-pipeline-viewport-state-create-flags vk-flags)
(defctype vk-pipeline-rasterization-state-create-flags vk-flags)
(defctype vk-pipeline-multisample-state-create-flags vk-flags)
(defctype vk-pipeline-depth-stencil-state-create-flags vk-flags)
(defctype vk-pipeline-color-blend-state-create-flags vk-flags)
(defctype vk-pipeline-dynamic-state-create-flags vk-flags)
(defctype vk-pipeline-cache-create-flags vk-flags)
(defctype vk-buffer-create-flags vk-flags)
(defctype vk-buffer-view-create-flags vk-flags)
(defctype vk-image-view-create-flags vk-flags)
(defctype vk-sampler-create-flags vk-flags)
(defctype vk-descriptor-set-layout-create-flags vk-flags)
(defctype vk-pipeline-layout-create-flags vk-flags)
(defctype vk-descriptor-pool-create-flags vk-flags)
(defctype vk-descriptor-update-template-create-flags vk-flags)
(defctype vk-query-pool-create-flags vk-flags)
(defctype vk-pipeline-viewport-swizzle-state-create-flags-nv vk-flags)
(defctype vk-pipeline-rasterization-conservative-state-create-flags-ext vk-flags)
(defctype vk-pipeline-discard-rectangle-state-create-flags-ext vk-flags)
(defctype vk-pipeline-coverage-to-color-state-create-flags-nv vk-flags)
(defctype vk-pipeline-coverage-reduction-state-create-flags-nv vk-flags)
(defctype vk-display-mode-create-flags-khr vk-flags)
(defctype vk-display-surface-create-flags-khr vk-flags)
(defctype vk-headless-surface-create-flags-ext vk-flags)
(defctype vk-swapchain-create-flags vk-flags)
(defctype vk-private-data-slot-create-flags-ext vk-flags)

(defctype vk-sample-count-flags vk-flags)
(defctype vk-reslove-mode-flags vk-flags)
(defctype vk-queue-flags vk-flags)
(defctype vk-pipeline-stage-flags vk-flags)
(defctype vk-performance-counter-description-flags-khr vk-flags)
(defctype vk-device-diagnostics-config-flags-nv vk-flags)
(defctype vk-command-buffer-usage-flags vk-flags)
(defctype vk-query-control-flags vk-flags)
(defctype vk-query-pipeline-statistic-flags vk-flags)
(defctype vk-external-fence-handle-type-flags vk-flags)
(defctype vk-fence-import-flags vk-flags)
(defctype vk-external-semaphore-handle-type-flags vk-flags)
(defctype vk-semaphore-wait-flags vk-flags)
(defctype vk-semaphore-import-flags vk-flags)
(defctype vk-access-flags vk-flags)
(defctype vk-image-aspect-flags vk-flags)
(defctype vk-attachment-description-flags vk-flags)
(defctype vk-subpass-description-flags vk-flags)
(defctype vk-pipeline-stage-flags vk-flags)
(defctype vk-dependency-flags vk-flags)
(defctype vk-image-usage-flags vk-flags)
(defctype vk-cull-mode-flags vk-flags)
(defctype vk-color-component-flags vk-flags)
(defctype vk-shader-stage-flags vk-flags)
(defctype vk-shader-stage-flags vk-flags)
(defctype vk-pipeline-compiler-control-flags-amd vk-flags)
(defctype vk-pipeline-creation-feedback-flags-ext vk-flags)
(defctype vk-memory-property-flags vk-flags)
(defctype vk-memory-heap-flags vk-flags)
(defctype vk-external-memory-handle-type-flags vk-flags)
(defctype vk-external-memory-handle-type-flags-nv vk-flags)
(defctype vk-memory-allocate-flags vk-flags)
(defctype vk-buffer-usage-flags vk-flags)
(defctype vk-image-aspect-flags Vk-flags)
(defctype vk-build-acceleration-structure-flags-nv vk-flags)
(defctype vk-geometry-flags-khr vk-flags)
(defctype vk-build-acceleration-structure-flags-khr vk-flags)
(defctype vk-descriptor-binding-flags vk-flags)
(defctype vk-acquire-profiling-lock-flags-khr vk-flags)
(defctype vk-conditional-rendering-flags-ext vk-flags)
(defctype vk-pipeline-rasterization-depth-clip-state-create-flags-ext vk-flags)
(defctype vk-pipeline-rasterization-state-stream-create-flags-ext vk-flags)
(defctype vk-sample-count-flags vk-flags)
(defctype vk-pipeline-coverage-modulation-state-create-flags-nv vk-flags)
(defctype vk-indirect-commands-layout-usage-flags-nv vk-flags)
(defctype vk-indirect-state-flags-nv vk-flags)
(defctype vk-sparse-image-format-flags vk-flags)
(defctype vk-sparse-memory-bind-flags vk-flags)
(defctype vk-surface-transform-flags-khr vk-flags)
(defctype vk-display-plane-alpha-flags-khr vk-flags)
(defctype vk-composite-alpha-flags-khr vk-flags)
(defctype vk-surface-counter-flags-ext vk-flags)
(defctype vk-device-group-present-mode-flags-khr vk-flags)
(defctype vk-build-acceleration-structure-flags-khr vk-flags)
(defctype vk-geometry-instance-flags-khr vk-flags)
(defctype vk-subgroup-feature-flags vk-flags)
(defctype vk-shader-core-properties-flags-amd vk-flags)
(defctype vk-format-feature-flags vk-flags)
(defctype vk-external-memory-handle-type-flags-nv vk-flags)
(defctype vk-external-memory-feature-flags-nv vk-flags)
(defctype vk-external-memory-feature-flags vk-flags)
(defctype vk-external-memory-handle-type-flags vk-flags)
(defctype vk-external-semaphore-handle-type-flags vk-flags)
(defctype vk-external-semaphore-feature-flags vk-flags)
(defctype vk-external-fence-feature-flags vk-flags)
(defctype vk-debug-utils-messenger-create-flags-ext vk-flags)
(defctype vk-debug-utils-message-severity-flags-ext vk-flags)
(defctype vk-debug-utils-message-type-flags-ext vk-flags)
(defctype vk-debug-utils-messenger-callback-data-flags-ext vk-flags)
(defctype vk-debug-report-flags-ext vk-flags)
(defctype vk-tool-purpose-flags-ext vk-flags)
(defctype vk-memory-map-flags vk-flags)
(defctype vk-query-result-flags vk-flags)
(defctype vk-descriptor-pool-reset-flags vk-flags)
(defctype vk-command-pool-reset-flags vk-flags)
(defctype vk-command-buffer-reset-flags vk-flags)
(defctype vk-stencil-face-flags vk-flags)
(defctype vk-command-pool-trim-flags vk-flags)
(defctype vk-peer-memory-feature-flags vk-flags)

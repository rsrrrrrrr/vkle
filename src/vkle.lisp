(in-package :vkle)
#|
(export
 '(with-surface
   queue-family-index-support-present-p
   get-instance-extensions
   get-physical-device-surface-capabilities))

(defctype vk-handle (:pointer :void))

(defcenum (surface-transform-flag-bits)
  (:identity-bit #X00000001)
  (:rotate-90-bit #X00000002)
  (:rotate-180-bit #X00000004)
  (:rotate-270-bit #X00000008)
  (:horizontal-mirror-bit #X00000010)
  (:horizontal-mirror-rotate-90-bit #X00000020)
  (:horizontal-mirror-rotate-180-bit #X00000040)
  (:horizontal-mirror-rotate-270-bit #X00000080)
  (:inherit-bit #X00000100))

(defcenum (image-usage-flag-bits)
  (:transfer-src-bit #X00000001)
  (:transfer-dst-bit #X00000002)
  (:sampled-bit #X00000004)
  (:storage-bit #X00000008)
  (:color-attachment-bit #X00000010)
  (:depth-stencil-attachment-bit #X00000020)
  (:transient-attachment-bit #X00000040)
  (:input-attachment-bit #X00000080)
  (:shading-rate-image-bit-nv #X00000100)
  (:fragment-density-map-bit-ext #X00000200))

(defcenum (vk-create-structure-flag)
  (:application-info  0)
  (:instance-create-info  1)
  (:device-queue-create-info  2)
  (:device-create-info  3)
  (:submit-info  4)
  (:memory-allocate-info  5)
  (:mapped-memory-range  6)
  (:bind-sparse-info  7)
  (:fence-create-info  8)
  (:semaphore-create-info  9)
  (:event-create-info  10)
  (:query-pool-create-info  11)
  (:buffer-create-info  12)
  (:buffer-view-create-info  13)
  (:image-create-info  14)
  (:image-view-create-info  15)
  (:shader-module-create-info  16)
  (:pipeline-cache-create-info  17)
  (:pipeline-shader-stage-create-info  18)
  (:pipeline-vertex-input-state-create-info  19)
  (:pipeline-input-assembly-state-create-info  20)
  (:pipeline-tessellation-state-create-info  21)
  (:pipeline-viewport-state-create-info  22)
  (:pipeline-rasterization-state-create-info  23)
  (:pipeline-multisample-state-create-info  24)
  (:pipeline-depth-stencil-state-create-info  25)
  (:pipeline-color-blend-state-create-info  26)
  (:pipeline-dynamic-state-create-info  27)
  (:graphics-pipeline-create-info  28)
  (:compute-pipeline-create-info  29)
  (:pipeline-layout-create-info  30)
  (:sampler-create-info  31)
  (:descriptor-set-layout-create-info  32)
  (:descriptor-pool-create-info  33)
  (:descriptor-set-allocate-info  34)
  (:write-descriptor-set  35)
  (:copy-descriptor-set  36)
  (:framebuffer-create-info  37)
  (:render-pass-create-info  38)
  (:command-pool-create-info  39)
  (:command-buffer-allocate-info  40)
  (:command-buffer-inheritance-info  41)
  (:command-buffer-begin-info  42)
  (:render-pass-begin-info  43)
  (:buffer-memory-barrier  44)
  (:image-memory-barrier  45)
  (:memory-barrier  46)
  (:loader-instance-create-info  47)
  (:loader-device-create-info  48)
  ;; Provided by VK-VERSION-1-1
  (:physical-device-subgroup-properties  1000094000)
  ;; Provided by VK-VERSION-1-1
  (:bind-buffer-memory-info  1000157000)
  ;; Provided by VK-VERSION-1-1
  (:bind-image-memory-info  1000157001)
  ;; Provided by VK-VERSION-1-1
  (:physical-device-16bit-storage-features  1000083000)
  ;; Provided by VK-VERSION-1-1
  (:memory-dedicated-requirements  1000127000)
  ;; Provided by VK-VERSION-1-1
  (:memory-dedicated-allocate-info  1000127001)
  ;; Provided by VK-VERSION-1-1
  (:memory-allocate-flags-info  1000060000)
  ;; Provided by VK-VERSION-1-1
  (:device-group-render-pass-begin-info  1000060003)
  ;; Provided by VK-VERSION-1-1
  (:device-group-command-buffer-begin-info  1000060004)
  ;; Provided by VK-VERSION-1-1
  (:device-group-submit-info  1000060005)
  ;; Provided by VK-VERSION-1-1
  (:device-group-bind-sparse-info  1000060006)
  ;; Provided by VK-VERSION-1-1
  (:bind-buffer-memory-device-group-info  1000060013)
  ;; Provided by VK-VERSION-1-1
  (:bind-image-memory-device-group-info  1000060014)
  ;; Provided by VK-VERSION-1-1
  (:physical-device-group-properties  1000070000)
  ;; Provided by VK-VERSION-1-1
  (:device-group-device-create-info  1000070001)
  ;; Provided by VK-VERSION-1-1
  (:buffer-memory-requirements-info-2  1000146000)
  ;; Provided by VK-VERSION-1-1
  (:image-memory-requirements-info-2  1000146001)
  ;; Provided by VK-VERSION-1-1
  (:image-sparse-memory-requirements-info-2  1000146002)
  ;; Provided by VK-VERSION-1-1
  (:memory-requirements-2  1000146003)
  ;; Provided by VK-VERSION-1-1
  (:sparse-image-memory-requirements-2  1000146004)
  ;; Provided by VK-VERSION-1-1
  (:physical-device-features-2  1000059000)
  ;; Provided by VK-VERSION-1-1
  (:physical-device-properties-2  1000059001)
  ;; Provided by VK-VERSION-1-1
  (:format-properties-2  1000059002)
  ;; Provided by VK-VERSION-1-1
  (:image-format-properties-2  1000059003)
  ;; Provided by VK-VERSION-1-1
  (:physical-device-image-format-info-2  1000059004)
  ;; Provided by VK-VERSION-1-1
  (:queue-family-properties-2  1000059005)
  ;; Provided by VK-VERSION-1-1
  (:physical-device-memory-properties-2  1000059006)
  ;; Provided by VK-VERSION-1-1
  (:sparse-image-format-properties-2  1000059007)
  ;; Provided by VK-VERSION-1-1
  (:physical-device-sparse-image-format-info-2  1000059008)
  ;; Provided by VK-VERSION-1-1
  (:physical-device-point-clipping-properties  1000117000)
  ;; Provided by VK-VERSION-1-1
  (:render-pass-input-attachment-aspect-create-info  1000117001)
  ;; Provided by VK-VERSION-1-1
  (:image-view-usage-create-info  1000117002)
  ;; Provided by VK-VERSION-1-1
  (:pipeline-tessellation-domain-origin-state-create-info  1000117003)
  ;; Provided by VK-VERSION-1-1
  (:render-pass-multiview-create-info  1000053000)
  ;; Provided by VK-VERSION-1-1
  (:physical-device-multiview-features  1000053001)
  ;; Provided by VK-VERSION-1-1
  (:physical-device-multiview-properties  1000053002)
  ;; Provided by VK-VERSION-1-1
  (:physical-device-variable-pointers-features  1000120000)
  ;; Provided by VK-VERSION-1-1
  (:protected-submit-info  1000145000)
  ;; Provided by VK-VERSION-1-1
  (:physical-device-protected-memory-features  1000145001)
  ;; Provided by VK-VERSION-1-1
  (:physical-device-protected-memory-properties  1000145002)
  ;; Provided by VK-VERSION-1-1
  (:device-queue-info-2  1000145003)
  ;; Provided by VK-VERSION-1-1
  (:sampler-ycbcr-conversion-create-info  1000156000)
  ;; Provided by VK-VERSION-1-1
  (:sampler-ycbcr-conversion-info  1000156001)
  ;; Provided by VK-VERSION-1-1
  (:bind-image-plane-memory-info  1000156002)
  ;; Provided by VK-VERSION-1-1
  (:image-plane-memory-requirements-info  1000156003)
  ;; Provided by VK-VERSION-1-1
  (:physical-device-sampler-ycbcr-conversion-features  1000156004)
  ;; Provided by VK-VERSION-1-1
  (:sampler-ycbcr-conversion-image-format-properties  1000156005)
  ;; Provided by VK-VERSION-1-1
  (:descriptor-update-template-create-info  1000085000)
  ;; Provided by VK-VERSION-1-1
  (:physical-device-external-image-format-info  1000071000)
  ;; Provided by VK-VERSION-1-1
  (:external-image-format-properties  1000071001)
  ;; Provided by VK-VERSION-1-1
  (:physical-device-external-buffer-info  1000071002)
  ;; Provided by VK-VERSION-1-1
  (:external-buffer-properties  1000071003)
  ;; Provided by VK-VERSION-1-1
  (:physical-device-id-properties  1000071004)
  ;; Provided by VK-VERSION-1-1
  (:external-memory-buffer-create-info  1000072000)
  ;; Provided by VK-VERSION-1-1
  (:external-memory-image-create-info  1000072001)
  ;; Provided by VK-VERSION-1-1
  (:export-memory-allocate-info  1000072002)
  ;; Provided by VK-VERSION-1-1
  (:physical-device-external-fence-info  1000112000)
  ;; Provided by VK-VERSION-1-1
  (:external-fence-properties  1000112001)
  ;; Provided by VK-VERSION-1-1
  (:export-fence-create-info  1000113000)
  ;; Provided by VK-VERSION-1-1
  (:export-semaphore-create-info  1000077000)
  ;; Provided by VK-VERSION-1-1
  (:physical-device-external-semaphore-info  1000076000)
  ;; Provided by VK-VERSION-1-1
  (:external-semaphore-properties  1000076001)
  ;; Provided by VK-VERSION-1-1
  (:physical-device-maintenance-3-properties  1000168000)
  ;; Provided by VK-VERSION-1-1
  (:descriptor-set-layout-support  1000168001)
  ;; Provided by VK-VERSION-1-1
  (:physical-device-shader-draw-parameters-features  1000063000)
  ;; Provided by VK-VERSION-1-2
  (:physical-device-vulkan-1-1-features  49)
  ;; Provided by VK-VERSION-1-2
  (:physical-device-vulkan-1-1-properties  50)
  ;; Provided by VK-VERSION-1-2
  (:physical-device-vulkan-1-2-features  51)
  ;; Provided by VK-VERSION-1-2
  (:physical-device-vulkan-1-2-properties  52)
  ;; Provided by VK-VERSION-1-2
  (:image-format-list-create-info  1000147000)
  ;; Provided by VK-VERSION-1-2
  (:attachment-description-2  1000109000)
  ;; Provided by VK-VERSION-1-2
  (:attachment-reference-2  1000109001)
  ;; Provided by VK-VERSION-1-2
  (:subpass-description-2  1000109002)
  ;; Provided by VK-VERSION-1-2
  (:subpass-dependency-2  1000109003)
  ;; Provided by VK-VERSION-1-2
  (:render-pass-create-info-2  1000109004)
  ;; Provided by VK-VERSION-1-2
  (:subpass-begin-info  1000109005)
  ;; Provided by VK-VERSION-1-2
  (:subpass-end-info  1000109006)
  ;; Provided by VK-VERSION-1-2
  (:physical-device-8bit-storage-features  1000177000)
  ;; Provided by VK-VERSION-1-2
  (:physical-device-driver-properties  1000196000)
  ;; Provided by VK-VERSION-1-2
  (:physical-device-shader-atomic-int64-features  1000180000)
  ;; Provided by VK-VERSION-1-2
  (:physical-device-shader-float16-int8-features  1000082000)
  ;; Provided by VK-VERSION-1-2
  (:physical-device-float-controls-properties  1000197000)
  ;; Provided by VK-VERSION-1-2
  (:descriptor-set-layout-binding-flags-create-info  1000161000)
  ;; Provided by VK-VERSION-1-2
  (:physical-device-descriptor-indexing-features  1000161001)
  ;; Provided by VK-VERSION-1-2
  (:physical-device-descriptor-indexing-properties  1000161002)
  ;; Provided by VK-VERSION-1-2
  (:descriptor-set-variable-descriptor-count-allocate-info  1000161003)
  ;; Provided by VK-VERSION-1-2
  (:descriptor-set-variable-descriptor-count-layout-support  1000161004)
  ;; Provided by VK-VERSION-1-2
  (:physical-device-depth-stencil-resolve-properties  1000199000)
  ;; Provided by VK-VERSION-1-2
  (:subpass-description-depth-stencil-resolve  1000199001)
  ;; Provided by VK-VERSION-1-2
  (:physical-device-scalar-block-layout-features  1000221000)
  ;; Provided by VK-VERSION-1-2
  (:image-stencil-usage-create-info  1000246000)
  ;; Provided by VK-VERSION-1-2
  (:physical-device-sampler-filter-minmax-properties  1000130000)
  ;; Provided by VK-VERSION-1-2
  (:sampler-reduction-mode-create-info  1000130001)
  ;; Provided by VK-VERSION-1-2
  (:physical-device-vulkan-memory-model-features  1000211000)
  ;; Provided by VK-VERSION-1-2
  (:physical-device-imageless-framebuffer-features  1000108000)
  ;; Provided by VK-VERSION-1-2
  (:framebuffer-attachments-create-info  1000108001)
  ;; Provided by VK-VERSION-1-2
  (:framebuffer-attachment-image-info  1000108002)
  ;; Provided by VK-VERSION-1-2
  (:render-pass-attachment-begin-info  1000108003)
  ;; Provided by VK-VERSION-1-2
  (:physical-device-uniform-buffer-standard-layout-features  1000253000)
  ;; Provided by VK-VERSION-1-2
  (:physical-device-shader-subgroup-extended-types-features  1000175000)
  ;; Provided by VK-VERSION-1-2
  (:physical-device-separate-depth-stencil-layouts-features  1000241000)
  ;; Provided by VK-VERSION-1-2
  (:attachment-reference-stencil-layout  1000241001)
  ;; Provided by VK-VERSION-1-2
  (:attachment-description-stencil-layout  1000241002)
  ;; Provided by VK-VERSION-1-2
  (:physical-device-host-query-reset-features  1000261000)
  ;; Provided by VK-VERSION-1-2
  (:physical-device-timeline-semaphore-features  1000207000)
  ;; Provided by VK-VERSION-1-2
  (:physical-device-timeline-semaphore-properties  1000207001)
  ;; Provided by VK-VERSION-1-2
  (:semaphore-type-create-info  1000207002)
  ;; Provided by VK-VERSION-1-2
  (:timeline-semaphore-submit-info  1000207003)
  ;; Provided by VK-VERSION-1-2
  (:semaphore-wait-info  1000207004)
  ;; Provided by VK-VERSION-1-2
  (:semaphore-signal-info  1000207005)
  ;; Provided by VK-VERSION-1-2
  (:physical-device-buffer-device-address-features  1000257000)
  ;; Provided by VK-VERSION-1-2
  (:buffer-device-address-info  1000244001)
  ;; Provided by VK-VERSION-1-2
  (:buffer-opaque-capture-address-create-info  1000257002)
  ;; Provided by VK-VERSION-1-2
  (:memory-opaque-capture-address-allocate-info  1000257003)
  ;; Provided by VK-VERSION-1-2
  (:device-memory-opaque-capture-address-info  1000257004)
  ;; Provided by VK-KHR-swapchain
  (:swapchain-create-info-khr  1000001000)
  ;; Provided by VK-KHR-swapchain
  (:present-info-khr  1000001001)
  ;; Provided by VK-KHR-swapchain with VK-VERSION-1-1 VK-KHR-device-group with VK-KHR-surface
  (:device-group-present-capabilities-khr  1000060007)
  ;; Provided by VK-KHR-swapchain with VK-VERSION-1-1 VK-KHR-device-group with VK-KHR-swapchain
  (:image-swapchain-create-info-khr  1000060008)
  ;; Provided by VK-KHR-swapchain with VK-VERSION-1-1 VK-KHR-device-group with VK-KHR-swapchain
  (:bind-image-memory-swapchain-info-khr  1000060009)
  ;; Provided by VK-KHR-swapchain with VK-VERSION-1-1 VK-KHR-device-group with VK-KHR-swapchain
  (:acquire-next-image-info-khr  1000060010)
  ;; Provided by VK-KHR-swapchain with VK-VERSION-1-1 VK-KHR-device-group with VK-KHR-swapchain
  (:device-group-present-info-khr  1000060011)
  ;; Provided by VK-KHR-swapchain with VK-VERSION-1-1 VK-KHR-device-group with VK-KHR-swapchain
  (:device-group-swapchain-create-info-khr  1000060012)
  ;; Provided by VK-KHR-display
  (:display-mode-create-info-khr  1000002000)
  ;; Provided by VK-KHR-display
  (:display-surface-create-info-khr  1000002001)
  ;; Provided by VK-KHR-display-swapchain
  (:display-present-info-khr  1000003000)
  ;; Provided by VK-KHR-xlib-surface
  (:xlib-surface-create-info-khr  1000004000)
  ;; Provided by VK-KHR-xcb-surface
  (:xcb-surface-create-info-khr  1000005000)
  ;; Provided by VK-KHR-wayland-surface
  (:wayland-surface-create-info-khr  1000006000)
  ;; Provided by VK-KHR-android-surface
  (:android-surface-create-info-khr  1000008000)
  ;; Provided by VK-KHR-win32-surface
  (:win32-surface-create-info-khr  1000009000)
  ;; Provided by VK-EXT-debug-report
  (:debug-report-callback-create-info-ext  1000011000)
  ;; Provided by VK-AMD-rasterization-order
  (:pipeline-rasterization-state-rasterization-order-amd  1000018000)
  ;; Provided by VK-EXT-debug-marker
  (:debug-marker-object-name-info-ext  1000022000)
  ;; Provided by VK-EXT-debug-marker
  (:debug-marker-object-tag-info-ext  1000022001)
  ;; Provided by VK-EXT-debug-marker
  (:debug-marker-marker-info-ext  1000022002)
  ;; Provided by VK-NV-dedicated-allocation
  (:dedicated-allocation-image-create-info-nv  1000026000)
  ;; Provided by VK-NV-dedicated-allocation
  (:dedicated-allocation-buffer-create-info-nv  1000026001)
  ;; Provided by VK-NV-dedicated-allocation
  (:dedicated-allocation-memory-allocate-info-nv  1000026002)
  ;; Provided by VK-EXT-transform-feedback
  (:physical-device-transform-feedback-features-ext  1000028000)
  ;; Provided by VK-EXT-transform-feedback
  (:physical-device-transform-feedback-properties-ext  1000028001)
  ;; Provided by VK-EXT-transform-feedback
  (:pipeline-rasterization-state-stream-create-info-ext  1000028002)
  ;; Provided by VK-NVX-image-view-handle
  (:image-view-handle-info-nvx  1000030000)
  ;; Provided by VK-NVX-image-view-handle
  (:image-view-address-properties-nvx  1000030001)
  ;; Provided by VK-AMD-texture-gather-bias-lod
  (:texture-lod-gather-format-properties-amd  1000041000)
  ;; Provided by VK-GGP-stream-descriptor-surface
  (:stream-descriptor-surface-create-info-ggp  1000049000)
  ;; Provided by VK-NV-corner-sampled-image
  (:physical-device-corner-sampled-image-features-nv  1000050000)
  ;; Provided by VK-NV-external-memory
  (:external-memory-image-create-info-nv  1000056000)
  ;; Provided by VK-NV-external-memory
  (:export-memory-allocate-info-nv  1000056001)
  ;; Provided by VK-NV-external-memory-win32
  (:import-memory-win32-handle-info-nv  1000057000)
  ;; Provided by VK-NV-external-memory-win32
  (:export-memory-win32-handle-info-nv  1000057001)
  ;; Provided by VK-NV-win32-keyed-mutex
  (:win32-keyed-mutex-acquire-release-info-nv  1000058000)
  ;; Provided by VK-EXT-validation-flags
  (:validation-flags-ext  1000061000)
  ;; Provided by VK-NN-vi-surface
  (:vi-surface-create-info-nn  1000062000)
  ;; Provided by VK-EXT-texture-compression-astc-hdr
  (:physical-device-texture-compression-astc-hdr-features-ext  1000066000)
  ;; Provided by VK-EXT-astc-decode-mode
  (:image-view-astc-decode-mode-ext  1000067000)
  ;; Provided by VK-EXT-astc-decode-mode
  (:physical-device-astc-decode-features-ext  1000067001)
  ;; Provided by VK-KHR-external-memory-win32
  (:import-memory-win32-handle-info-khr  1000073000)
  ;; Provided by VK-KHR-external-memory-win32
  (:export-memory-win32-handle-info-khr  1000073001)
  ;; Provided by VK-KHR-external-memory-win32
  (:memory-win32-handle-properties-khr  1000073002)
  ;; Provided by VK-KHR-external-memory-win32
  (:memory-get-win32-handle-info-khr  1000073003)
  ;; Provided by VK-KHR-external-memory-fd
  (:import-memory-fd-info-khr  1000074000)
  ;; Provided by VK-KHR-external-memory-fd
  (:memory-fd-properties-khr  1000074001)
  ;; Provided by VK-KHR-external-memory-fd
  (:memory-get-fd-info-khr  1000074002)
  ;; Provided by VK-KHR-win32-keyed-mutex
  (:win32-keyed-mutex-acquire-release-info-khr  1000075000)
  ;; Provided by VK-KHR-external-semaphore-win32
  (:import-semaphore-win32-handle-info-khr  1000078000)
  ;; Provided by VK-KHR-external-semaphore-win32
  (:export-semaphore-win32-handle-info-khr  1000078001)
  ;; Provided by VK-KHR-external-semaphore-win32
  (:d3d12-fence-submit-info-khr  1000078002)
  ;; Provided by VK-KHR-external-semaphore-win32
  (:semaphore-get-win32-handle-info-khr  1000078003)
  ;; Provided by VK-KHR-external-semaphore-fd
  (:import-semaphore-fd-info-khr  1000079000)
  ;; Provided by VK-KHR-external-semaphore-fd
  (:semaphore-get-fd-info-khr  1000079001)
  ;; Provided by VK-KHR-push-descriptor
  (:physical-device-push-descriptor-properties-khr  1000080000)
  ;; Provided by VK-EXT-conditional-rendering
  (:command-buffer-inheritance-conditional-rendering-info-ext  1000081000)
  ;; Provided by VK-EXT-conditional-rendering
  (:physical-device-conditional-rendering-features-ext  1000081001)
  ;; Provided by VK-EXT-conditional-rendering
  (:conditional-rendering-begin-info-ext  1000081002)
  ;; Provided by VK-KHR-incremental-present
  (:present-regions-khr  1000084000)
  ;; Provided by VK-NV-clip-space-w-scaling
  (:pipeline-viewport-w-scaling-state-create-info-nv  1000087000)
  ;; Provided by VK-EXT-display-surface-counter
  (:surface-capabilities-2-ext  1000090000)
  ;; Provided by VK-EXT-display-control
  (:display-power-info-ext  1000091000)
  ;; Provided by VK-EXT-display-control
  (:device-event-info-ext  1000091001)
  ;; Provided by VK-EXT-display-control
  (:display-event-info-ext  1000091002)
  ;; Provided by VK-EXT-display-control
  (:swapchain-counter-create-info-ext  1000091003)
  ;; Provided by VK-GOOGLE-display-timing
  (:present-times-info-google  1000092000)
  ;; Provided by VK-NVX-multiview-per-view-attributes
  (:physical-device-multiview-per-view-attributes-properties-nvx  1000097000)
  ;; Provided by VK-NV-viewport-swizzle
  (:pipeline-viewport-swizzle-state-create-info-nv  1000098000)
  ;; Provided by VK-EXT-discard-rectangles
  (:physical-device-discard-rectangle-properties-ext  1000099000)
  ;; Provided by VK-EXT-discard-rectangles
  (:pipeline-discard-rectangle-state-create-info-ext  1000099001)
  ;; Provided by VK-EXT-conservative-rasterization
  (:physical-device-conservative-rasterization-properties-ext  1000101000)
  ;; Provided by VK-EXT-conservative-rasterization
  (:pipeline-rasterization-conservative-state-create-info-ext  1000101001)
  ;; Provided by VK-EXT-depth-clip-enable
  (:physical-device-depth-clip-enable-features-ext  1000102000)
  ;; Provided by VK-EXT-depth-clip-enable
  (:pipeline-rasterization-depth-clip-state-create-info-ext  1000102001)
  ;; Provided by VK-EXT-hdr-metadata
  (:hdr-metadata-ext  1000105000)
  ;; Provided by VK-KHR-shared-presentable-image
  (:shared-present-surface-capabilities-khr  1000111000)
  ;; Provided by VK-KHR-external-fence-win32
  (:import-fence-win32-handle-info-khr  1000114000)
  ;; Provided by VK-KHR-external-fence-win32
  (:export-fence-win32-handle-info-khr  1000114001)
  ;; Provided by VK-KHR-external-fence-win32
  (:fence-get-win32-handle-info-khr  1000114002)
  ;; Provided by VK-KHR-external-fence-fd
  (:import-fence-fd-info-khr  1000115000)
  ;; Provided by VK-KHR-external-fence-fd
  (:fence-get-fd-info-khr  1000115001)
  ;; Provided by VK-KHR-performance-query
  (:physical-device-performance-query-features-khr  1000116000)
  ;; Provided by VK-KHR-performance-query
  (:physical-device-performance-query-properties-khr  1000116001)
  ;; Provided by VK-KHR-performance-query
  (:query-pool-performance-create-info-khr  1000116002)
  ;; Provided by VK-KHR-performance-query
  (:performance-query-submit-info-khr  1000116003)
  ;; Provided by VK-KHR-performance-query
  (:acquire-profiling-lock-info-khr  1000116004)
  ;; Provided by VK-KHR-performance-query
  (:performance-counter-khr  1000116005)
  ;; Provided by VK-KHR-performance-query
  (:performance-counter-description-khr  1000116006)
  ;; Provided by VK-KHR-get-surface-capabilities2
  (:physical-device-surface-info-2-khr  1000119000)
  ;; Provided by VK-KHR-get-surface-capabilities2
  (:surface-capabilities-2-khr  1000119001)
  ;; Provided by VK-KHR-get-surface-capabilities2
  (:surface-format-2-khr  1000119002)
  ;; Provided by VK-KHR-get-display-properties2
  (:display-properties-2-khr  1000121000)
  ;; Provided by VK-KHR-get-display-properties2
  (:display-plane-properties-2-khr  1000121001)
  ;; Provided by VK-KHR-get-display-properties2
  (:display-mode-properties-2-khr  1000121002)
  ;; Provided by VK-KHR-get-display-properties2
  (:display-plane-info-2-khr  1000121003)
  ;; Provided by VK-KHR-get-display-properties2
  (:display-plane-capabilities-2-khr  1000121004)
  ;; Provided by VK-MVK-ios-surface
  (:ios-surface-create-info-mvk  1000122000)
  ;; Provided by VK-MVK-macos-surface
  (:macos-surface-create-info-mvk  1000123000)
  ;; Provided by VK-EXT-debug-utils
  (:debug-utils-object-name-info-ext  1000128000)
  ;; Provided by VK-EXT-debug-utils
  (:debug-utils-object-tag-info-ext  1000128001)
  ;; Provided by VK-EXT-debug-utils
  (:debug-utils-label-ext  1000128002)
  ;; Provided by VK-EXT-debug-utils
  (:debug-utils-messenger-callback-data-ext  1000128003)
  ;; Provided by VK-EXT-debug-utils
  (:debug-utils-messenger-create-info-ext  1000128004)
  ;; Provided by VK-ANDROID-external-memory-android-hardware-buffer
  (:android-hardware-buffer-usage-android  1000129000)
  ;; Provided by VK-ANDROID-external-memory-android-hardware-buffer
  (:android-hardware-buffer-properties-android  1000129001)
  ;; Provided by VK-ANDROID-external-memory-android-hardware-buffer
  (:android-hardware-buffer-format-properties-android  1000129002)
  ;; Provided by VK-ANDROID-external-memory-android-hardware-buffer
  (:import-android-hardware-buffer-info-android  1000129003)
  ;; Provided by VK-ANDROID-external-memory-android-hardware-buffer
  (:memory-get-android-hardware-buffer-info-android  1000129004)
  ;; Provided by VK-ANDROID-external-memory-android-hardware-buffer
  (:external-format-android  1000129005)
  ;; Provided by VK-EXT-inline-uniform-block
  (:physical-device-inline-uniform-block-features-ext  1000138000)
  ;; Provided by VK-EXT-inline-uniform-block
  (:physical-device-inline-uniform-block-properties-ext  1000138001)
  ;; Provided by VK-EXT-inline-uniform-block
  (:write-descriptor-set-inline-uniform-block-ext  1000138002)
  ;; Provided by VK-EXT-inline-uniform-block
  (:descriptor-pool-inline-uniform-block-create-info-ext  1000138003)
  ;; Provided by VK-EXT-sample-locations
  (:sample-locations-info-ext  1000143000)
  ;; Provided by VK-EXT-sample-locations
  (:render-pass-sample-locations-begin-info-ext  1000143001)
  ;; Provided by VK-EXT-sample-locations
  (:pipeline-sample-locations-state-create-info-ext  1000143002)
  ;; Provided by VK-EXT-sample-locations
  (:physical-device-sample-locations-properties-ext  1000143003)
  ;; Provided by VK-EXT-sample-locations
  (:multisample-properties-ext  1000143004)
  ;; Provided by VK-EXT-blend-operation-advanced
  (:physical-device-blend-operation-advanced-features-ext  1000148000)
  ;; Provided by VK-EXT-blend-operation-advanced
  (:physical-device-blend-operation-advanced-properties-ext  1000148001)
  ;; Provided by VK-EXT-blend-operation-advanced
  (:pipeline-color-blend-advanced-state-create-info-ext  1000148002)
  ;; Provided by VK-NV-fragment-coverage-to-color
  (:pipeline-coverage-to-color-state-create-info-nv  1000149000)
  ;; Provided by VK-KHR-ray-tracing
  (:bind-acceleration-structure-memory-info-khr  1000165006)
  ;; Provided by VK-KHR-ray-tracing
  (:write-descriptor-set-acceleration-structure-khr  1000165007)
  ;; Provided by VK-KHR-ray-tracing
  (:acceleration-structure-build-geometry-info-khr  1000150000)
  ;; Provided by VK-KHR-ray-tracing
  (:acceleration-structure-create-geometry-type-info-khr  1000150001)
  ;; Provided by VK-KHR-ray-tracing
  (:acceleration-structure-device-address-info-khr  1000150002)
  ;; Provided by VK-KHR-ray-tracing
  (:acceleration-structure-geometry-aabbs-data-khr  1000150003)
  ;; Provided by VK-KHR-ray-tracing
  (:acceleration-structure-geometry-instances-data-khr  1000150004)
  ;; Provided by VK-KHR-ray-tracing
  (:acceleration-structure-geometry-triangles-data-khr  1000150005)
  ;; Provided by VK-KHR-ray-tracing
  (:acceleration-structure-geometry-khr  1000150006)
  ;; Provided by VK-KHR-ray-tracing
  (:acceleration-structure-memory-requirements-info-khr  1000150008)
  ;; Provided by VK-KHR-ray-tracing
  (:acceleration-structure-version-khr  1000150009)
  ;; Provided by VK-KHR-ray-tracing
  (:copy-acceleration-structure-info-khr  1000150010)
  ;; Provided by VK-KHR-ray-tracing
  (:copy-acceleration-structure-to-memory-info-khr  1000150011)
  ;; Provided by VK-KHR-ray-tracing
  (:copy-memory-to-acceleration-structure-info-khr  1000150012)
  ;; Provided by VK-KHR-ray-tracing
  (:physical-device-ray-tracing-features-khr  1000150013)
  ;; Provided by VK-KHR-ray-tracing
  (:physical-device-ray-tracing-properties-khr  1000150014)
  ;; Provided by VK-KHR-ray-tracing
  (:ray-tracing-pipeline-create-info-khr  1000150015)
  ;; Provided by VK-KHR-ray-tracing
  (:ray-tracing-shader-group-create-info-khr  1000150016)
  ;; Provided by VK-KHR-ray-tracing
  (:acceleration-structure-create-info-khr  1000150017)
  ;; Provided by VK-KHR-ray-tracing
  (:ray-tracing-pipeline-interface-create-info-khr  1000150018)
  ;; Provided by VK-NV-framebuffer-mixed-samples
  (:pipeline-coverage-modulation-state-create-info-nv  1000152000)
  ;; Provided by VK-NV-shader-sm-builtins
  (:physical-device-shader-sm-builtins-features-nv  1000154000)
  ;; Provided by VK-NV-shader-sm-builtins
  (:physical-device-shader-sm-builtins-properties-nv  1000154001)
  ;; Provided by VK-EXT-image-drm-format-modifier
  (:drm-format-modifier-properties-list-ext  1000158000)
  ;; Provided by VK-EXT-image-drm-format-modifier
  (:drm-format-modifier-properties-ext  1000158001)
  ;; Provided by VK-EXT-image-drm-format-modifier
  (:physical-device-image-drm-format-modifier-info-ext  1000158002)
  ;; Provided by VK-EXT-image-drm-format-modifier
  (:image-drm-format-modifier-list-create-info-ext  1000158003)
  ;; Provided by VK-EXT-image-drm-format-modifier
  (:image-drm-format-modifier-explicit-create-info-ext  1000158004)
  ;; Provided by VK-EXT-image-drm-format-modifier
  (:image-drm-format-modifier-properties-ext  1000158005)
  ;; Provided by VK-EXT-validation-cache
  (:validation-cache-create-info-ext  1000160000)
  ;; Provided by VK-EXT-validation-cache
  (:shader-module-validation-cache-create-info-ext  1000160001)
  ;; Provided by VK-NV-shading-rate-image
  (:pipeline-viewport-shading-rate-image-state-create-info-nv  1000164000)
  ;; Provided by VK-NV-shading-rate-image
  (:physical-device-shading-rate-image-features-nv  1000164001)
  ;; Provided by VK-NV-shading-rate-image
  (:physical-device-shading-rate-image-properties-nv  1000164002)
  ;; Provided by VK-NV-shading-rate-image
  (:pipeline-viewport-coarse-sample-order-state-create-info-nv  1000164005)
  ;; Provided by VK-NV-ray-tracing
  (:ray-tracing-pipeline-create-info-nv  1000165000)
  ;; Provided by VK-NV-ray-tracing
  (:acceleration-structure-create-info-nv  1000165001)
  ;; Provided by VK-NV-ray-tracing
  (:geometry-nv  1000165003)
  ;; Provided by VK-NV-ray-tracing
  (:geometry-triangles-nv  1000165004)
  ;; Provided by VK-NV-ray-tracing
  (:geometry-aabb-nv  1000165005)
  ;; Provided by VK-NV-ray-tracing
  (:acceleration-structure-memory-requirements-info-nv  1000165008)
  ;; Provided by VK-NV-ray-tracing
  (:physical-device-ray-tracing-properties-nv  1000165009)
  ;; Provided by VK-NV-ray-tracing
  (:ray-tracing-shader-group-create-info-nv  1000165011)
  ;; Provided by VK-NV-ray-tracing
  (:acceleration-structure-info-nv  1000165012)
  ;; Provided by VK-NV-representative-fragment-test
  (:physical-device-representative-fragment-test-features-nv  1000166000)
  ;; Provided by VK-NV-representative-fragment-test
  (:pipeline-representative-fragment-test-state-create-info-nv  1000166001)
  ;; Provided by VK-EXT-filter-cubic
  (:physical-device-image-view-image-format-info-ext  1000170000)
  ;; Provided by VK-EXT-filter-cubic
  (:filter-cubic-image-view-image-format-properties-ext  1000170001)
  ;; Provided by VK-EXT-global-priority
  (:device-queue-global-priority-create-info-ext  1000174000)
  ;; Provided by VK-EXT-external-memory-host
  (:import-memory-host-pointer-info-ext  1000178000)
  ;; Provided by VK-EXT-external-memory-host
  (:memory-host-pointer-properties-ext  1000178001)
  ;; Provided by VK-EXT-external-memory-host
  (:physical-device-external-memory-host-properties-ext  1000178002)
  ;; Provided by VK-KHR-shader-clock
  (:physical-device-shader-clock-features-khr  1000181000)
  ;; Provided by VK-AMD-pipeline-compiler-control
  (:pipeline-compiler-control-create-info-amd  1000183000)
  ;; Provided by VK-EXT-calibrated-timestamps
  (:calibrated-timestamp-info-ext  1000184000)
  ;; Provided by VK-AMD-shader-core-properties
  (:physical-device-shader-core-properties-amd  1000185000)
  ;; Provided by VK-AMD-memory-overallocation-behavior
  (:device-memory-overallocation-create-info-amd  1000189000)
  ;; Provided by VK-EXT-vertex-attribute-divisor
  (:physical-device-vertex-attribute-divisor-properties-ext  1000190000)
  ;; Provided by VK-EXT-vertex-attribute-divisor
  (:pipeline-vertex-input-divisor-state-create-info-ext  1000190001)
  ;; Provided by VK-EXT-vertex-attribute-divisor
  (:physical-device-vertex-attribute-divisor-features-ext  1000190002)
  ;; Provided by VK-GGP-frame-token
  (:present-frame-token-ggp  1000191000)
  ;; Provided by VK-EXT-pipeline-creation-feedback
  (:pipeline-creation-feedback-create-info-ext  1000192000)
  ;; Provided by VK-NV-compute-shader-derivatives
  (:physical-device-compute-shader-derivatives-features-nv  1000201000)
  ;; Provided by VK-NV-mesh-shader
  (:physical-device-mesh-shader-features-nv  1000202000)
  ;; Provided by VK-NV-mesh-shader
  (:physical-device-mesh-shader-properties-nv  1000202001)
  ;; Provided by VK-NV-fragment-shader-barycentric
  (:physical-device-fragment-shader-barycentric-features-nv  1000203000)
  ;; Provided by VK-NV-shader-image-footprint
  (:physical-device-shader-image-footprint-features-nv  1000204000)
  ;; Provided by VK-NV-scissor-exclusive
  (:pipeline-viewport-exclusive-scissor-state-create-info-nv  1000205000)
  ;; Provided by VK-NV-scissor-exclusive
  (:physical-device-exclusive-scissor-features-nv  1000205002)
  ;; Provided by VK-NV-device-diagnostic-checkpoints
  (:checkpoint-data-nv  1000206000)
  ;; Provided by VK-NV-device-diagnostic-checkpoints
  (:queue-family-checkpoint-properties-nv  1000206001)
  ;; Provided by VK-INTEL-shader-integer-functions2
  (:physical-device-shader-integer-functions-2-features-intel  1000209000)
  ;; Provided by VK-INTEL-performance-query
  (:query-pool-performance-query-create-info-intel  1000210000)
  ;; Provided by VK-INTEL-performance-query
  (:initialize-performance-api-info-intel  1000210001)
  ;; Provided by VK-INTEL-performance-query
  (:performance-marker-info-intel  1000210002)
  ;; Provided by VK-INTEL-performance-query
  (:performance-stream-marker-info-intel  1000210003)
  ;; Provided by VK-INTEL-performance-query
  (:performance-override-info-intel  1000210004)
  ;; Provided by VK-INTEL-performance-query
  (:performance-configuration-acquire-info-intel  1000210005)
  ;; Provided by VK-EXT-pci-bus-info
  (:physical-device-pci-bus-info-properties-ext  1000212000)
  ;; Provided by VK-AMD-display-native-hdr
  (:display-native-hdr-surface-capabilities-amd  1000213000)
  ;; Provided by VK-AMD-display-native-hdr
  (:swapchain-display-native-hdr-create-info-amd  1000213001)
  ;; Provided by VK-FUCHSIA-imagepipe-surface
  (:imagepipe-surface-create-info-fuchsia  1000214000)
  ;; Provided by VK-EXT-metal-surface
  (:metal-surface-create-info-ext  1000217000)
  ;; Provided by VK-EXT-fragment-density-map
  (:physical-device-fragment-density-map-features-ext  1000218000)
  ;; Provided by VK-EXT-fragment-density-map
  (:physical-device-fragment-density-map-properties-ext  1000218001)
  ;; Provided by VK-EXT-fragment-density-map
  (:render-pass-fragment-density-map-create-info-ext  1000218002)
  ;; Provided by VK-EXT-subgroup-size-control
  (:physical-device-subgroup-size-control-properties-ext  1000225000)
  ;; Provided by VK-EXT-subgroup-size-control
  (:pipeline-shader-stage-required-subgroup-size-create-info-ext  1000225001)
  ;; Provided by VK-EXT-subgroup-size-control
  (:physical-device-subgroup-size-control-features-ext  1000225002)
  ;; Provided by VK-AMD-shader-core-properties2
  (:physical-device-shader-core-properties-2-amd  1000227000)
  ;; Provided by VK-AMD-device-coherent-memory
  (:physical-device-coherent-memory-features-amd  1000229000)
  ;; Provided by VK-EXT-memory-budget
  (:physical-device-memory-budget-properties-ext  1000237000)
  ;; Provided by VK-EXT-memory-priority
  (:physical-device-memory-priority-features-ext  1000238000)
  ;; Provided by VK-EXT-memory-priority
  (:memory-priority-allocate-info-ext  1000238001)
  ;; Provided by VK-KHR-surface-protected-capabilities
  (:surface-protected-capabilities-khr  1000239000)
  ;; Provided by VK-NV-dedicated-allocation-image-aliasing
  (:physical-device-dedicated-allocation-image-aliasing-features-nv  1000240000)
  ;; Provided by VK-EXT-buffer-device-address
  (:physical-device-buffer-device-address-features-ext  1000244000)
  ;; Provided by VK-EXT-buffer-device-address
  (:buffer-device-address-create-info-ext  1000244002)
  ;; Provided by VK-EXT-tooling-info
  (:physical-device-tool-properties-ext  1000245000)
  ;; Provided by VK-EXT-validation-features
  (:validation-features-ext  1000247000)
  ;; Provided by VK-NV-cooperative-matrix
  (:physical-device-cooperative-matrix-features-nv  1000249000)
  ;; Provided by VK-NV-cooperative-matrix
  (:cooperative-matrix-properties-nv  1000249001)
  ;; Provided by VK-NV-cooperative-matrix
  (:physical-device-cooperative-matrix-properties-nv  1000249002)
  ;; Provided by VK-NV-coverage-reduction-mode
  (:physical-device-coverage-reduction-mode-features-nv  1000250000)
  ;; Provided by VK-NV-coverage-reduction-mode
  (:pipeline-coverage-reduction-state-create-info-nv  1000250001)
  ;; Provided by VK-NV-coverage-reduction-mode
  (:framebuffer-mixed-samples-combination-nv  1000250002)
  ;; Provided by VK-EXT-fragment-shader-interlock
  (:physical-device-fragment-shader-interlock-features-ext  1000251000)
  ;; Provided by VK-EXT-ycbcr-image-arrays
  (:physical-device-ycbcr-image-arrays-features-ext  1000252000)
  ;; Provided by VK-EXT-full-screen-exclusive
  (:surface-full-screen-exclusive-info-ext  1000255000)
  ;; Provided by VK-EXT-full-screen-exclusive
  (:surface-capabilities-full-screen-exclusive-ext  1000255002)
  ;; Provided by VK-EXT-full-screen-exclusive with VK-KHR-win32-surface
  (:surface-full-screen-exclusive-win32-info-ext  1000255001)
  ;; Provided by VK-EXT-headless-surface
  (:headless-surface-create-info-ext  1000256000)
  ;; Provided by VK-EXT-line-rasterization
  (:physical-device-line-rasterization-features-ext  1000259000)
  ;; Provided by VK-EXT-line-rasterization
  (:pipeline-rasterization-line-state-create-info-ext  1000259001)
  ;; Provided by VK-EXT-line-rasterization
  (:physical-device-line-rasterization-properties-ext  1000259002)
  ;; Provided by VK-EXT-shader-atomic-float
  (:physical-device-shader-atomic-float-features-ext  1000260000)
  ;; Provided by VK-EXT-index-type-uint8
  (:physical-device-index-type-uint8-features-ext  1000265000)
  ;; Provided by VK-EXT-extended-dynamic-state
  (:physical-device-extended-dynamic-state-features-ext  1000267000)
  ;; Provided by VK-KHR-deferred-host-operations
  (:deferred-operation-info-khr  1000268000)
  ;; Provided by VK-KHR-pipeline-executable-properties
  (:physical-device-pipeline-executable-properties-features-khr  1000269000)
  ;; Provided by VK-KHR-pipeline-executable-properties
  (:pipeline-info-khr  1000269001)
  ;; Provided by VK-KHR-pipeline-executable-properties
  (:pipeline-executable-properties-khr  1000269002)
  ;; Provided by VK-KHR-pipeline-executable-properties
  (:pipeline-executable-info-khr  1000269003)
  ;; Provided by VK-KHR-pipeline-executable-properties
  (:pipeline-executable-statistic-khr  1000269004)
  ;; Provided by VK-KHR-pipeline-executable-properties
  (:pipeline-executable-internal-representation-khr  1000269005)
  ;; Provided by VK-EXT-shader-demote-to-helper-invocation
  (:physical-device-shader-demote-to-helper-invocation-features-ext  1000276000)
  ;; Provided by VK-NV-device-generated-commands
  (:physical-device-device-generated-commands-properties-nv  1000277000)
  ;; Provided by VK-NV-device-generated-commands
  (:graphics-shader-group-create-info-nv  1000277001)
  ;; Provided by VK-NV-device-generated-commands
  (:graphics-pipeline-shader-groups-create-info-nv  1000277002)
  ;; Provided by VK-NV-device-generated-commands
  (:indirect-commands-layout-token-nv  1000277003)
  ;; Provided by VK-NV-device-generated-commands
  (:indirect-commands-layout-create-info-nv  1000277004)
  ;; Provided by VK-NV-device-generated-commands
  (:generated-commands-info-nv  1000277005)
  ;; Provided by VK-NV-device-generated-commands
  (:generated-commands-memory-requirements-info-nv  1000277006)
  ;; Provided by VK-NV-device-generated-commands
  (:physical-device-device-generated-commands-features-nv  1000277007)
  ;; Provided by VK-EXT-texel-buffer-alignment
  (:physical-device-texel-buffer-alignment-features-ext  1000281000)
  ;; Provided by VK-EXT-texel-buffer-alignment
  (:physical-device-texel-buffer-alignment-properties-ext  1000281001)
  ;; Provided by VK-QCOM-render-pass-transform
  (:command-buffer-inheritance-render-pass-transform-info-qcom  1000282000)
  ;; Provided by VK-QCOM-render-pass-transform
  (:render-pass-transform-begin-info-qcom  1000282001)
  ;; Provided by VK-EXT-robustness2
  (:physical-device-robustness-2-features-ext  1000286000)
  ;; Provided by VK-EXT-robustness2
  (:physical-device-robustness-2-properties-ext  1000286001)
  ;; Provided by VK-EXT-custom-border-color
  (:sampler-custom-border-color-create-info-ext  1000287000)
  ;; Provided by VK-EXT-custom-border-color
  (:physical-device-custom-border-color-properties-ext  1000287001)
  ;; Provided by VK-EXT-custom-border-color
  (:physical-device-custom-border-color-features-ext  1000287002)
  ;; Provided by VK-KHR-pipeline-library
  (:pipeline-library-create-info-khr  1000290000)
  ;; Provided by VK-EXT-private-data
  (:physical-device-private-data-features-ext  1000295000)
  ;; Provided by VK-EXT-private-data
  (:device-private-data-create-info-ext  1000295001)
  ;; Provided by VK-EXT-private-data
  (:private-data-slot-create-info-ext  1000295002)
  ;; Provided by VK-EXT-pipeline-creation-cache-control
  (:physical-device-pipeline-creation-cache-control-features-ext  1000297000)
  ;; Provided by VK-NV-device-diagnostics-config
  (:physical-device-diagnostics-config-features-nv  1000300000)
  ;; Provided by VK-NV-device-diagnostics-config
  (:device-diagnostics-config-create-info-nv  1000300001)
  ;; Provided by VK-EXT-fragment-density-map2
  (:physical-device-fragment-density-map-2-features-ext  1000332000)
  ;; Provided by VK-EXT-fragment-density-map2
  (:physical-device-fragment-density-map-2-properties-ext  1000332001)
  ;; Provided by VK-EXT-image-robustness
  (:physical-device-image-robustness-features-ext  1000335000)
  ;; Provided by VK-EXT-4444-formats
  (:physical-device-4444-formats-features-ext  1000340000)
  ;; Provided by VK-EXT-directfb-surface
  (:directfb-surface-create-info-ext  1000346000)
  (:physical-device-variable-pointer-features  :physical-device-variable-pointers-features)
  (:physical-device-shader-draw-parameter-features  :physical-device-shader-draw-parameters-features)
  (:debug-report-create-info-ext  :debug-report-callback-create-info-ext)
  ;; Provided by VK-KHR-multiview
  (:render-pass-multiview-create-info-khr  :render-pass-multiview-create-info)
  ;; Provided by VK-KHR-multiview
  (:physical-device-multiview-features-khr  :physical-device-multiview-features)
  ;; Provided by VK-KHR-multiview
  (:physical-device-multiview-properties-khr  :physical-device-multiview-properties)
  ;; Provided by VK-KHR-get-physical-device-properties2
  (:physical-device-features-2-khr  :physical-device-features-2)
  ;; Provided by VK-KHR-get-physical-device-properties2
  (:physical-device-properties-2-khr  :physical-device-properties-2)
  ;; Provided by VK-KHR-get-physical-device-properties2
  (:format-properties-2-khr  :format-properties-2)
  ;; Provided by VK-KHR-get-physical-device-properties2
  (:image-format-properties-2-khr  :image-format-properties-2)
  ;; Provided by VK-KHR-get-physical-device-properties2
  (:physical-device-image-format-info-2-khr  :physical-device-image-format-info-2)
  ;; Provided by VK-KHR-get-physical-device-properties2
  (:queue-family-properties-2-khr  :queue-family-properties-2)
  ;; Provided by VK-KHR-get-physical-device-properties2
  (:physical-device-memory-properties-2-khr  :physical-device-memory-properties-2)
  ;; Provided by VK-KHR-get-physical-device-properties2
  (:sparse-image-format-properties-2-khr  :sparse-image-format-properties-2)
  ;; Provided by VK-KHR-get-physical-device-properties2
  (:physical-device-sparse-image-format-info-2-khr  :physical-device-sparse-image-format-info-2)
  ;; Provided by VK-KHR-device-group
  (:memory-allocate-flags-info-khr  :memory-allocate-flags-info)
  ;; Provided by VK-KHR-device-group
  (:device-group-render-pass-begin-info-khr  :device-group-render-pass-begin-info)
  ;; Provided by VK-KHR-device-group
  (:device-group-command-buffer-begin-info-khr  :device-group-command-buffer-begin-info)
  ;; Provided by VK-KHR-device-group
  (:device-group-submit-info-khr  :device-group-submit-info)
  ;; Provided by VK-KHR-device-group
  (:device-group-bind-sparse-info-khr  :device-group-bind-sparse-info)
  ;; Provided by VK-KHR-device-group with VK-KHR-bind-memory2
  (:bind-buffer-memory-device-group-info-khr  :bind-buffer-memory-device-group-info)
  ;; Provided by VK-KHR-device-group with VK-KHR-bind-memory2
  (:bind-image-memory-device-group-info-khr  :bind-image-memory-device-group-info)
  ;; Provided by VK-KHR-device-group-creation
  (:physical-device-group-properties-khr  :physical-device-group-properties)
  ;; Provided by VK-KHR-device-group-creation
  (:device-group-device-create-info-khr  :device-group-device-create-info)
  ;; Provided by VK-KHR-external-memory-capabilities
  (:physical-device-external-image-format-info-khr  :physical-device-external-image-format-info)
  ;; Provided by VK-KHR-external-memory-capabilities
  (:external-image-format-properties-khr  :external-image-format-properties)
  ;; Provided by VK-KHR-external-memory-capabilities
  (:physical-device-external-buffer-info-khr  :physical-device-external-buffer-info)
  ;; Provided by VK-KHR-external-memory-capabilities
  (:external-buffer-properties-khr  :external-buffer-properties)
  ;; Provided by VK-KHR-external-memory-capabilities VK-KHR-external-semaphore-capabilities VK-KHR-external-fence-capabilities
  (:physical-device-id-properties-khr  :physical-device-id-properties)
  ;; Provided by VK-KHR-external-memory
  (:external-memory-buffer-create-info-khr  :external-memory-buffer-create-info)
  ;; Provided by VK-KHR-external-memory
  (:external-memory-image-create-info-khr  :external-memory-image-create-info)
  ;; Provided by VK-KHR-external-memory
  (:export-memory-allocate-info-khr  :export-memory-allocate-info)
  ;; Provided by VK-KHR-external-semaphore-capabilities
  (:physical-device-external-semaphore-info-khr  :physical-device-external-semaphore-info)
  ;; Provided by VK-KHR-external-semaphore-capabilities
  (:external-semaphore-properties-khr  :external-semaphore-properties)
  ;; Provided by VK-KHR-external-semaphore
  (:export-semaphore-create-info-khr  :export-semaphore-create-info)
  ;; Provided by VK-KHR-shader-float16-int8
  (:physical-device-shader-float16-int8-features-khr  :physical-device-shader-float16-int8-features)
  ;; Provided by VK-KHR-shader-float16-int8
  (:physical-device-float16-int8-features-khr  :physical-device-shader-float16-int8-features)
  ;; Provided by VK-KHR-16bit-storage
  (:physical-device-16bit-storage-features-khr  :physical-device-16bit-storage-features)
  ;; Provided by VK-KHR-descriptor-update-template
  (:descriptor-update-template-create-info-khr  :descriptor-update-template-create-info)
  (:surface-capabilities2-ext  :surface-capabilities-2-ext)
  ;; Provided by VK-KHR-imageless-framebuffer
  (:physical-device-imageless-framebuffer-features-khr  :physical-device-imageless-framebuffer-features)
  ;; Provided by VK-KHR-imageless-framebuffer
  (:framebuffer-attachments-create-info-khr  :framebuffer-attachments-create-info)
  ;; Provided by VK-KHR-imageless-framebuffer
  (:framebuffer-attachment-image-info-khr  :framebuffer-attachment-image-info)
  ;; Provided by VK-KHR-imageless-framebuffer
  (:render-pass-attachment-begin-info-khr  :render-pass-attachment-begin-info)
  ;; Provided by VK-KHR-create-renderpass2
  (:attachment-description-2-khr  :attachment-description-2)
  ;; Provided by VK-KHR-create-renderpass2
  (:attachment-reference-2-khr  :attachment-reference-2)
  ;; Provided by VK-KHR-create-renderpass2
  (:subpass-description-2-khr  :subpass-description-2)
  ;; Provided by VK-KHR-create-renderpass2
  (:subpass-dependency-2-khr  :subpass-dependency-2)
  ;; Provided by VK-KHR-create-renderpass2
  (:render-pass-create-info-2-khr  :render-pass-create-info-2)
  ;; Provided by VK-KHR-create-renderpass2
  (:subpass-begin-info-khr  :subpass-begin-info)
  ;; Provided by VK-KHR-create-renderpass2
  (:subpass-end-info-khr  :subpass-end-info)
  ;; Provided by VK-KHR-external-fence-capabilities
  (:physical-device-external-fence-info-khr  :physical-device-external-fence-info)
  ;; Provided by VK-KHR-external-fence-capabilities
  (:external-fence-properties-khr  :external-fence-properties)
  ;; Provided by VK-KHR-external-fence
  (:export-fence-create-info-khr  :export-fence-create-info)
  ;; Provided by VK-KHR-maintenance2
  (:physical-device-point-clipping-properties-khr  :physical-device-point-clipping-properties)
  ;; Provided by VK-KHR-maintenance2
  (:render-pass-input-attachment-aspect-create-info-khr  :render-pass-input-attachment-aspect-create-info)
  ;; Provided by VK-KHR-maintenance2
  (:image-view-usage-create-info-khr  :image-view-usage-create-info)
  ;; Provided by VK-KHR-maintenance2
  (:pipeline-tessellation-domain-origin-state-create-info-khr  :pipeline-tessellation-domain-origin-state-create-info)
  ;; Provided by VK-KHR-variable-pointers
  (:physical-device-variable-pointers-features-khr  :physical-device-variable-pointers-features)
  (:physical-device-variable-pointer-features-khr  :physical-device-variable-pointers-features-khr)
  ;; Provided by VK-KHR-dedicated-allocation
  (:memory-dedicated-requirements-khr  :memory-dedicated-requirements)
  ;; Provided by VK-KHR-dedicated-allocation
  (:memory-dedicated-allocate-info-khr  :memory-dedicated-allocate-info)
  ;; Provided by VK-EXT-sampler-filter-minmax
  (:physical-device-sampler-filter-minmax-properties-ext  :physical-device-sampler-filter-minmax-properties)
  ;; Provided by VK-EXT-sampler-filter-minmax
  (:sampler-reduction-mode-create-info-ext  :sampler-reduction-mode-create-info)
  ;; Provided by VK-KHR-get-memory-requirements2
  (:buffer-memory-requirements-info-2-khr  :buffer-memory-requirements-info-2)
  ;; Provided by VK-KHR-get-memory-requirements2
  (:image-memory-requirements-info-2-khr  :image-memory-requirements-info-2)
  ;; Provided by VK-KHR-get-memory-requirements2
  (:image-sparse-memory-requirements-info-2-khr  :image-sparse-memory-requirements-info-2)
  ;; Provided by VK-KHR-get-memory-requirements2
  (:memory-requirements-2-khr  :memory-requirements-2)
  ;; Provided by VK-KHR-get-memory-requirements2
  (:sparse-image-memory-requirements-2-khr  :sparse-image-memory-requirements-2)
  ;; Provided by VK-KHR-image-format-list
  (:image-format-list-create-info-khr  :image-format-list-create-info)
  ;; Provided by VK-KHR-sampler-ycbcr-conversion
  (:sampler-ycbcr-conversion-create-info-khr  :sampler-ycbcr-conversion-create-info)
  ;; Provided by VK-KHR-sampler-ycbcr-conversion
  (:sampler-ycbcr-conversion-info-khr  :sampler-ycbcr-conversion-info)
  ;; Provided by VK-KHR-sampler-ycbcr-conversion
  (:bind-image-plane-memory-info-khr  :bind-image-plane-memory-info)
  ;; Provided by VK-KHR-sampler-ycbcr-conversion
  (:image-plane-memory-requirements-info-khr  :image-plane-memory-requirements-info)
  ;; Provided by VK-KHR-sampler-ycbcr-conversion
  (:physical-device-sampler-ycbcr-conversion-features-khr  :physical-device-sampler-ycbcr-conversion-features)
  ;; Provided by VK-KHR-sampler-ycbcr-conversion
  (:sampler-ycbcr-conversion-image-format-properties-khr  :sampler-ycbcr-conversion-image-format-properties)
  ;; Provided by VK-KHR-bind-memory2
  (:bind-buffer-memory-info-khr  :bind-buffer-memory-info)
  ;; Provided by VK-KHR-bind-memory2
  (:bind-image-memory-info-khr  :bind-image-memory-info)
  ;; Provided by VK-EXT-descriptor-indexing
  (:descriptor-set-layout-binding-flags-create-info-ext  :descriptor-set-layout-binding-flags-create-info)
  ;; Provided by VK-EXT-descriptor-indexing
  (:physical-device-descriptor-indexing-features-ext  :physical-device-descriptor-indexing-features)
  ;; Provided by VK-EXT-descriptor-indexing
  (:physical-device-descriptor-indexing-properties-ext  :physical-device-descriptor-indexing-properties)
  ;; Provided by VK-EXT-descriptor-indexing
  (:descriptor-set-variable-descriptor-count-allocate-info-ext  :descriptor-set-variable-descriptor-count-allocate-info)
  ;; Provided by VK-EXT-descriptor-indexing
  (:descriptor-set-variable-descriptor-count-layout-support-ext  :descriptor-set-variable-descriptor-count-layout-support)
  ;; Provided by VK-NV-ray-tracing
  (:bind-acceleration-structure-memory-info-nv  :bind-acceleration-structure-memory-info-khr)
  ;; Provided by VK-NV-ray-tracing
  (:write-descriptor-set-acceleration-structure-nv  :write-descriptor-set-acceleration-structure-khr)
  ;; Provided by VK-KHR-maintenance3
  (:physical-device-maintenance-3-properties-khr  :physical-device-maintenance-3-properties)
  ;; Provided by VK-KHR-maintenance3
  (:descriptor-set-layout-support-khr  :descriptor-set-layout-support)
  ;; Provided by VK-KHR-shader-subgroup-extended-types
  (:physical-device-shader-subgroup-extended-types-features-khr  :physical-device-shader-subgroup-extended-types-features)
  ;; Provided by VK-KHR-8bit-storage
  (:physical-device-8bit-storage-features-khr  :physical-device-8bit-storage-features)
  ;; Provided by VK-KHR-shader-atomic-int64
  (:physical-device-shader-atomic-int64-features-khr  :physical-device-shader-atomic-int64-features)
  ;; Provided by VK-KHR-driver-properties
  (:physical-device-driver-properties-khr  :physical-device-driver-properties)
  ;; Provided by VK-KHR-shader-float-controls
  (:physical-device-float-controls-properties-khr  :physical-device-float-controls-properties)
  ;; Provided by VK-KHR-depth-stencil-resolve
  (:physical-device-depth-stencil-resolve-properties-khr  :physical-device-depth-stencil-resolve-properties)
  ;; Provided by VK-KHR-depth-stencil-resolve
  (:subpass-description-depth-stencil-resolve-khr  :subpass-description-depth-stencil-resolve)
  ;; Provided by VK-KHR-timeline-semaphore
  (:physical-device-timeline-semaphore-features-khr  :physical-device-timeline-semaphore-features)
  ;; Provided by VK-KHR-timeline-semaphore
  (:physical-device-timeline-semaphore-properties-khr  :physical-device-timeline-semaphore-properties)
  ;; Provided by VK-KHR-timeline-semaphore
  (:semaphore-type-create-info-khr  :semaphore-type-create-info)
  ;; Provided by VK-KHR-timeline-semaphore
  (:timeline-semaphore-submit-info-khr  :timeline-semaphore-submit-info)
  ;; Provided by VK-KHR-timeline-semaphore
  (:semaphore-wait-info-khr  :semaphore-wait-info)
  ;; Provided by VK-KHR-timeline-semaphore
  (:semaphore-signal-info-khr  :semaphore-signal-info)
  (:query-pool-create-info-intel  :query-pool-performance-query-create-info-intel)
  ;; Provided by VK-KHR-vulkan-memory-model
  (:physical-device-vulkan-memory-model-features-khr  :physical-device-vulkan-memory-model-features)
  ;; Provided by VK-EXT-scalar-block-layout
  (:physical-device-scalar-block-layout-features-ext  :physical-device-scalar-block-layout-features)
  ;; Provided by VK-KHR-separate-depth-stencil-layouts
  (:physical-device-separate-depth-stencil-layouts-features-khr  :physical-device-separate-depth-stencil-layouts-features)
  ;; Provided by VK-KHR-separate-depth-stencil-layouts
  (:attachment-reference-stencil-layout-khr  :attachment-reference-stencil-layout)
  ;; Provided by VK-KHR-separate-depth-stencil-layouts
  (:attachment-description-stencil-layout-khr  :attachment-description-stencil-layout)
  (:physical-device-buffer-address-features-ext  :physical-device-buffer-device-address-features-ext)
  ;; Provided by VK-EXT-buffer-device-address
  (:buffer-device-address-info-ext  :buffer-device-address-info)
  ;; Provided by VK-EXT-separate-stencil-usage
  (:image-stencil-usage-create-info-ext  :image-stencil-usage-create-info)
  ;; Provided by VK-KHR-uniform-buffer-standard-layout
  (:physical-device-uniform-buffer-standard-layout-features-khr  :physical-device-uniform-buffer-standard-layout-features)
  ;; Provided by VK-KHR-buffer-device-address
  (:physical-device-buffer-device-address-features-khr  :physical-device-buffer-device-address-features)
  ;; Provided by VK-KHR-buffer-device-address
  (:buffer-device-address-info-khr  :buffer-device-address-info)
  ;; Provided by VK-KHR-buffer-device-address
  (:buffer-opaque-capture-address-create-info-khr  :buffer-opaque-capture-address-create-info)
  ;; Provided by VK-KHR-buffer-device-address
  (:memory-opaque-capture-address-allocate-info-khr  :memory-opaque-capture-address-allocate-info)
  ;; Provided by VK-KHR-buffer-device-address
  (:device-memory-opaque-capture-address-info-khr  :device-memory-opaque-capture-address-info)
  ;; Provided by VK-EXT-host-query-reset
  (:physical-device-host-query-reset-features-ext  :physical-device-host-query-reset-features)
)

(defcstruct extent-2d
  (:width :uint32)
  (:height :uint32))

(defcstruct surface-capabilities
  (:min-image-count :uint32)
  (:max-image-count :uint32)
  (:current-extent (:struct extent-2d))
  (:min-image-extent (:struct extent-2d))
  (:max-image-extent (:struct extent-2d))
  (:max-image-array-layers :uint32)
  (:supported-transforms :uint32)
  (:current-transform :uint32)
  (:supported-composite-alpha :uint32)
  (:supported-usage-flags :uint32))

(defcstruct semaphore-create-info
  (:struct-info :uint32)
  (:next :pointer)
  (:flag :uint32))


(defun get-vulkan-dispatch-type ()
  (if (= 8 (foreign-type-size :pointer))
      :pointer
      :uint64))

(defcfun ("vkGetPhysicalDeviceSurfaceCapabilitiesKHR" get-physical-device-surface-capabilities-t) :uint32
  (physical-device vk-handle)
  (surface vk-handle)
  (capability vk-handle))

(defun get-physical-device-surface-capabilities (physical-device surface)
  (with-foreign-object (capability '(:struct surface-capabilities))
    (get-physical-device-surface-capabilities-t physical-device surface capability)
    (let* ((min-image-count (foreign-slot-value capability '(:struct surface-capabilities) :min-image-count))
	   (max-image-count (foreign-slot-value capability '(:struct surface-capabilities) :max-image-count))
	   (current-extent (foreign-slot-value capability '(:struct surface-capabilities) :current-extent))
	   (min-image-extent (foreign-slot-value capability '(:struct surface-capabilities) :min-image-extent))
	   (max-image-extent (foreign-slot-value capability '(:struct surface-capabilities) :max-image-extent))
	   (max-image-array-layers (foreign-slot-value capability '(:struct surface-capabilities) :max-image-array-layers))
	   (supported-transforms (foreign-slot-value capability '(:struct surface-capabilities) :supported-transforms))
	   (current-transform (foreign-slot-value capability '(:struct surface-capabilities) :current-transform))
	   (supported-composite-alpha (foreign-slot-value capability '(:struct surface-capabilities) :supported-composite-alpha))
	   (supported-usage-flags (foreign-slot-value capability '(:struct surface-capabilities) :supported-usage-flags)))
      (list :min-image-count min-image-count
	    :max-image-count max-image-count
	    :current-extent current-extent
	    :min-image-extent min-image-extent
	    :max-image-extent max-image-extent
	    :max-image-array-layers max-image-array-layers
	    :supported-transforms supported-transforms
	    :current-transform current-transform
	    :supported-composite-alpha supported-composite-alpha
	    :supported-usage-flags supported-usage-flags))))

(defun create-vulkan-surface-khr (win instance allocate)
  (let ((surface-type (get-vulkan-dispatch-type)))
    (with-foreign-object (surface surface-type)
      (foreign-funcall "glfwCreateWindowSurface"
		       :pointer instance
		       :pointer win
		       :pointer allocate
		       :pointer surface
		       :boolean)
      (mem-ref surface surface-type))))

(defmacro with-surface ((surface win instance) &body body)
  `(let ((,surface (create-vulkan-surface-khr ,win ,instance (null-pointer))))
     (progn
       ,@body
       (%vk:destroy-surface-khr ,instance ,surface (null-pointer)))))

(defun create-semaphore (logic-device)
  (let ((semaphore-type (get-vulkan-dispatch-type)))
    (with-foreign-objects ((create-info '(:struct semaphore-create-info) (semaphore semaphore-type)))
      (setf (foreign-slot-value create-info '(:struct semaphore-create-info) :struct-info) :semaphore-create-info
	    (foreign-slot-value create-info '(:struct semaphore-create-info) :next) (null-pointer)
	    (foreign-slot-value create-info '(:struct semaphore-create-info) :flag) 0)
      (foreign-funcall "vkCreateSemaphore"
		       logic-device ))))

(defcfun ("vkCreateSemaphore" create-semaphore) :uint32
  (device :pointer)
  (p-create-info (:pointer (:struct semaphore-create-info)))
  (p-allocator :pointer) 
  (p-semaphore (:pointer semaphore)))


(defun get-instance-extensions ()
  (with-foreign-object (count :uint32)
    (let* ((extensions (foreign-funcall "glfwGetRequiredInstanceExtensions"
					:pointer count
					:pointer))
	   (extensions-count (- (mem-ref count :uint32) 1)))
      (loop for i from 0 upto extensions-count
	    collect (mem-aref extensions :string i)))))

(defcfun ("glfwVulkanSupported" get-vulkan-support) :boolean
  "return true if vulkan is available")

(defcfun ("glfwGetPhysicalDevicePresentationSupport" queue-family-index-support-present-p) :uint64
  (instance vk-handle)
  (physical-device vk-handle)
  (index :uint32))
|#

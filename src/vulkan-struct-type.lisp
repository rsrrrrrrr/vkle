(in-package :vkle)

(defcstruct vk-basic-structure
  (:type VkStructureType)
  (:p-next (:pointer (:struct vk-basic-structure))))

(defcstruct vk-basic-out-structure
  (:type VkStructureType)
  (:p-next (:pointer (:struct vk-basic-structure))))

(defcstruct vk-off-set-2d
  (:x :uint32)
  (:y :uint32))

(defcstruct vk-off-set-3d
  (:x :uint32)
  (:y :uint32)
  (:z :uint32))

(defcstruct vk-extent-2d
  (:width :uint32)
  (:height :uint32))

(defcstruct vk-extent-3d
  (:width :uint32)
  (:height :uint32)
  (:depth :uint32))

(defcstruct vk-rect-2d
  (:offset (:struct vk-off-set-2d))
  (:extent (:struct vk-extent-2d)))

(defcstruct vk-application-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:app-name :string)
  (:app-version :uint32)
  (:engine-name :string)
  (:engine-version :uint32)
  (:api-version :uint32))

(defcstruct vk-instance-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags (vk-instance-create-flags))
  (:info (:pointer (:struct vk-application-info)))
  (:layer-count :uint32)
  (:layers (:pointer :string))
  (:extension-count :uint32)
  (:extensions (:pointer :string)))

(defcstruct vk-validation-flag-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:p-disable-validation-checks (:pointer VkValidationcheckext)))

(defcstruct vk-validation-features-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:enable-validation-feature-count :uint32)
  (:enable-validation-features (:pointer VkValidationFeatureEnableEXT))
  (:disable-validation-feature-count :uint32)
  (:disable-validation-features (:pointer VkValidationFeatureDisableEXT)))

(defcstruct vk-physical-device-limits
  (:max-image-dimension1-d :uint32)
  (:max-image-dimension2-d :uint32)
  (:max-image-dimension3-d :uint32)
  (:max-image-dimension-cube :uint32)
  (:max-image-array-layers :uint32)
  (:max-texel-buffer-elements :uint32)
  (:max-uniform-buffer-range :uint32)
  (:max-storage-buffer-range :uint32)
  (:max-push-constants-size :uint32)
  (:max-memory-allocation-count :uint32)
  (:max-sampler-allocation-count :uint32)
  (:buffer-image-granularity vk-device-size)
  (:sparse-address-space-size vk-device-size)
  (:max-bound-descriptor-sets :uint32)
  (:max-per-stage-descriptor-samplers :uint32)
  (:max-per-stage-descriptor-uniform-buffers :uint32)
  (:max-per-stage-descriptor-storage-buffers :uint32)
  (:max-per-stage-descriptor-sampled-images :uint32)
  (:max-per-stage-descriptor-storage-images :uint32)
  (:max-per-stage-descriptor-input-attachments :uint32)
  (:max-per-stage-resources :uint32)
  (:max-descriptor-set-samplers :uint32)
  (:max-descriptor-set-uniform-buffers :uint32)
  (:max-descriptor-set-uniform-buffers-dynamic :uint32)
  (:max-descriptor-set-storage-buffers :uint32)
  (:max-descriptor-set-storage-buffers-dynamic :uint32)
  (:max-descriptor-set-sampled-images :uint32)
  (:max-descriptor-set-storage-images :uint32)
  (:max-descriptor-set-input-attachments :uint32)
  (:max-vertex-input-attributes :uint32)
  (:max-vertex-input-bindings :uint32)
  (:max-vertex-input-attribute-offset :uint32)
  (:max-vertex-input-binding-stride :uint32)
  (:max-vertex-output-components :uint32)
  (:max-tessellation-generation-level :uint32)
  (:max-tessellation-patch-size :uint32)
  (:max-tessellation-control-per-vertex-input-components :uint32)
  (:max-tessellation-control-per-vertex-output-components :uint32)
  (:max-tessellation-control-per-patch-output-components :uint32)
  (:max-tessellation-control-total-output-components :uint32)
  (:max-tessellation-evaluation-input-components :uint32)
  (:max-tessellation-evaluation-output-components :uint32)
  (:max-geometry-shader-invocations :uint32)
  (:max-geometry-input-components :uint32)
  (:max-geometry-output-components :uint32)
  (:max-geometry-output-vertices :uint32)
  (:max-geometry-total-output-components :uint32)
  (:max-fragment-input-components :uint32)
  (:max-fragment-output-attachments :uint32)
  (:max-fragment-dual-src-attachments :uint32)
  (:max-fragment-combined-output-resources :uint32)
  (:max-compute-shared-memory-size :uint32)
  (:max-compute-work-group-count (:pointer :uint32))
  (:max-compute-work-group-invocations :uint32)
  (:max-compute-work-group-size (:pointer :uint32))
  (:sub-pixel-precision-bits :uint32)
  (:sub-texel-precision-bits :uint32)
  (:mipmap-precision-bits :uint32)
  (:max-draw-indexed-index-value :uint32)
  (:max-draw-indirect-count :uint32)
  (:max-sampler-lod-bias :float)
  (:max-sampler-anisotropy :float)
  (:max-viewports :uint32)
  (:max-viewport-dimensions (:pointer :uint32))
  (:viewport-bounds-range (:pointer :float))
  (:viewport-sub-pixel-bits :uint32)
  (:min-memory-map-alignment :uint32)
  (:min-texel-buffer-offset-alignment vk-device-size)
  (:min-uniform-buffer-offset-alignment vk-device-size)
  (:min-storage-buffer-offset-alignment vk-device-size)
  (:min-texel-offset :int32)
  (:max-texel-offset :uint32)
  (:min-texel-gather-offset :int32)
  (:max-texel-gather-offset :uint32)
  (:min-interpolation-offset :float)
  (:max-interpolation-offset :float)
  (:sub-pixel-interpolation-offset-bits :uint32)
  (:max-framebuffer-width :uint32)
  (:max-framebuffer-height :uint32)
  (:max-framebuffer-layers :uint32)
  (:framebuffer-color-sample-counts vk-sample-count-flags)
  (:framebuffer-depth-sample-counts vk-sample-count-flags)
  (:framebuffer-stencil-sample-counts vk-sample-count-flags)
  (:framebuffer-no-attachments-sample-counts vk-sample-count-flags)
  (:max-color-attachments :uint32)
  (:sampled-image-color-sample-counts vk-sample-count-flags)
  (:sampled-image-integer-sample-counts vk-sample-count-flags)
  (:sampled-image-depth-sample-counts vk-sample-count-flags)
  (:sampled-image-stencil-sample-counts vk-sample-count-flags)
  (:storage-image-sample-counts vk-sample-count-flags)
  (:max-sample-mask-words :uint32)
  (:timestamp-compute-and-graphics vk-bool-32)
  (:timestamp-period :float)
  (:max-clip-distances :uint32)
  (:max-cull-distances :uint32)
  (:max-combined-clip-and-cull-distances :uint32)
  (:discrete-queue-priorities :uint32)
  (:point-size-range (:pointer :float))
  (:line-width-range (:pointer :float))
  (:point-size-granularity :float)
  (:line-width-granularity :float)
  (:strict-lines vk-bool-32)
  (:standard-sample-locations vk-bool-32)
  (:optimal-buffer-copy-offset-alignment vk-device-size)
  (:optimal-buffer-copy-row-pitch-alignment vk-device-size)
  (:non-coherent-atom-size vk-device-size))

(defcstruct vk-physical-device-sparse-properties
  (:residency-standard2-d-block-shape vk-bool-32)
  (:residency-standard2-d-multisample-block-shape vk-bool-32)
  (:residency-standard3-d-block-shape vk-bool-32)
  (:residency-aligned-mip-size vk-bool-32)
  (:residency-non-resident-strict vk-bool-32))

(defcstruct vk-physical-device-properties
  (:api-version :uint32)
  (:driver-version :uint32)
  (:vendor-id :uint32)
  (:device-id :uint32)
  (:device-type VkPhysicalDeviceType)
  (:device-name :string)
  (:pipeline-cache-uuid (:pointer :uint8))
  (:limits  (:struct vk-physical-device-limits))
  (:spare-properties (:struct vk-physical-device-sparse-properties)))

(defcstruct vk-physical-device-properties-2
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:properties (:struct vk-physical-device-properties)))

(defcstruct vk-physical-device-vulkan-11-properties
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:device-uuid (:pointer :uint8))
  (:driver-uuid (:pointer :uint8))
  (:driver-luid (:pointer :uint8))
  (:device-node-mask :uint32)
  (:device-luid-vaild vk-bool-32)
  (:sub-group-size :uint32)
  (:sub-group-supported-stages VkShaderStageflagbits)
  (:sub-group-supported-operations VkSubgroupfeatureflagbits)
  (:sub-group-quad-operations-in-all-stage vk-bool-32)
  (:point-clipping-behavior VkPointclippingbehavior)
  (:max-multiview-view-count :uint32)
  (:max-multiview-instance-index :uint32)
  (:protected-no-fault vk-bool-32)
  (:max-per-set-descriptors :uint32)
  (:max-memory-allocation-size vk-device-size))

(defcstruct vk-conformance-version
  (:major :uint8)
  (:minor :uint8)
  (:subminor :uint8)
  (:patch :uint8))

(defcstruct vk-physical-device-vulkan-12-properties
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:driver-id VkDriverId)
  (:driver-name :string)
  (:driver-info :string)
  (:conformance-version (:struct vk-conformance-version))
  (:denorm-behavior-independence vkshaderfloatcontrolsindependence)
  (:rounding-mode-independence vkshaderfloatcontrolsindependence)
  (:shader-signed-zero-inf-nan-preserve-float16 vk-bool-32)
  (:shader-signed-zero-inf-nan-preserve-float32 vk-bool-32)
  (:shader-signed-zero-inf-nan-preserve-float64 vk-bool-32)
  (:shader-denorm-preserve-float16 vk-bool-32)
  (:shader-denorm-preserve-float32 vk-bool-32)
  (:shader-denorm-preserve-float64 vk-bool-32)
  (:shader-denorm-flush-to-zero-float16 vk-bool-32)
  (:shader-denorm-flush-to-zero-float32 vk-bool-32)
  (:shader-denorm-flush-to-zero-float64 vk-bool-32)
  (:shader-rounding-mode-r-t-e-float16 vk-bool-32)
  (:shader-rounding-mode-r-t-e-float32 vk-bool-32)
  (:shader-rounding-mode-r-t-e-float64 vk-bool-32)
  (:shader-rounding-mode-r-t-z-float16 vk-bool-32)
  (:shader-rounding-mode-r-t-z-float32 vk-bool-32)
  (:shader-rounding-mode-r-t-z-float64 vk-bool-32)
  (:max-update-after-bind-descriptors-in-all-pools :uint32)
  (:shader-uniform-buffer-array-non-uniform-indexing-native vk-bool-32)
  (:shader-sampled-image-array-non-uniform-indexing-native vk-bool-32)
  (:shader-storage-buffer-array-non-uniform-indexing-native vk-bool-32)
  (:shader-storage-image-array-non-uniform-indexing-native vk-bool-32)
  (:shader-input-attachment-array-non-uniform-indexing-native vk-bool-32)
  (:robust-buffer-access-update-after-bind vk-bool-32)
  (:quad-divergent-implicit-lod vk-bool-32)
  (:max-per-stage-descriptor-update-after-bind-samplers :uint32)
  (:max-per-stage-descriptor-update-after-bind-uniform-buffers :uint32)
  (:max-per-stage-descriptor-update-after-bind-storage-buffers :uint32)
  (:max-per-stage-descriptor-update-after-bind-sampled-images :uint32)
  (:max-per-stage-descriptor-update-after-bind-storage-images :uint32)
  (:max-per-stage-descriptor-update-after-bind-input-attachments :uint32)
  (:max-per-stage-update-after-bind-resources :uint32)
  (:max-descriptor-set-update-after-bind-samplers :uint32)
  (:max-descriptor-set-update-after-bind-uniform-buffers :uint32)
  (:max-descriptor-set-update-after-bind-uniform-buffers-dynamic :uint32)
  (:max-descriptor-set-update-after-bind-storage-buffers :uint32)
  (:max-descriptor-set-update-after-bind-storage-buffers-dynamic :uint32)
  (:max-descriptor-set-update-after-bind-sampled-images :uint32)
  (:max-descriptor-set-update-after-bind-storage-images :uint32)
  (:max-descriptor-set-update-after-bind-input-attachments :uint32)
  (:supported-depth-resolve-modes vk-reslove-mode-flags)
  (:supported-stencil-resolve-modes vk-reslove-mode-flags)
  (:independent-resolve-none vk-bool-32)
  (:independent-resolve vk-bool-32)
  (:filter-minmax-single-component-formats vk-bool-32)
  (:filter-minmax-image-component-mapping vk-bool-32)
  (:max-timeline-semaphore-value-difference :uint64)
  (:framebuffer-integer-color-sample-counts vk-sample-count-flags))

(defcstruct vk-physical-device-id-properties
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:device-uuid (:pointer :uint8))
  (:driver-uuid (:pointer :uint8))
  (:device-luid (:pointer :uint8))
  (:device-node-mask :uint32)
  (:device-luid-vaild vk-bool-32))

(defcstruct vk-physical-device-driver-properties
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:driver-id VkDriverid)
  (:driver-name :string)
  (:driver-info :string)
  (:conformance-version (:struct vk-conformance-version)))

(defcstruct vk-physical-device-pci-bus-info-properties-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:pci-domain :uint32)
  (:pci-bus :uint32)
  (:pci-device :uint32)
  (:pci-function :uint32))

(defcstruct vk-queue-family-properties
  (:queue-flags vk-queue-flags)
  (:queue-count :uint32)
  (:timestamp-valid-bits :uint32)
  (:min-image-transfer-granularity (:struct vk-extent-3d)))

(defcstruct vk-queue-family-properties-2
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:queue-family-properties (:struct vk-queue-family-properties)))

(defcstruct vk-queue-family-checkpoint-properties-nv
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:checkpoint-execution-stage-mask vk-pipline-stage-flags))

(defcstruct vk-performance-counter-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:unit VkPerformanceCounterunitkhr)
  (:scope VkPerformanceCounterscopekhr)
  (:storage VkPerformanceCounterStoragekhr)
  (:uuid (:pointer :uint8)))

(defcstruct vk-performance-counter-description-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-performance-counter-description-flags-khr)
  (:name :string)
  (:category :string)
  (:description :string))

(defcstruct vk-device-queue-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-device-queue-create-flags)
  (:queue-family-index :uint32)
  (:queue-count :uint32)
  (:p-queue-properties (:pointer :float)))

(defcstruct vk-physical-device-features
  (:robust-buffer-access vk-bool-32)
  (:full-draw-index-uint32 vk-bool-32)
  (:image-cube-array vk-bool-32)
  (:independent-blend vk-bool-32)
  (:geometry-shader vk-bool-32)
  (:tessellation-shader vk-bool-32)
  (:sample-rate-shading vk-bool-32)
  (:dual-src-blend vk-bool-32)
  (:logic-op vk-bool-32)
  (:multi-draw-indirect vk-bool-32)
  (:draw-indirect-first-instance vk-bool-32)
  (:depth-clamp vk-bool-32)
  (:depth-bias-clamp vk-bool-32)
  (:fill-mode-non-solid vk-bool-32)
  (:depth-bounds vk-bool-32)
  (:wide-lines vk-bool-32)
  (:large-points vk-bool-32)
  (:alpha-to-one vk-bool-32)
  (:multi-viewport vk-bool-32)
  (:sampler-anisotropy vk-bool-32)
  (:texture-compression-e-t-c2 vk-bool-32)
  (:texture-compression-a-s-t-c_-l-d-r vk-bool-32)
  (:texture-compression-b-c vk-bool-32)
  (:occlusion-query-precise vk-bool-32)
  (:pipeline-statistics-query vk-bool-32)
  (:vertex-pipeline-stores-and-atomics vk-bool-32)
  (:fragment-stores-and-atomics vk-bool-32)
  (:shader-tessellation-and-geometry-point-size vk-bool-32)
  (:shader-image-gather-extended vk-bool-32)
  (:shader-storage-image-extended-formats vk-bool-32)
  (:shader-storage-image-multisample vk-bool-32)
  (:shader-storage-image-read-without-format vk-bool-32)
  (:shader-storage-image-write-without-format vk-bool-32)
  (:shader-uniform-buffer-array-dynamic-indexing vk-bool-32)
  (:shader-sampled-image-array-dynamic-indexing vk-bool-32)
  (:shader-storage-buffer-array-dynamic-indexing vk-bool-32)
  (:shader-storage-image-array-dynamic-indexing vk-bool-32)
  (:shader-clip-distance vk-bool-32)
  (:shader-cull-distance vk-bool-32)
  (:shader-float64 vk-bool-32)
  (:shader-int64 vk-bool-32)
  (:shader-int16 vk-bool-32)
  (:shader-resource-residency vk-bool-32)
  (:shader-resource-min-lod vk-bool-32)
  (:sparse-binding vk-bool-32)
  (:sparse-residency-buffer vk-bool-32)
  (:sparse-residency-image2-d vk-bool-32)
  (:sparse-residency-image3-d vk-bool-32)
  (:sparse-residency2-samples vk-bool-32)
  (:sparse-residency4-samples vk-bool-32)
  (:sparse-residency8-samples vk-bool-32)
  (:sparse-residency16-samples vk-bool-32)
  (:sparse-residency-aliased vk-bool-32)
  (:variable-multisample-rate vk-bool-32)
  (:inherited-queries vk-bool-32))

(defcstruct vk-device-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-device-create-flags)
  (:queue-create-info-counter :uint32)
  (:p-queue-create-info (:pointer (:struct vk-device-queue-create-info)))
  (:layer-count :uint32)
  (:layers (:pointer :string))
  (:extension-count :uint32)
  (:extensions (:pointer :string))
  (:enable-features (:pointer (:struct vk-physical-device-features))))

(defcstruct vk-device-group-device-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:physical-device-count :uint32)
  (:physical-device (:pointer vk-physical-device)))

(defcstruct vk-device-memory-overallocation-create-info-amd
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:overallocation-behavior VkMemoryOverallocationbehavioramd))

(defcstruct vk-device-diagnostics-config-create-info-nv
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-device-diagnostics-config-flags-nv))

(defcstruct vk-device-private-data-create-info-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:private-data-slot-request-count :uint32))

(defcstruct vk-device-queue-global-priority-create-info-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:global-priority VkQueueGlobalPriorityExt))

(defcstruct vk-device-queue-info-2
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-device-queue-create-flags)
  (:queue-family-index :uint32)
  (:queue-index :uint32))

(defcstruct vk-command-pool-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-command-pool-create-flags)
  (:queue-family-index :uint32))

(defcstruct vk-command-buffer-allocate-infp
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:command-pool vk-command-pool)
  (:level VKCommandbufferlevel)
  (:command-buffer-count :uint32))

(defcstruct vk-command-buffer-inheritance-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:render-pass vk-render-pass)
  (:sub-pass :uint32)
  (:framebuffer vk-framebuffer)
  (:occlusion-query-enable vk-bool-32)
  (:flags vk-query-control-flags)
  (:pipeline-statistics vk-query-pipeline-statistic-flags))

(defcstruct vk-command-buffer-begin-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-command-buffer-usage-flags)
  (:inheritance-info (:pointer (:struct vk-command-buffer-inheritance-info))))

(defcstruct vk-command-buffer-inheritance-conditional-rendering-info-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:conditional-rendering-enable vk-bool-32))

(defcstruct vk-command-buffer-inheritance-render-pass-transform-info-qcom
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:transform VkSurfaceTransformflagbitskhr)
  (:render-area (:struct vk-rect-2d)))

(defcstruct vk-submit-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:wait-semaphore-count :uint32)
  (:wait-semaphore (:pointer vk-semaphore))
  (:wait-dst-stage-mask (:pointer vk-pipline-stage-flags))
  (:command-buffer-count :uint32)
  (:command-buffer (:pointer vk-command-buffer))
  (:signal-semaphore-count :uint32)
  (:signal-semaphore (:pointer vk-semaphore)))

(defcstruct vk-timeline-semaphore-submit-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:wait-semaphore-value-count :uint32)
  (:wait-semaphore-values (:pointer :uint64))
  (:signal-semaphore-count :uint32)
  (:signal-semaphore-values (:pointer :uint64)))

(defcstruct vk-d3d12-fence-submit-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:wait-semaphore-value-count :uint32)
  (:wait-semaphore-values (:pointer :uint64))
  (:signal-semaphore-count :uint32)
  (:signal-semaphore-values (:pointer :uint64)))

(defcstruct vk-win32-keyed-mutex-acquire-release-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:acquire-count :uint32)
  (:acquire-syncs vk-device-memory)
  (:acquire-keys (:pointer :uint64))
  (:acquire-timeout (:pointer :uint32))
  (:release-count :uint32)
  (:release-syncs (:pointer vk-device-memory))
  (:release-keys (:pointer :uint64)))

(defcstruct vk-win32-keyed-mutex-acquire-release-info-nv
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:acquire-count :uint32)
  (:acquire-syncs vk-device-memory)
  (:acquire-keys (:pointer :uint64))
  (:acquire-timeout (:pointer :uint32))
  (:release-count :uint32)
  (:release-syncs (:pointer vk-device-memory))
  (:release-keys (:pointer :uint64)))

(defcstruct vk-protected-submit-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:protected-submit vk-bool-32))

(defcstruct vk-device-group-submit-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:wait-semaphore-count :uint32)
  (:wait-semaphore-device-indices (:pointer :uint32))
  (:command-buffer-count :uint32)
  (:command-buffer-device-masks (:pointer :uint32))
  (:signal-semaphore-count :uint32)
  (:signal-semaphore-device-indices (:pointer :uint32)))

(defcstruct vk-performance-query-submit-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:count-pass-index :uint32))

(defcstruct vk-device-group-command-buffer-begin-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:device-mask :uint32))

(defcstruct vk-fence-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-fence-create-flags))

(defcstruct vk-export-fence-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-external-fence-handle-type-flags))

;;in windows 
(defcstruct security-attributes
  (:length :uint32)
  (:lp-void (:pointer :void))
  (:bool :int32))

(defcstruct vk-export-fence-win32-handle-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:attributes (:pointer (:struct security-attributes)))
  (:dw-access :uint32)
  (:name (:pointer :uint16)))

(defcstruct vk-fence-get-win32-handle-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:fence vk-fence)
  (:handle-type VkExternalFenceHandleTypeFlagBits))
;;end windows

(defcstruct vk-fence-get-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:fence vk-fence)
  (:handle-type VkExternalFenceHandleTypeFlagBits))

(defcstruct vk-device-event-info-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:device-event VkDeviceEventTypeExt))

(defcstruct vk-display-event-info-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:display-event VkDisplayEventTypeExt))

(defcstruct vk-import-fence-win32-handle-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:fence vk-fence)
  (:flags vk-fence-import-flags)
  (:handle-type VkExternalFenceFeatureFlagBits)
  (:handle (:pointer :void))
  (:name (:pointer :uint16)))

(defcstruct vk-import-fence-fd-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:fence vk-fence)
  (:flags vk-fence-import-flags)
  (:handle-type VkExternalFenceFeatureFlagBits)
  (:fd :int))

(defcstruct vk-semaphore-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-semaphore-create-flags))

(defcstruct vk-semaphore-type-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:semaphore-type VkSemaphoreType)
  (:initial-value :uint64))

(defcstruct vk-export-semaphore-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:handle-type vk-external-semaphore-handle-type-flags))

(defcstruct vk-export-semaphore-win32-handle-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:attributes (:pointer (:struct security-attributes)))
  (:dw-access :uint32)
  (:name (:pointer :uint16)))

(defcstruct vk-semaphore-get-win32-handle-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:semaphore vk-semaphore)
  (:handle-type VkExternalSemaphoreHandleTypeFlagbits))

(defcstruct vk-semaphore-get-fd-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:semaphore vk-semaphore)
  (:handle-type VkExternalSemaphoreHandleTypeFlagbits))

(defcstruct vk-semaphore-wait-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-semaphore-wait-flags)
  (:semaphore-count :uint32)
  (:semaphores (:pointer vk-semaphore))
  (:value (:pointer :uint64)))

(defcstruct vk-semaphore-signal-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:semaphore vk-semaphore)
  (:value :uint64))

(defcstruct vk-import-semaphore-win32-handle-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:semaphore vk-semaphore)
  (:flags vk-semaphore-import-flags)
  (:handle-type VkExternalSemaphoreHandleTypeFlagBits)
  (:handle (:pointer :void))
  (:name (:pointer :uint16)))

(defcstruct vk-import-semaphore-fd-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:semaphore vk-semaphore)
  (:flags vk-semaphore-import-flags)
  (:handle-type VkExternalSemaphoreHandleTypeFlagBits)
  (:fd :int))

(defcstruct vk-event-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-event-create-flags))

(defcstruct vk-memory-barrier
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:src-access-mask vk-access-flags)
  (:dst-access-mask vk-access-flags))

(defcstruct vk-buffer-memory-barrier
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:src-access-mask vk-access-flags)
  (:dst-access-mask vk-access-flags)
  (:src-queue-family-index :uint32)
  (:dst-queue-family-index :uint32)
  (:buffer vk-buffer)
  (:offset vk-device-size)
  (:size vk-device-size))

(defcstruct vk-image-subresource-range
  (:aspect-mask vk-image-aspect-flags)
  (:base-mip-level :uint32)
  (:level-count :uint32)
  (:base-array-layer :uint32)
  (:layer-count :uint32))

(defcstruct vk-buffer-memory-barrier
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:src-access-mask vk-access-flags)
  (:dst-access-mask vk-access-flags)
  (:old-layout VkImageLayout)
  (:new-layout VkImageLayout)
  (:src-queue-family-index :uint32)
  (:dst-queue-family-index :uint32)
  (:image vk-image)
  (:sub-resource-range (:struct vk-image-subresource-range)))

(defcstruct vk-calibrated-timestamp-info-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:time-domain VkTimedomainext))

(defcstruct vk-attachment-description
  (:flags vk-attachment-description-flags)
  (:format VkFormat)
  (:samples VkSampleCountFlagbits)
  (:load-op VkAttachmentLoadop)
  (:store-op VkAttachmentStoreop)
  (:stencil-load-op VkAttachmentLoadop)
  (:stencil-store-op VkAttachmentStoreop)
  (:initial-layout VkImageLayout)
  (:final-layout VkImageLayout))

(defcstruct vk-attachment-reference
  (:attachment :uint32)
  (:layout VkImageLayout))

(defcstruct vk-subpass-description
  (:flags vk-subpass-description-flags)
  (:pipeline-bind-point VkPipelineBindpoint)
  (:input-attachment-cout :uint32)
  (:input-attachment (:pointer (:struct vk-attachment-reference)))
  (:color-attachment-count :uint32)
  (:color-attachments (:pointer (:struct vk-attachment-reference)))
  (:reslove-attachments (:pointer (:struct vk-attachment-reference)))
  (:depth-stencil-attachments (:pointer (:struct vk-attachment-reference)))
  (:reserve-attachment-count :uint32)
  (:preserve-attachments (:pointer :uint32)))

(defcstruct vk-subpass-dependency
  (:src-subpass :uint32)
  (:dst-subpass :uint32)
  (:src-stage-mask vk-pipline-stage-flags)
  (:dst-stage-mask vk-pipline-stage-flags)
  (:src-access-mask vk-access-flags)
  (:dst-access-mask vk-access-flags)
  (:dependency-flags vk-dependency-flags))

(defcstruct vk-render-pass-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-render-pass-create-flags)
  (:attachment-count :uint32)
  (:attachment (:pointer (:struct vk-attachment-description)))
  (:subpass-count :uint32)
  (:subpasses (:pointer (:struct vk-subpass-description)))
  (:dependency-count :uint32)
  (:dependenies (:pointer (:struct vk-subpass-dependency))))

(defcstruct vk-render-pass-multiview-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:subpass-count :uint32)
  (:view-mask (:pointer :uint32))
  (:dependency-count :uint32)
  (:view-offsets (:pointer :uint32))
  (:correlation-mask-count :uint32)
  (:correlation-mask (:pointer :uint32)))

(defcstruct vk-render-pass-fragment-density-map-create-info-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:fragment-density-map-attachment (:struct vk-attachment-reference)))

(defcstruct vk-input-attachment-aspect-reference
  (:subpass :uint32)
  (:input-attachment-index :uint32)
  (:aspect-mask vk-image-aspect-flags))

(defcstruct vk-render-pass-input-attachment-aspect-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:aspect-reference-count :uint32)
  (:aspect-reference (:pointer (:struct vk-input-attachment-aspect-reference))))

(defcstruct vk-attachment-description-2
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-attachment-description-flags)
  (:format VkFormat)
  (:samples VkSampleCountFlagbits)
  (:load-op VkAttachmentLoadop)
  (:store-op VkAttachmentStoreop)
  (:stencil-load-op VkAttachmentLoadop)
  (:stencil-store-op VkAttachmentStoreop)
  (:initial-layout VkImageLayout)
  (:final-layout VkImageLayout))

(defcstruct vk-attachment-reference-2
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:attachment :uint32)
  (:layout VkImageLayout)
  (:aspect-mask vk-image-aspect-flags))

(defcstruct vk-subpass-description-2
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-subpass-description-flags)
  (:pipeline-bind-point VkPipelineBindpoint)
  (:view-mask :uint32)
  (:input-attachment-cout :uint32)
  (:input-attachment (:pointer (:struct vk-attachment-reference-2)))
  (:color-attachment-count :uint32)
  (:color-attachments (:pointer (:struct vk-attachment-reference-2)))
  (:reslove-attachments (:pointer (:struct vk-attachment-reference-2)))
  (:depth-stencil-attachments (:pointer (:struct vk-attachment-reference-2)))
  (:reserve-attachment-count :uint32)
  (:preserve-attachments (:pointer :uint32)))

(defcstruct vk-subpass-dependency-2
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:src-subpass :uint32)
  (:dst-subpass :uint32)
  (:src-stage-mask vk-pipline-stage-flags)
  (:dst-stage-mask vk-pipline-stage-flags)
  (:src-access-mask vk-access-flags)
  (:dst-access-mask vk-access-flags)
  (:dependency-flags vk-dependency-flags)
  (:view-offset :uint32))

(defcstruct vk-render-pass-create-info-2
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-render-pass-create-flags)
  (:attachment-count :uint32)
  (:attachment (:pointer (:struct vk-attachment-description-2)))
  (:subpass-count :uint32)
  (:subpasses (:pointer (:struct vk-subpass-description-2)))
  (:dependency-count :uint32)
  (:dependenies (:pointer (:struct vk-subpass-dependency-2)))
  (:correlate-view-mask-count :uint32)
  (:correlated-view-masks (:pointer :uint32)))

(defcstruct vk-attachment-description-stenci-layout
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:stencil-initial-layout VkImageLayout)
  (:stencil-final-layout VkImageLayout))

(defcstruct vk-subpass-description-depth-stencil-reslove
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:depth-reslove-mode VkResolveModeFlagbits)
  (:stencil-reslove-mode VkResolveModeFlagbits)
  (:depth-stencil-resolve-attachment (:struct vk-attachment-reference-2)))

(defcstruct vk-attachment-reference-stencil-layout
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:stencil-layout VkImageLayout))

(defcstruct vk-framebuffer-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-framebuffer-create-flags)
  (:render-pass vk-render-pass)
  (:attachment-count :uint32)
  (:attachments (:pointer vk-image-view))
  (:width :uint32)
  (:height :uint32)
  (:layers :uint32))

(defcstruct vk-framebuffer-attachment-image-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-image-create-flags)
  (:usage vk-image-usage-flags)
  (:width :uint32)
  (:height :uint32)
  (:layer-count :uint32)
  (:voew-format-count :uint32)
  (:view-formats (:pointer VkFormat)))

(defcstruct vk-framebuffer-attachments-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:attachment-image-info-count :uint32)
  (:attachment-image-infos (:pointer (:struct vk-framebuffer-attachment-image-info))))

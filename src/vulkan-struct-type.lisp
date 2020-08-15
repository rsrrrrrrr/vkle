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
  (:min-memory-map-alignment :unsigned-int)
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
  (:device-name :char :count 256)
  (:pipeline-cache-uuid :uint8 :count 16)
  (:limits  (:struct vk-physical-device-limits))
  (:spare-properties (:struct vk-physical-device-sparse-properties)))

(defcstruct vk-physical-device-properties-2
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:properties (:struct vk-physical-device-properties)))

(defcstruct vk-physical-device-vulkan-11-properties
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:device-uuid :uint8 :count 16)
  (:driver-uuid :uint8 :count 16)
  (:driver-luid :uint8 :count 16)
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
  (:driver-name :char :count 256)
  (:driver-info :char :count 256)
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
  (:device-uuid :uint8 :count 16)
  (:driver-uuid :uint8 :count 16)
  (:device-luid :uint8 :count 16)
  (:device-node-mask :uint32)
  (:device-luid-vaild vk-bool-32))

(defcstruct vk-physical-device-driver-properties
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:driver-id VkDriverid)
  (:driver-name :char :count 256)
  (:driver-info :char :count 256)
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
  (:checkpoint-execution-stage-mask vk-pipeline-stage-flags))

(defcstruct vk-performance-counter-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:unit VkPerformanceCounterunitkhr)
  (:scope VkPerformanceCounterscopekhr)
  (:storage VkPerformanceCounterStoragekhr)
  (:uuid :uint8 :count 16))

(defcstruct vk-performance-counter-description-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-performance-counter-description-flags-khr)
  (:name :char :count 256)
  (:category :char :count 256)
  (:description :char :count 256))

(defcstruct vk-physical-device-group-properties
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:physical-device-count :uint32)
  (:physical-devices vk-physical-device :count 32)
  (:subset-allocation vk-bool-32))

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
  (:wait-dst-stage-mask (:pointer vk-pipeline-stage-flags))
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
  (:src-stage-mask vk-pipeline-stage-flags)
  (:dst-stage-mask vk-pipeline-stage-flags)
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
  (:src-stage-mask vk-pipeline-stage-flags)
  (:dst-stage-mask vk-pipeline-stage-flags)
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

(defcunion vk-clear-color-value
  (:f32 (:pointer :float))
  (:i32 (:pointer :int32))
  (:ui32 (:pointer :uint32)))

(defcstruct vk-clear-depth-stencil-value
  (:depth :float)
  (:stencil :uint32))

(defcunion vk-clear-value
  (:color (:union vk-clear-color-value))
  (:depth-stencil (:struct vk-clear-depth-stencil-value)))

(defcstruct vk-render-pass-begin-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:render-pass vk-render-pass)
  (:framebuffer vk-framebuffer)
  (:render-area (:struct vk-rect-2d))
  (:clear-value-count :uint32)
  (:clear-values (:pointer (:union vk-clear-value))))

(defcstruct vk-sample-location-ext
  (:x :float)
  (:y :float))

(defcstruct vk-sample-locations-info-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:sample-locations-per-pixel VkSampleCountFlagbits)
  (:sample-location-grid-size (:struct vk-extent-2d))
  (:sample-locations-count :uint32)
  (:sample-locations (:pointer (:struct vk-sample-location-ext))))

(defcstruct vk-attachment-sample-locations-ext
  (:attachment-index :uint32)
  (:sample-locations-info (:struct vk-sample-locations-info-ext)))

(defcstruct vk-subpass-sample-locations-ext
  (:subpass-index :uint32)
  (:sample-location-info (:struct vk-sample-locations-info-ext)))

(defcstruct vk-render-pass-sample-locations-begin-info-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:attachment-initial-sample-locations-count :uint32)
  (:attachment-initial-sample-locations (:pointer (:struct vk-attachment-sample-locations-ext)))
  (:post-subpass-sample-locations-count :uint32)
  (:post-subpass-sample-locations (:struct vk-subpass-sample-locations-ext)))

(defcstruct vk-render-pass-transform-begin-info-qcom
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:transform VkSurfaceTransformFlagbitsKHR))

(defcstruct vk-subpass-begin-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:contents VkSubpassContents))

(defcstruct vk-device-group-render-pass-begin-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:device-mask :uint32)
  (:device-render-area-count :uint32)
  (:device-render-areas (:pointer (:struct vk-rect-2d))))

(defcstruct vk-render-pass-attachment-begin-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:attachment-count :uint32)
  (:attachment (:pointer vk-image-view)))

(defcstruct vk-subpass-end-info
  (:type VkStructureType)
  (:p-next (:pointer :void)))

(defcstruct vk-shader-module-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-module-create-flags)
  (:code-size :unsigned-int)
  (:code :uint32))

(defcstruct vk-shader-module-validation-cache-create-info-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:validation-cache vk-validation-cache-ext))

(defcstruct vk-cooperative-matrix-properties-nv
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:m-size :uint32)
  (:n-size :uint32)
  (:k-size :uint32)
  (:a-type VkComponentTypeNV)
  (:b-type VkComponentTypeNV)
  (:c-type VkComponentTypeNV)
  (:d-type VkComponentTypeNV)
  (:scope VkScopeNV))

(defcstruct vk-validation-cache-create-info-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-validation-cache-create-flags-ext)
  (:initial-data-size :unsigned-int)
  (:initial-data (:pointer :void)))

(defcstruct vk-specialization-map-entry
  (:constant-id :uint32)
  (:offset :uint32)
  (:size :unsigned-int))

(defcstruct vk-specialization-info
  (:map-entry-count :uint32)
  (:map-entrys (:pointer (:struct vk-specialization-map-entry)))
  (:data-size :unsigned-int)
  (:data (:pointer :void)))

(defcstruct vk-pipeline-shader-stage-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-pipeline-stage-flags)
  (:stage VkShaderStageflagbits)
  (:module vk-shader-module)
  (:name :string)
  (:specialization-info (:pointer (:struct vk-specialization-info))))

(defcstruct vk-compute-pipeline-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-pipeline-create-flags)
  (:stage (:struct vk-pipeline-shader-stage-create-info))
  (:layout vk-pipeline-layout)
  (:base-pipeline-handle vk-pipeline)
  (:base-pipeline-index :uint32))

(defcstruct vk-pipeline-shader-stage-required-subground-size-create-info-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:required-subground-size :uint32))

(defcstruct vk-vertex-input-binding-description
  (:binding :uint32)
  (:stride :uint32)
  (:input-rate VkVertexInputRate))

(defcstruct vk-vertex-input-attribute-description
  (:location :uint32)
  (:binding :uint32)
  (:format VkFormat)
  (:offset :uint32))

(defcstruct vk-pipeline-vertex-input-state-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-pipeline-vertex-input-state-create-flags)
  (:vertex-binding-description-count :uint32)
  (:vertex-binding-description (:pointer (:struct vk-vertex-input-binding-description)))
  (:vertex-attribute-description-count :uint32)
  (:vertex-attribute-description (:pointer (:struct vk-vertex-input-attribute-description))))

(defcstruct vk-pipeline-input-assembly-state-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-pipeline-input-assembly-state-create-flags)
  (:topology VkPrimitiveTopology)
  (:primitive-restart-enable vk-bool-32))

(defcstruct vk-pipeline-tessellation-state-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-pipeline-tessellation-state-create-flags)
  (:patch-control-points :uint32))

(defcstruct vk-viewport
  (:x :float)
  (:y :float)
  (:width :float)
  (:height :float)
  (:min-depth :float)
  (:max-depth :float))

(defcstruct vk-pipeline-viewport-state-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-pipeline-viewport-state-create-flags)
  (:viewport-count :uint32)
  (:viewports (:pointer (:struct vk-viewport)))
  (:scissor-count :uint32)
  (:scissprs (:pointer (:struct vk-rect-2d))))

(defcstruct vk-pipeline-rasterization-state-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-pipeline-rasterization-state-create-flags)
  (:depth-clamp-enable vk-bool-32)
  (:rasterizer-discard-enable vk-bool-32)
  (:polygon-mode VkPolygonMode)
  (:cull-mode vk-cull-mode-flags)
  (:front-face VkFrontface)
  (:depth-bias-enable vk-bool-32)
  (:depth-bias-constant-factor :float)
  (:depth-bias-clamp :float)
  (:depth-bias-slope-factor :float)
  (:line-width :float))

(defcstruct vk-pipeline-multisample-state-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-pipeline-multisample-state-create-flags)
  (:rasterization-sample VkSampleCountFlagbits)
  (:sample-shading-enable vk-bool-32)
  (:min-sample-shading :float)
  (:sample-mask (:pointer vk-sample-mask))
  (:alpha-to-coverage-enable vk-bool-32)
  (:alpha-to-one-enable vk-bool-32))

(defcstruct vk-stencil-op-state
  (:fail-op VkStencilop)
  (:pass-op VkStencilop)
  (:depth-fail-op VkStencilop)
  (:compare-op VkCompareop)
  (:compare-mask :uint32)
  (:write-mask :uint32)
  (:references :uint32))

(defcstruct vk-pipeline-depth-stencil-state-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-pipeline-depth-stencil-state-create-flags)
  (:depth-test-enable vk-bool-32)
  (:depth-write-enable vk-bool-32)
  (:depth-compare-op VkCompareop)
  (:depth-bounds-test-enable vk-bool-32)
  (:stencil-test-enable vk-bool-32)
  (:front (:struct vk-stencil-op-state))
  (:back (:struct vk-stencil-op-state))
  (:min-depth-bounds :float)
  (:max-depth-bounds :float))

(defcstruct vk-pipeline-color-blend-attachment-state
  (:blend-enable vk-bool-32)
  (:src-color-blend-factor VkBlendFactor)
  (:dst-color-blend-factor VkBlendFactor)
  (:color-blend-op VkBlendop)
  (:src-alpha-blend-factor VkBlendFactor)
  (:dst-alpha-blend-factor VkBlendFactor)
  (:alpha-blend-op VkBlendop)
  (:color-write-mask vk-color-component-flags))

(defcstruct vk-pipeline-color-blend-state-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-pipeline-color-blend-state-create-flags)
  (:logic-op-enable vk-bool-32)
  (:logic-op VkLogicop)
  (:attachment-count :uint32)
  (:attachments (:pointer (:struct vk-pipeline-color-blend-attachment-state)))
  (:blend-constants :float :count 4))

(defcstruct vk-pipeline-dynamic-state-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-pipeline-dynamic-state-create-flags)
  (:dynamic-state-count :uint32)
  (:dynamic-states (:pointer VkDynamicState)))

(defcstruct vk-graphics-pipeline-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-pipeline-create-flags)
  (:stage-count :uint32)
  (:stage (:pointer (:struct vk-pipeline-shader-stage-create-info)))
  (:vertex-input-stage (:pointer (:struct vk-pipeline-vertex-input-state-create-info)))
  (:input-assembly-stage (:pointer (:struct vk-pipeline-input-assembly-state-create-info)))
  (:tessellation-stage (:pointer (:struct vk-pipeline-tessellation-state-create-info)))
  (:viewport-stage (:pointer (:struct vk-pipeline-viewport-state-create-info)))
  (:rasterization-stage (:pointer (:struct vk-pipeline-rasterization-state-create-info)))
  (:multisample-stage (:pointer (:struct vk-pipeline-multisample-state-create-info)))
  (:depth-stencil-stage (:pointer (:struct vk-pipeline-depth-stencil-state-create-info)))
  (:color-blend-stage (:pointer (:struct vk-pipeline-color-blend-state-create-info)))
  (:dynamic-stage (:pointer (:struct vk-pipeline-dynamic-state-create-info)))
  (:layout vk-pipeline-layout)
  (:render-pass vk-render-pass)
  (:subpass :uint32)
  (:base-pipeline-handle vk-pipeline)
  (:base-pipeline-index :uint32))

(defcstruct vk-graphics-shader-group-create-info-nv
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:stage-count :uint32)
  (:stages (:pointer (:struct vk-pipeline-shader-stage-create-info)))
  (:vetex-input-state (:pointer (:struct vk-pipeline-vertex-input-state-create-info)))
  (:tessellation-stage (:pointer (:struct vk-pipeline-tessellation-state-create-info))))

(defcstruct vk-graphics-pipeline-shader-groups-create-info-nv
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:group-count :uint32)
  (:groups (:pointer (:struct vk-graphics-shader-group-create-info-nv)))
  (:pipeline-count :uint32)
  (:pipelines (:pointer vk-pipeline)))

(defcstruct vk-pipeline-cache-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-pipeline-cache-create-flags)
  (:initial-date-size :unsigned-int)
  (:init-data (:pointer :void)))

(defcstruct vk-pipeline-library-create-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:library-count :uint32)
  (:libraries (:pointer vk-pipeline)))

(defcstruct vk-pipeline-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:pipeline vk-pipeline))

(defcstruct vk-pipeline-executable-properties-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:stage vk-shader-stage-flags)
  (:name :char :count 256)
  (:description :char :count 256)
  (:subgroup-size :uint32))

(defcstruct vk-pipeline-executable-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:pipeline vk-pipeline)
  (:executable-index :uint32))

(defcunion vk-pipeline-executable-statistic-value-khr
  (:b32 vk-bool-32)
  (:i64 :int64)
  (:u64 :uint64)
  (:f64 :double))

(defcstruct vk-pipeline-executable-statistic-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:name :char :count 256)
  (:descripton :char :count 256)
  (:format VkPipelineExecutableStatisticFormatKHR)
  (:value (:union vk-pipeline-executable-statistic-value-khr)))

(defcstruct vk-pipeline-executable-internal-representation-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:name :char :count 256)
  (:description :char :count 256)
  (:is-text vk-bool-32)
  (:data-size :unsigned-int)
  (:data (:pointer :void)))

(defcstruct vk-shader-resource-usage-amd
  (:num-used-vgprs :uint32)
  (:num-used-sgprs :uint32)
  (:lds-size-per-local-work-group :uint32)
  (:lds-usage-size-in-bytes :unsigned-int)
  (:scratch-mem-usage-in-bytes :unsigned-int))

(defcstruct vk-shader-statistics-info-amd
  (:shader-stage-mask vk-shader-stage-flags)
  (:resource-usage (:struct vk-shader-resource-usage-amd))
  (:num-physical-vgprs :uint32)
  (:num-physical-sgprs :uint32)
  (:num-available-vgprs :uint32)
  (:num-available-sgprs :uint32)
  (:computeWorkGroupSize :uint32 :count 3))

(defcstruct vk-pipeline-compiler-control-create-info-amd
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:compiler-control-flags vk-pipeline-compiler-control-flags-amd))

(defcstruct vk-ray-tracing-shader-group-create-info-nv
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:type VkRayTracingShaderGroupTypeKHR)
  (:general-shader :uint32)
  (:closes-hit-shader :uint32)
  (:any-hit-shader :uint32)
  (:intersection-shader :uint32))

(defcstruct vk-ray-tracing-pipeline-create-info-nv
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-pipeline-create-flags)
  (:stage-count :uint32)
  (:stages (:pointer (:struct vk-pipeline-shader-stage-create-info)))
  (:group-count :uint32)
  (:groups (:pointer (:struct vk-ray-tracing-shader-group-create-info-nv)))
  (:layout vk-pipeline-layout)
  (:base-pipeline-handle vk-pipeline)
  (:base-pipeline-index :uint32))

(defcstruct vk-ray-tracing-shader-group-create-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:type VkRayTracingShaderGroupTypeKHR)
  (:general-shader :uint32)
  (:closes-hit-shader :uint32)
  (:any-hit-shader :uint32)
  (:intersection-shader :uint32)
  (:shader-group-capture-replay-handle (:pointer :void)))

(defcstruct vk-pipeline-library-create-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:library-count :uint32)
  (:library (:pointer vk-pipeline)))

(defcstruct vk-ray-tracing-pipeline-interface-create-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:max-payload-size :uint32)
  (:max-attribute-size :uint32)
  (:max-callable-size :uint32))

(defcstruct vk-ray-tracing-pipeline-create-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-pipeline-create-flags)
  (:stage-count :uint32)
  (:stages (:pointer (:struct vk-pipeline-shader-stage-create-info)))
  (:group-count :uint32)
  (:groups (:pointer (:struct vk-ray-tracing-shader-group-create-info-khr)))
  (:max-recursion-depth :uint32)
  (:library (:struct vk-pipeline-library-create-info-khr))
  (:library-interface (:pointer (:struct vk-ray-tracing-pipeline-interface-create-info-khr)))
  (:layout vk-pipeline-layout)
  (:base-pipeline-handle vk-pipeline)
  (:base-pipeline-index :uint32))

(defcstruct vk-pipeline-creation-feedback-ext
  (:flags vk-pipeline-creation-feedback-flags-ext)
  (:duration :uint64))

(defcstruct vk-pipeline-creation-feedback-create-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:pipeline-creation-feedback (:pointer (:struct vk-pipeline-creation-feedback-ext)))
  (:pipeline-stage-creation-feedback-count :uint32)
  (:pipeline-stage-creation-feedbacks (:pointer (:struct vk-pipeline-creation-feedback-ext))))

(defcstruct vk-allocation-callback
  (:user-data (:pointer :void))
  (:fn-allocation vk-allocation-function)
  (:fn-reallocation vk-reallocation-function)
  (:fn-free vk-free-function)
  (:fn-internal-allocation vk-internal-allocation-notification)
  (:fn-internal-free vk-internal-free-notification))

(defcstruct vk-memory-type
  (:property-flags vk-memory-property-flags)
  (:hape-index :uint32))

(defcstruct vk-memory-heap
  (:size vk-device-size)
  (:flags vk-memory-heap-flags))

(defcstruct vk-physical-device-memory-properties
  (:memory-type-count :uint32)
  (:memory-types (:struct vk-memory-type) :count 32) 
  (:memory-heap-count :uint32)
  (:memory-heaps (:struct vk-memory-heap) :count 16))

(defcstruct vk-physical-device-memory-properties2
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:memory-properties (:struct vk-physical-device-properties)))

(defcstruct vk-physical-device-memory-budget-properties-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:heap-budget vk-device-size :count 32)
  (:heap-usage vk-device-size :count 32))

(defcstruct vk-memory-allocate-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:allocation-size vk-device-size)
  (:memory-type-index :uint32))

(defcstruct vk-memory-dedicated-allocate-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:image vk-image)
  (:buffer vk-buffer))

(defcstruct vk-dedicated-allocation-memory-allocate-info-nv
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:image vk-image)
  (:buffer vk-buffer))

(defcstruct vk-memory-priority-allocate-info-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:priority :float))

(defcstruct vk-export-memory-allocate-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:handle-type vk-external-memory-handle-type-flags))

(defcstruct vk-export-memory-win32-handle-info-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:attributes (:pointer (:struct security-attributes)))
  (:dw-access :uint32)
  (:name (:pointer :uint16)))

(defcstruct vk-import-memory-win32-handle-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:handle-type VkExternalMemoryHandleTypeFlagBits)
  (:handle (:pointer :void))
  (:name (:pointer :uint16)))

(defcstruct vk-memory-get-win32-handle-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:memory vk-device-memory)
  (:handle-type VkExternalMemoryHandleTypeFlagBits))

(defcstruct vk-memory-win32-handle-properties-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:memory-type-bits :uint32))

(defcstruct vk-import-memory-fd-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:handle-type VkExternalMemoryHandleTypeFlagBits)
  (:fd :int))

(defcstruct vk-memory-get-fd-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:memory vk-device-memory)
  (:handle-type VkExternalMemoryHandleTypeFlagBits))

(defcstruct vk-memory-fd-properties-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:memory-type-bits :uint32))

(defcstruct vk-import-memory-host-pointer-info-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:handle-type VkExternalMemoryHandleTypeFlagBits)
  (:host-pointer (:pointer :void)))

(defcstruct vk-memory-host-pointer-properties-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:memory-type-bits :uint32))

#|
i don't know how to set up android in lisp
(defcstruct vk-import-android-hardware-buffer-info-android
  (:type VkStructureType)
  (:p-next (:pointer :void)))

(defcstuct vk-memory-get-android-hardware-buffer-info-android
  (:type VkStructureType)
  (:p-next (:pointer :void)))

(defcstruct vk-android-hardware-buffer-properties-android
  (:type VkStructureType)
  (:p-next (:pointer :void)))

(defcstruct vk-android-hardware-buffer-format-properties-android
  (:type VkStructureType)
  (:p-next (:pointer :void)))

(defcstruct vk-external-format-android
  (:type VkStructureType)
  (:p-next (:pointer :void)))
|#

(defcstruct vk-export-memory-allocate-info-nv
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:handle-type vk-external-memory-handle-type-flags-nv))

(defcstruct vk-export-memory-win32-handle-info-nv
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:attributes (:pointer (:struct security-attributes)))
  (:dw-access :uint32))

(defcstruct vk-import-memory-win32-handle-info-nv
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:handle-type vk-external-memory-handle-type-flags-nv)
  (:handle (:pointer :void)))

(defcstruct vk-memory-allocate-flags-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-memory-allocate-flags)
  (:device-mask :uint32))

(defcstruct vk-memory-opaque-capture-address-allocate-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:opaque-capture-address :uint64))

(defcstruct vk-memory-opaque-capture-address-allocate-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:opaque-capture-address :uint64))

(defcstruct vk-mapped-memory-range
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:memory vk-device-memory)
  (:offset vk-device-size)
  (:size vk-device-size))

(defcstruct vk-device-memory-opaque-capture-address-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:memory vk-device-memory))

(defcstruct vk-buffer-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-buffer-create-flags)
  (:size vk-device-size)
  (:usage vk-buffer-usage-flags)
  (:sharing-mode VkSharingMode)
  (:queue-family-count :uint32)
  (:queue-family-indices (:pointer :uint32)))

(defcstruct vk-dedicated-allocation-buffer-create-info-nv
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:dedicated-allocation vk-bool-32))

(defcstruct vk-external-memory-buffer-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:handle-types vk-external-memory-handle-type-flags))

(defcstruct vk-buffer-opaque-capture-address-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:opaque-capture-address :uint64))

(defcstruct vk-buffer-device-address-create-info-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:device-address vk-device-address))

(defcstruct vk-buffer-view-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-buffer-view-create-flags)
  (:buffer vk-buffer)
  (:format VkFormat)
  (:offset vk-device-size)
  (:range vk-device-size))

(defcstruct vk-image-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-image-create-flags)
  (:image-type VkImageType)
  (:foramt VkFormat)
  (:extent (:struct vk-extent-3d))
  (:mop-levels :uint32)
  (:array-layers :uint32)
  (:samples VkSampleCountFlagBits)
  (:tiling VkImageTiling)
  (:usage vk-image-usage-flags)
  (:sharing-mode VkSharingMode)
  (:queue-family-index-count :uint32)
  (:queue-family-indices (:pointer :uint32))
  (:initial-layout VkImageLayout))

(defcstruct vk-image-stencil-usage-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:stencil-usage vk-image-usage-flags))

(defcstruct vk-dedicated-allocation-image-create-info-nv
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:dedicated-allocation vk-bool-32))

(defcstruct vk-external-memory-image-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:handle-types vk-external-memory-handle-type-flags))

(defcstruct vk-external-memory-image-create-info-nv
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:handle-type vk-external-memory-handle-type-flags-nv))

(defcstruct vk-image-swapchain-create-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:swapchain vk-swapchain-khr))

(defcstruct vk-image-format-list-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:view-format-count :uint32)
  (:view-format (:pointer VkFormat)))

(defcstruct vk-image-drm-format-modifier-list-create-info-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:drm-format-modifier-count :uint32)
  (:drm-format-modifiers (:pointer :uint64)))

(defcstruct vk-subresource-layout
  (:offset vk-device-size)
  (:size vk-device-size)
  (:row-pitch vk-device-size)
  (:array-pitch vk-device-size)
  (:depth-pitch vk-device-size))

(defcstruct vk-image-drm-format-modifier-explicit-create-info-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:drm-format-modifier :uint64)
  (:drm-format-modifier-plane-count :uint32)
  (:plane-layouts (:pointer (:struct vk-subresource-layout))))

(defcstruct vk-image-subresource
  (:aspect-mask vk-image-aspect-flags)
  (:mip-level :Uint32)
  (:array-layer :uint32))

(defcstruct vk-image-drm-format-modifier-properties-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:drm-format-modifier :uint64))

(defcstruct vk-component-mapping
  (:r VkComponentSwizzle)
  (:g VkComponentSwizzle)
  (:b VkComponentSwizzle)
  (:a VkComponentSwizzle))

(defcstruct vk-image-view-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:flags vk-image-view-create-flags)
  (:image vk-image)
  (:view-type VkImageViewtype)
  (:format VkFormat)
  (:components (:struct vk-component-mapping))
  (:subresource-range (:struct vk-image-subresource-range)))

(defcstruct vk-image-view-usage-create-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:usage vk-image-usage-flags))

(defcstruct vk-image-view-a-s-t-c-decode-mode-ext
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:decode-mode VkFormat))

(defcstruct vk-image-view-handle-info-nvx
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:image-view vk-image-view)
  (:descriptor-type VkDescriptorType)
  (:sampler vk-sampler))

(defcstruct vk-image-view-address-properties-nvx
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:device-address vk-device-address)
  (:size vk-device-size))

(defcstruct vk-memory-requirements
  (:size vk-device-size)
  (:alignment vk-device-size)
  (:memory-type-bits :uint32))

(defcstruct vk-buffer-memory-requirements-info2
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:buffer vk-buffer))

(defcstruct vk-image-memory-requirements-info2
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:image vk-image))

(defcstruct vk-image-plane-memory-requirements-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:plane-aspect VkImageAspectFlagBits))

(defcstruct vk-memory-requirements2
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:memory-requirements (:struct vk-memory-requirements)))

(defcstruct vk-memory-dedicated-requirements
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:prefers-dedicated-allocation vk-bool-32)
  (:requires-dedicated-allocation vk-bool-32))

(defcstruct vk-bind-buffer-memory-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:buffer vk-buffer)
  (:memory vk-device-memory)
  (:memory-offset vk-device-size))

(defcstruct vk-bind-buffer-memory-device-group-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:device-index-count :uint32)
  (:device-indices (:pointer :uint32)))

(defcstruct vk-bind-image-memory-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:imaeg vk-image)
  (:memory vk-device-memory)
  (:memory-offset vk-device-size))

(defcstruct vk-bind-image-memory-device-group-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:device-index-count :uint32)
  (:device-indices (:pointer :uint32))
  (:split-instance-bind-region-count :uint32)
  (:split-instance-bind-regions (:pointer (:struct vk-rect-2d))))

(defcstruct vk-bind-image-memory-swapchain-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:swapchain vk-swapchain-khr)
  (:image-index :uint32))

(defcstruct vk-bind-image-plane-memory-info
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:plane-aspect VkImageAspectFlagBits))

(defcstruct vk-geometry-triangles-nv
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:vertex-data vk-buffer)
  (:veretex-offset vk-device-size)
  (:vertex-count :uint32)
  (:vertex-stride vk-device-size)
  (:vertex-format VkFormat)
  (:index-data vk-buffer)
  (:index-offset vk-device-size)
  (:index-count :uint32)
  (:index-type VkIndexType)
  (:transform-data vk-buffer)
  (:transform-offset vk-device-size))

(defcstruct vk-geometry-aabb-nv
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:aabb-data vk-buffer)
  (:num-aabbs :uint32)
  (:stride :uint32)
  (:offset vk-device-size))

(defcstruct vk-geometry-data-nv
  (:triangles (:struct vk-geometry-triangles-nv))
  (:aabbs (:struct vk-geometry-aabb-nv)))

(defcstruct vk-geometry-nv
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:geometry-type VkGeometryTypeKHR)
  (:geometry-data (:struct vk-geometry-data-nv))
  (:flags vk-geometry-flags-khr))

(defcstruct vk-acceleration-structure-info-nv
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:type VkAccelerationStructureTypeKHR)
  (:flags vk-build-acceleration-structure-flags-nv)
  (:instance-count :uint32)
  (:geometry-count :uint32)
  (:geometries (:pointer (:struct vk-geometry-nv))))

(defcstruct vk-acceleration-structure-create-info-nv
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:compacted-size vk-device-size)
  (:info (:struct vk-acceleration-structure-info-nv)))

(defcstruct vk-acceleration-structure-create-geometry-type-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:geometry-type VkGeometryTypeKHR)
  (:max-primitive-count :uint32)
  (:index-type VkIndexType)
  (:max-vertex-count :uint32)
  (:vertex-format VkFormat)
  (:allows-transforms vk-bool-32))

(defcstruct vk-acceleration-structure-create-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:compacted-size vk-device-size)
  (:type VkAccelerationStructureTypeKHR)
  (:flags vk-build-acceleration-structure-flags-khr)
  (:max-geometry-count :uint32)
  (:geometry-infos (:pointer (:struct vk-acceleration-structure-create-geometry-type-info-khr)))
  (:device-address vk-device-address))

(defcstruct vk-acceleration-structure-memory-requirements-info-nv
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:type VkAccelerationStructureMemoryRequirementsTypeKHR)
  (:acceleration-structure vk-acceleration-structure-khr))

(defcstruct vk-acceleration-structure-memory-requirements-info-khr
  (:type VkStructureType)
  (:p-next (:pointer :void))
  (:type VkAccelerationStructureMemoryRequirementsTypeKHR)
  (:build-type VkAccelerationStructureBuildTypeKHR)
  (:acceleration-structure vk-acceleration-structure-khr))



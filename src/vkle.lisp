(in-package :vkle)

(export '(queue-family-support-mode-p
	  get-propertiy-queue-list
	  get-present-queue-list
	  make-pipeline-shader-stage-info
	  make-pipeline-dynamic-state-info
	  make-pipeline-rasterization-info
	  make-pipeline-viewport-stage-info
	  make-pipeline-color-blend-state-info
	  make-pipeline-multisample-state-info
	  make-pipeline-vertex-input-state-info
	  make-pipeline-tessellation-state-info
	  make-pipeline-depth-stencil-state-info
	  make-pipeline-input-assembly-state-info
	  make-write-descriptor-set
	  make-copy-descriptor-set))

(defun c-array-to-lisp-string (array size)
  (loop for i upto (1- size)
	for c = (code-char (mem-aref array :char i))
	until (not (or (alpha-char-p c) (char= #\Space c) (char= #\_ c)))
	collect c into lstr
	finally
	(return  (concatenate 'string lstr))))

(defun pointer->val (pointer type)
  (mem-ref pointer type))

(defun queue-family-support-mode-p (val &optional (mode :queue-graphics-bit))
  "val is a type of uint32, mode is a enumerate type of VkQueueFlagBits"
  (when (/= (logand val (foreign-enum-value 'VkQueueFlagBits mode)) 0)
    t))

(defun get-support-extensions (lst properties)
  "lst is a list of the name of extension name, properties is a list of struct whitch enumerate by enumerate function"
  (loop for p in properties
	collect (getf p :extension-name) into prop-list
	finally
	   (return (intersection lst prop-list :test #'string=))))

(defun get-support-layers (lst properties)
  "lst is a list of the name of extension name, properties is a list of struct whitch enumerate by enumerate function"
  (loop for p in properties
	collect (getf p :layer-name) into prop-list
	finally
	   (return (intersection lst prop-list :test #'string=))))

(defun get-propertiy-queue-list (str &optional (type :queue-graphics-bit))
  "get a list of queue able the type"
  (loop for q in str
	for i from 0
	for mode = (getf q :queue-flags)
	when (queue-family-support-mode-p mode type)
	  collect i))

(defun get-present-queue-list (instance physical-device str)
  "get the present queue list"
  (loop for q in str
	for i from 0
	unless (zerop (queue-family-index-support-present-p instance physical-device i))
	  collect i))

(defun create-sub-vk-object (type lst)
  (if (null lst)
      (null-pointer)
      (with-foreign-object (obj type (length lst))
	(loop for sub-lst in lst
	      for i from 0
	      for sub-obj = (mem-aptr obj type i)
	      do
		 (create-vk-object sub-obj type sub-lst))
	obj)))

(defun create-vk-object (obj type lst)
  (cond ((null lst) nil)
	((listp (cadr lst))
	 (progn
	   (let ((sub-type (car (cadr lst)))
		 (sub-list (cadr (cadr lst))))
	     (set-vk-object obj type (car lst) (create-sub-vk-object sub-type sub-list))
	     (create-vk-object obj type (cddr lst)))))
	(t
	 (progn
	   (set-vk-object obj type (car lst) (cadr lst))
	   (create-vk-object obj type (cddr lst))))))

(defun set-vk-object (obj type key val)
  (if (null val)
      (setf (foreign-slot-value obj type key) (null-pointer))
      (setf (foreign-slot-value obj type key) val)))

(defun create-device-queue (infos queue)
  (with-foreign-object (pro :float)
    (setf (foreign-slot-value queue '(:struct vk-device-queue-create-info) :type)
	  :structure-type-device-queue-create-info
	  (foreign-slot-value queue '(:struct vk-device-queue-create-info) :next)
	  (null-pointer))
    (labels ((create (info)
	       (cond ((null info) nil)
		     ((eql (car info) :queue-properties)
		      (progn
			(format t "~a ~%" (car info))
			(setf (mem-ref pro :float) (cadr info)
			      (foreign-slot-value queue
						  '(:struct vk-device-queue-create-info)
						  :queue-properties)
			      pro)
			     (create (cddr info))))
		     (t (progn
			  (format t "~a ~%" (car info))
			  (setf (foreign-slot-value queue
						    '(:struct vk-device-queue-create-info)
						    (car info))
				(cadr info))
			  (create (cddr info)))))))
      (create infos))))

(defun create-bind-sparse-info (&key
				  (next nil)
				  (wait-semaphores-lst nil)
				  (buffer-binds-lst nil)
				  (image-opaque-binds-lst nil)
				  (image-binds-lst nil)
				  (signal-semaphores-lst nil))
  (with-foreign-objects ((bind-info '(:struct vk-bind-sparse-info))
			 (wait-semaphores 'vk-semaphore (length wait-semaphores-lst))
			 (signal-semaphores 'vk-semaphore (length signal-semaphores-lst))			 
			 (buffer-binds '(:struct vk-sparse-buffer-memory-bind-info) (length buffer-binds-lst))
			 (image-opaque-binds '(:struct vk-sparse-image-opaque-memory-bind-info) (length image-opaque-binds-lst))
			 (image-binds '(:struct vk-sparse-image-memory-bind-info) (length image-binds-lst)))
    (when (null next)
      (setf next (null-pointer)))
    (when (null wait-semaphores-lst)
      (setf wait-semaphores (null-pointer)))
    (when (null signal-semaphores-lst)
      (setf signal-semaphores (null-pointer)))
    (when (null buffer-binds-lst)
      (setf buffer-binds (null-pointer)))
    (when (null image-opaque-binds-lst)
      (setf image-opaque-binds (null-pointer)))
    (when (null image-binds-lst)
      (setf image-binds (null-pointer)))
    (loop for semaphore in wait-semaphores-lst
	  for i from 0
	  do
	     (setf (mem-aref wait-semaphores 'vk-semaphore i) semaphore))
    (loop for semaphore in signal-semaphores-lst
	  for i from 0
	  do
	     (setf (mem-aref signal-semaphores 'vk-semaphore i) semaphore))
    (loop for info in buffer-binds-lst
	  for i from 0
	  for cinfo = (mem-aptr buffer-binds '(:struct vk-sparse-buffer-memory-bind-info) i)
	  do
	     (create-vk-object cinfo '(:struct vk-sparse-buffer-memory-bind-info) info))
    (loop for info in image-opaque-binds-lst
	  for i from 0
	  for cinfo = (mem-aptr buffer-binds '(:struct vk-sparse-image-opaque-memory-bind-info) i)
	  do
	     (create-vk-object cinfo '(:struct vk-sparse-image-opaque-memory-bind-info) info))
    (loop for info in image-binds-lst
	  for i from 0
	  for cinfo = (mem-aptr buffer-binds '(:struct vk-sparse-image-memory-bind-info) i)
	  do
	     (create-vk-object cinfo '(:struct vk-sparse-image-memory-bind-info) info))
    (setf (foreign-slot-value bind-info '(:struct vk-bind-sparse-info) :type)
	  :structure-type-bind-sparse-info
	  (foreign-slot-value bind-info '(:struct vk-bind-sparse-info) :next)
	  next
	  (foreign-slot-value bind-info '(:struct vk-bind-sparse-info) :wait-semaphore-count)
	  (length wait-semaphores-lst)
	  (foreign-slot-value bind-info '(:struct vk-bind-sparse-info) :wait-semaphores)
	  wait-semaphores
	  (foreign-slot-value bind-info '(:struct vk-bind-sparse-info) :buffer-bind-count)
	  (length buffer-binds-lst)
	  (foreign-slot-value bind-info '(:struct vk-bind-sparse-info) :buffer-binds)
	  buffer-binds
	  (foreign-slot-value bind-info '(:struct vk-bind-sparse-info) :image-opaque-bind-count)
	  (length image-opaque-binds-lst)
	  (foreign-slot-value bind-info '(:struct vk-bind-sparse-info) :image-opaque-binds)
	  image-opaque-binds
	  (foreign-slot-value bind-info '(:struct vk-bind-sparse-info) :image-bind-count)
	  (length image-binds-lst)
	  (foreign-slot-value bind-info '(:struct vk-bind-sparse-info) :image-binds)
	  image-binds
	  (foreign-slot-value bind-info '(:struct vk-bind-sparse-info) :signal-semaphore-count)
	  (length signal-semaphores-lst)
	  (foreign-slot-value bind-info '(:struct vk-bind-sparse-info) :signal-semaphores)
	  signal-semaphores)
    bind-info))

(defun make-3d-extent (obj lst)
  (if (null lst)
      (null-pointer)
      (create-vk-object obj '(:struct vk-extent-3d) lst)))

(defun make-pipeline-shader-stage-info (module &key
						 (next nil)
						 (flags 0)
						 (stage 0)
						 (name "test")
						 (specialization-info nil))
  (list :type :structure-type-pipeline-shader-stage-create-info
	:next next
	:flags flags
	:stage stage
	:module module
	:name name
	:specialization-info (list '(:struct vk-specialization-info)
				   specialization-info)))

(defun make-pipeline-vertex-input-state-info (&key
						(next nil)
						(flags 0)
						(bindings nil)
						(attributes nil))
  (list :type :structure-type-pipeline-vertex-input-state-create-info
	:next next
	:flags flags
	:vertex-binding-description-count (length bindings)
	:vertex-binding-description (list '(:struct vk-vertex-input-binding-description)
					  bindings)
	:vertex-attribute-description-count (length attributes)
	:vertex-attribute-description (list '(:struct vk-vertex-input-attribute-description)
					    attributes)))

(defun make-pipeline-input-assembly-state-info (&key
						  (next nil)
						  (flags 0)
						  (topology 0)
						  (primitive-restart-enable 0))
  (list :type :structure-type-pipeline-input-assembly-state-create-info
	:next next
	:flags flags
	:topology topology
	:primitive-restart-enable primitive-restart-enable))

(defun make-pipeline-tessellation-state-info (&key
						(next nil)
						(flags 0)
						(patch-control-points 0))
  (list :type :structure-type-pipeline-tessellation-state-create-info
	:next next
	:flags flags
	:patch-control-points patch-control-points))

(defun make-pipeline-viewport-stage-info (&key
					    (next nil)
					    (flags 0)
					    (viewports nil)
					    (scissor nil))
  (list :type :structure-type-pipeline-viewport-state-create-info
	:next next
	:flags flags
	:viewport-count (length viewports)
	:viewports (list '(:struct vk-viewport)
			 viewports)
	:scissor-count (length scissor)
	:scissprs (list '(:struct vk-rect-2d)
			scissor)))

(defun make-pipeline-rasterization-info (&key
					   (next nil)
					   (flags 0)
					   (depth-clamp-enable 0)
					   (rasterizer-discard-enable 0)
					   (polygon-mode 0)
					   (cull-mode 0)
					   (front-face 0)
					   (depth-bias-enable 0)
					   (depth-bias-constant-factor 0.0)
					   (depth-bias-clamp 0.0)
					   (depth-bias-slope-factor 0.0)
					   (line-width 0.0))
  (list :type :structure-type-pipeline-rasterization-state-create-info
	:next next
	:flags flags
	:depth-clamp-enable depth-clamp-enable
	:rasterizer-discard-enable rasterizer-discard-enable
	:polygon-mode polygon-mode
	:cull-mode cull-mode
	:front-face front-face
	:depth-bias-enable depth-bias-enable
	:depth-bias-constant-factor depth-bias-constant-factor
	:depth-bias-clamp depth-bias-clamp
	:depth-bias-slope-factor depth-bias-slope-factor
	:line-width line-width))

(defun make-pipeline-multisample-state-info (&key
					       (next nil)
					       (flags 0)
					       (rasterization-samples 0)
					       (sample-shading-enable 0)
					       (min-sample-shading 0)
					       (sample-mask nil)
					       (alpha-to-coverage-enable 0)
					       (alpha-to-one-enable 0))
  (list :type :structure-type-pipeline-multisample-state-create-info
	:next next
	:flags flags
	:rasterization-sample rasterization-samples
	:sample-shading-enable sample-shading-enable
	:min-sample-shading min-sample-shading
	:sample-mask (list 'vk-sample-mask
			   sample-mask)
	:alpha-to-coverage-enable alpha-to-coverage-enable
	:alpha-to-one-enable alpha-to-one-enable))

(defun make-pipeline-depth-stencil-state-info (&key
						 (next nil)
						 (flags 0)
						 (depth-test-enable 0)
						 (depth-write-enable 0)
						 (depth-compare-op :compare-op-never)
						 (depth-bounds-test-enable 0)
						 (stencil-test-enable 0)
						 (front nil)
						 (back nil)
						 (min-depth-bounds 0.0)
						 (max-depth-bounds 0.0))
  (list :type :structure-type-pipeline-depth-stencil-state-create-info
	:next next
	:flags flags
	:depth-test-enable depth-test-enable
	:depth-write-enable depth-write-enable
	:depth-compare-op depth-compare-op
	:depth-bounds-test-enable depth-bounds-test-enable
	:stencil-test-enable stencil-test-enable
	:front (list '(:struct vk-stencil-op-state)
		     front)
	:back (list '(:struct vk-stencil-op-state)
		    back)
	:min-depth-bounds min-depth-bounds
	:max-depth-bounds max-depth-bounds))

(defun make-pipeline-color-blend-state-info (&key
					       (next nil)
					       (flags 0)
					       (logic-op-enable 0)
					       (logic-op :logic-op-clear)
					       (attachmemts nil)
					       (blend-constants nil))
  (list :type :structure-type-pipeline-color-blend-state-create-info
	:next next
	:flags flags
	:logic-op-enable logic-op-enable
	:logic-op logic-op
	:attachment-count (length attachmemts)
	:attachments (list '(:struct vk-pipeline-color-blend-attachment-state)
			   attachmemts)
	:blend-constants (list :float
			       blend-constants)))

(defun make-pipeline-dynamic-state-info (&key
					   (next nil)
					   (flags 0)
					   (states nil))
  (list :type :structure-type-pipeline-dynamic-state-create-info
	:next next
	:flags flags
	:dynamic-state-count (length states)
	:dynamic-states states))

(defun make-write-descriptor-set (dst-set &key
					    (next nil)
					    (dst-binding 0)
					    (dst-array-element 0)
					    (descriptor-count 0)
					    (descriptor-type :descriptor-type-sampler)
					    (image-info nil)
					    (buffer-info nil)
					    (texel-buffer-view nil))
  (list :type :structure-type-write-descriptor-set
	:next next
	:dst-set dst-set
	:dst-binding dst-binding
	:dst-array-element dst-array-element
	:descriptor-count descriptor-count
	:descriptor-type descriptor-type
	:image-info (list '(:struct vk-descriptor-image-info)
			  image-info)
	:buffer-info (list '(:struct vk-descriptor-buffer-info)
			   buffer-info)
	:texel-buffer-view (list 'vk-buffer-view
				 texel-buffer-view)))

(defun make-copy-descriptor-set (src-set dst-set &key
						   (next nil)
						   (src-binding 0)
						   (src-array-element 0)
						   (dst-binding 0)
						   (dst-array-element 0)
						   (descriptor-count 0))
  (list :type :structure-type-copy-descriptor-set
	:next next
	:src-set src-set
	:src-binding src-binding
	:src-array-element src-array-element
	:dst-set dst-set
	:dst-binding dst-binding
	:dst-array-element dst-array-element
	:descriptor-count descriptor-count))

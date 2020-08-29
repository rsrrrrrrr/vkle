(in-package :vkle)

(export '(queue-family-support-mode-p
	  get-propertiy-queue-list
	  get-present-queue-list))

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
  (with-foreign-object (obj type)
    (create-vk-object obj type lst)
    obj))

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

(defun create-3d-extent (obj lst)
  (if (null lst)
      (null-pointer)
      (create-vk-object obj '(:struct vk-extent-3d) lst)))


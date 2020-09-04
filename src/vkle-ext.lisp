(in-package :vkle)

(defun check-reslute-type (ret-val)
  (when (not (eql ret-val :success))
    (error ret-val)))

(defun make-vulkan-version (&optional (major 1) (minor 2) (patch 0))
  (logior (ash major 22)
	  (ash minor 12)
	  patch))

(defun char-array-to-lisp-string (array size)
  (loop for i upto (1- size)
	for c = (code-char (mem-aref array :char i))
	until (not (or (alpha-char-p c) (char= #\Space c) (char= #\_ c)))
	collect c into lstr
	finally
	(return  (concatenate 'string lstr))))

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

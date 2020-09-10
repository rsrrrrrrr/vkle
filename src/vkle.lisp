(in-package :vkle)

(export '(check-instance-extesion-support-p
	  check-reslute-type
	  check-usable-instance-layers
	  check-usable-instance-extensions
	  queue-family-support-mode-p
	  c-null))

(defparameter c-null (null-pointer))

(defun check-reslute-type (ret-val)
  (when (not (eql ret-val :success))
    (error ret-val)))

(defun obj->list (obj count type)
  (loop for i upto (1- (mem-ref count :uint32))
	collect (mem-aref obj type i)))

(defun do-get-function (fp &rest args)
  (check-reslute-type (apply fp args)))

(defun c-char-array->string (point)
  (loop for i upto 255
	for c = (code-char (mem-aref point :char i))
	until (not (or (alpha-char-p c) (char= #\Space c) (char= #\_ c)))
	collect c into lstr
	finally
	   (return  (concatenate 'string lstr))))

(defun convert-to-new-list (infos)
  (if (null infos)
      nil
      (cons (convert (car infos)) (convert-to-new-list (cdr infos)))))

(defun convert (info)
  (cond ((null info) nil)
	((member (car info) '(:description :layer-name :extension-name))
	 (append (list (car info)
		       (c-char-array->string (getf info (car info))))
		 (convert (cddr info))))
	(t (append (list (car info)
			 (cadr info))
		   (convert (cddr info))))))

(defun check-usable-instance-layers (layers)
  (let* ((all-usable-layers-struct (get-instance-layers))
	 (all-usable-layers (loop for struct in all-usable-layers-struct
				  collect (getf struct :layer-name))))
    (intersection all-usable-layers layers :test #'string=)))

(defun check-usable-instance-extensions (extensions)
  (let ((all-usable-extensions (get-instance-extensions)))
    (intersection all-usable-extensions extensions :test #'string=)))

(defun check-usable-device-layers (physical-device layers)
  (let* ((all-usable-layers-struct (get-device-layers physical-device))
	 (all-usable-layers (loop for struct in all-usable-layers-struct
				  collect (getf struct :layer-name))))
    (intersection all-usable-layers layers :test #'string=)))

(defun check-usable-device-extensions (physical-device layers extensions)
  (let* ((all-usable-layers (check-usable-device-layers physical-device layers))
	 (all-usable-extensions-struct (loop for layer in all-usable-layers
					     collect (get-device-extensions physical-device layer)))
	 (all-usable-extensions (loop for struct in all-usable-extensions-struct
				      collect (getf struct :extension-name))))
    (intersection all-usable-extensions extensions :test #'string=)))

(defun null->null-pointer (val)
  (if val
      val
      (null-pointer)))

(defun make-vulkan-version (&optional (major 1) (minor 2) (patch 0))
  (logior (ash major 22)
	  (ash minor 12)
	  patch))

(defun queue-family-support-mode-p (val &optional (mode :queue-graphics-bit))
  "val is a type of uint32, mode is a enumerate type of VkQueueFlagBits"
  (when (/= (logand val (foreign-enum-value 'VkQueueFlagBits mode)) 0)
    t))

(defun convert->foreign-pointers (lst type)
  (when (null lst)
    (null-pointer))
  (with-foreign-object (obj type (length lst))
    (loop for i upto (1- (length lst))
	  do
	     (setf (mem-aref obj type)
		   (convert-to-foreign (nth i lst) type)))
    (mem-aptr obj type)))

(defun convert-nil->null-pointer (lst)
  (subst-if (null-pointer) #'null lst))

(defun make-default-obj (type &rest info)
  (with-foreign-object (obj type)
    (let ((keys (foreign-slot-names type)))
      (mapcar #'(lambda (key)
		  (let ((c-type (foreign-slot-type type key)))
		    (cond ((member key info) (setf (foreign-slot-value obj type key) (getf info key)))
			  ((or (consp c-type) (eql :string c-type)) (null-pointer))
			  (t (setf (foreign-slot-value obj type key) 0)))))
	      keys))
    obj))

(defun fill-obj (obj lst type)
  (when (null lst)
    (null-pointer))
  (loop for name in lst
	for i from 0
	do
	   (setf (mem-aref obj type i)
		 (convert-to-foreign (nth i lst) type))))

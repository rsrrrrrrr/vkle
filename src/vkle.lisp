(in-package :vkle)

(export '(check-instance-extesion-support-p))

(defun convert-to-pointer (lst)
  (cond ((null lst) nil)
	((null (cadr lst))
	 (progn
	   (setf (cadr lst) (null-pointer))
	   (convert-to-suitable (cddr lst))))
	((listp (cadr lst))
	 (let* ((sub-info (cadr lst))
		(type (car sub-info))
		(sinfo (cadr sub-info)))
	   (cond ((member type '(:uint64 :uint32 :uint16 :uint8 :uint :unsigned-int
				 :int64 :int32 :int16 :int8 :int :float :double :string))
		  (loop for val in sinfo
			collect (convert-to-foreign val type)))
		 ((listp type) (progn
				 (convert-to-suitable sinfo)
				 (convert-to-foreign sinfo type))))
	   (convert-to-suitable (cddr lst))))
	(t (convert-to-suitable (cddr lst)))))

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
	((member (car info) '(:description :layer-name))
	 (append (list (car info)
		       (c-char-array->string (getf info (car info))))
		 (convert (cddr info))))
	(t (append (list (car info)
			 (cadr info))
		   (convert (cddr info))))))

(defun check-instance-extesion-support-p (name)
  (let ((enable-extensions (get-instance-extensions)))
    (member name enable-extensions :test #'string=)))

(defun check-usable-instance-layers (layers)
  (let* ((all-usable-layers-struct (get-instance-layers))
	 (all-usable-layers (loop for struct in all-usable-layers-struct
				  collect (getf struct :layer-name))))
    (intersection all-usable-layers layers :test #'string=)))

(defun check-usable-instance-extensions (extensions)
  (let ((all-usable-extensions (get-instance-extensions)))
    (intersection all-usable-extensions extensions :test #'string=)))

(defun null->null-pointer (val)
  (if val
      val
      (null-pointer)))

(defun check-reslute-type (ret-val)
  (when (not (eql ret-val :success))
    (error ret-val)))

(defun make-vulkan-version (&optional (major 1) (minor 2) (patch 0))
  (logior (ash major 22)
	  (ash minor 12)
	  patch))

(defun queue-family-support-mode-p (val &optional (mode :queue-graphics-bit))
  "val is a type of uint32, mode is a enumerate type of VkQueueFlagBits"
  (when (/= (logand val (foreign-enum-value 'VkQueueFlagBits mode)) 0)
    t))

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

(defun create-device-queue (infos queue)
  (with-foreign-object (pro :float)
    (setf (foreign-slot-value queue '(:struct vk-device-queue-create-info) :type)
	  :structure-type-device-queue-create-info
	  (foreign-slot-value queue '(:struct vk-device-queue-create-info) :flags)
	  1
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

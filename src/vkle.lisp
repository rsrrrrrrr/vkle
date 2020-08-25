(in-package :vkle)

(export '(queue-family-support-mode-p))

(defun c-array-to-lisp-string (array size)
  (loop for i upto (1- size)
	for c = (code-char (mem-aref array :char i))
	until (not (or (alpha-char-p c) (char= #\Space c) (char= #\_ c)))
	collect c into lstr
	finally
	(return  (concatenate 'string lstr))))

(defun queue-family-support-mode-p (val &key (mode :queue-graphics-bit))
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

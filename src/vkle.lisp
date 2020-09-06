(in-package :vkle)

(defun info-maker (lst)
  (cond ((null lst) (null-pointer))
	((listp (cadr lst)) (create-obj (car lst) (cadr lst)))))

(defun create-obj (type info)
  (with-foreign-object (obj type)
    (fill-obj obj type info)
    obj))

(defun fill-obj (obj type info)
  (cond ((null info) nil)
	((listp (cadr info))
	 (progn
	   (do-fill obj type (car info) (info-maker (cadr info)))
	   (fill-obj obj type (cddr info))))
	(t
	 (progn
	   (do-fill obj type (car info) (cadr info))
	   (fill-obj obj type (cddr info))))))

(defun do-fill (obj type key val)
  (setf (foreign-slot-value obj type key)
	val))

(in-package :vkle)

(export '(make-vulkan-version))

(declaim (inline make-vulkan-version))

(defun make-vulkan-version (&optional (major 1) (minor 2) (patch 0))
  (logior (ash major 22)
	  (ash minor 12)
	  patch))

(defmacro define-translation (lisp-struct-name c-struct-name)
  (eval `(define-foreign-type ,lisp--struct-name ()
	   ()
	   (:actual-type :struct ,c-struct-name)
	   (:simple-parser obj))))

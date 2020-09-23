(in-package :vkle)

(defparameter *instance-dbg-create-info* (null-pointer))
(defparameter *instance-dbg-callback-handle* nil)

(defparameter *debug-status* nil)

(defcallback debug-message vk-bool-32
    ((flags vk-flags)
     (obj-type VkDebugReportObjectTypeExt)
     (src-obj :uint64)
     (location :unsigned-int)
     (msg-code :int32)
     (layer-prefix :string)
     (msg :string)
     (user-data (:pointer :void)))
  (declare (ignore obj-type src-obj location user-data))
  (format t "layer-prefix:~a                                   msg-code: ~a~%" layer-prefix msg-code)
  (cond ((not (zerop (logand flags (foreign-enum-value 'VkDebugReportFlagBitsEXT :debug-report-error-bit-ext))))
	 (format t "[debug error] -> message: ~a~%" msg)
	 (not (zerop (logand flags (foreign-enum-value 'VkDebugReportFlagBitsEXT :debug-report-warning-bit-ext))))
	 (format t "[debug waring] -> message: ~a~%" msg)	 
	 (not (zerop (logand flags (foreign-enum-value 'VkDebugReportFlagBitsEXT :debug-report-information-bit-ext))))
	 (format t "[debug information] -> message: ~a~%" msg)
	 (not (zerop (logand flags (foreign-enum-value 'VkDebugReportFlagBitsEXT :debug-report-performance-warning-bit-ext))))
	 (format t "[debug performance waring] -> message: ~a~%" msg)
	 (not (zerop (logand flags (foreign-enum-value 'VkDebugReportFlagBitsEXT :debug-report-debug-bit-ext))))
	 (format t "[debug] -> message: ~a~%" msg)
	 t 0)))

(defun create-debug-callback (instance &optional (allocator c-null))
  (setf *instance-dbg-callback-handle* (foreign-alloc 'vk-debug-utils-messenger-ext))
  (with-foreign-object (create-fun :pointer)
    (setf (mem-ref create-fun :pointer) (get-instance-proc-addr instance "vkCreateDebugReportCallbackEXT"))
    (unless (null-pointer-p create-fun)
      (check-reslute-type (foreign-funcall-pointer (mem-ref create-fun :pointer) ()
						   vk-instance instance
						   (:pointer (:struct vk-debug-report-callback-create-info-ext)) *instance-dbg-create-info*
						   (:pointer (:struct vk-allocation-callback)) allocator 
						   vk-debug-utils-messenger-ext *instance-dbg-callback-handle*
						   VkResult)))))

(defun destroy-debug-callback (instance &optional (allocator c-null))
  (with-foreign-object (destroy-fun :pointer)
    (setf (mem-ref destroy-fun :pointer) (get-instance-proc-addr instance "vkDestroyDebugReportCallbackEXT"))
    (unless (null-pointer-p destroy-fun)
      (foreign-funcall-pointer (mem-ref destroy-fun :pointer) ()
			       vk-instance instance
			       vk-debug-utils-messenger-ext (mem-ref *instance-dbg-callback-handle* :pointer)
			       (:pointer (:struct vk-allocation-callback)) allocator))))

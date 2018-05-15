;; cl-bitcoin - Peer to peer money
;; Copyright 2018 Thomas de Grivel <thoxdg@gmail.com> 0614550127

(in-package :cl-bitcoin)

(defmacro define-vector (type)
  (let ((type-vector (sym type '-vector)))
    `(progn
       (deftype ,type-vector (&optional (length '*))
         `(array ,',type (,length)))
       (defun ,type-vector (&rest elements)
         (make-array (length elements) :element-type ',type
                     :initial-contents elements))
       (defun ,(sym type-vector '-json) (obj out)
         (let ((sep #\[))
           (dotimes (i (length obj))
             (write-char sep out)
             (setf sep #\,)
             (,(sym type '-json) (aref obj i) out)))
         (write-char #\] out)))))

(deftype bool () '(or t nil))

(defun bool-json (obj out)
  (write-string (if obj "true" "false") out))

(deftype bytes (&optional (size '*))
  `(array (unsigned-byte 8) (,size))) 

(defun bytes-json (obj out)
  (write-string (hex obj) out))

(defun null-json (out)
  (write-string "null" out))

(defun integer-json (obj out)
  (declare (type integer obj))
  (prin1 obj out))

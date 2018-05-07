;; cl-bitcoin - Peer to peer money
;; Copyright 2018 Thomas de Grivel <thoxdg@gmail.com> 0614550127

(in-package :cl-bitcoin)

(defun encode (string)
  (babel:string-to-octets string :encoding :utf-8 :use-bom nil))

(let ((base "0123456789ABCDEF"))
  (defun hex (octets)
    (let* ((len (length octets))
           (out (make-string (* 2 len))))
      (dotimes (i len)
        (let* ((o (aref octets i)))
          (setf (char out (* 2 i)) (char base (floor o 16))
                (char out (1+ (* 2 i))) (char base (mod o 16)))))
      out)))

(defun kw (&rest parts)
  (intern (apply #'str parts) :keyword))

(defun str (&rest parts)
  (with-output-to-string (out)
    (dolist (item parts)
      (prin1 item out))))

(defun string-json (obj out)
  (declare (type string obj))
  (prin1 obj out))

(defun sym (&rest parts)
  (intern (apply #'str parts)))

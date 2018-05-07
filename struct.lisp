;; cl-bitcoin copyright Thomas de Grivel <thoxdg@gmail.com> 0614550127

(in-package :cl-bitcoin)

(defun define-struct/struct (name slots)
  `(defstruct ,name
     ,@(mapcar (lambda (slot)
                 (destructuring-bind (slot-name slot-type) slot
                   `(,slot-name nil :type ,slot-type)))
               slots)))

(defun define-struct/fun (name slots slot-names)
  `(defun ,name ,slot-names
     (,(sym 'make- name)
       ,@(mapcan (lambda (slot)
                   (destructuring-bind (slot-name slot-type) slot
                     (declare (ignore slot-type))
                     `(,(kw slot-name) ,slot-name)))
                 slots))))

(defun define-struct/json (name slots)
  (flet ((json-slot (slot &optional (pre #\,))
           (destructuring-bind (slot-name slot-type) slot
             `((write-string
                ,(format nil "~C~S:" pre (string-downcase slot-name))
                out)
               (,(sym slot-type '-json)
                 (,(sym name '- slot-name) obj)
                 out)))))
    `(defun ,(sym name '-json) (obj out)
       ,@(json-slot (first slots) #\{)
       ,@(mapcan #'json-slot (rest slots))
       (write-char #\} out))))

(defmacro define-struct (name &body slots)
  (let ((slot-names (mapcar #'first slots)))
    `(progn
       ,(define-struct/struct name slots)
       ,(define-struct/fun name slots slot-names)
       ,(define-struct/json name slots))))

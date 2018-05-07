;; cl-bitcoin copyright Thomas de Grivel <thoxdg@gmail.com> 0614550127

(in-package :common-lisp)

(defpackage :cl-bitcoin
  (:nicknames :bitcoin)
  (:use :common-lisp)
  (:shadow #:block)
  (:export
   #:block
   #:transaction))

;; cl-bitcoin - Peer to peer money
;; Copyright 2018 Thomas de Grivel <thoxdg@gmail.com> 0614550127

(in-package :common-lisp)

(defpackage :cl-bitcoin
  (:nicknames :bitcoin)
  (:use :common-lisp)
  (:shadow #:block)
  (:export
   #:block
   #:transaction))

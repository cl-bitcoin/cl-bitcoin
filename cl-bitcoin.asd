;; cl-bitcoin - Peer to peer money
;; Copyright 2018 Thomas de Grivel <thoxdg@gmail.com> 0614550127

(defpackage :cl-bitcoin.system
  (:use :cl :asdf))

(in-package :cl-bitcoin.system)

(defsystem :cl-bitcoin
  :name "cl-bitcoin"
  :author "Thomas de Grivel <thoxdg@gmail.com>"
  :version "0.1"
  :description "Peer to peer money"
  :depends-on ("babel"
               "ironclad")
  :components
  ((:file "block" :depends-on ("transaction"))
   (:file "package")
   (:file "params" :depends-on ("package"))
   (:file "sha256" :depends-on ("string"))
   (:file "string" :depends-on ("package"))
   (:file "struct" :depends-on ("string"))
   (:file "transaction" :depends-on ("params" "sha256" "struct" "types"))
   (:file "types" :depends-on ("string"))))

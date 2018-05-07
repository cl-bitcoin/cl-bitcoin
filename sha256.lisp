;; cl-bitcoin - Peer to peer money
;; Copyright 2018 Thomas de Grivel <thoxdg@gmail.com> 0614550127

(in-package :cl-bitcoin)

(defun sha256 (octets)
  (let ((digest (ironclad:make-digest :sha256)))
    (ironclad:update-digest digest octets)
    (ironclad:produce-digest digest)))

(defun double-sha256 (octets)
  (hex (sha256 (sha256 octets))))

;; cl-bitcoin - Peer to peer money
;; Copyright 2018 Thomas de Grivel <thoxdg@gmail.com> 0614550127

(in-package :cl-bitcoin)

(define-struct block
  (version int)
  (prev_block_hash string)
  (merkle_hash string)
  (timestamp int)
  (bits int)
  (nonce int)
  (txns transaction-vector))

(defun block-header (obj &optional nonce)
  (str (block-version obj)
       (block-prev_block_hash obj)
       (block-merkle_hash obj)
       (block-timestamp obj)
       (block-bits obj)
       (or nonce (block-nonce obj))))

(defun block-id (obj)
  (double-sha256 (block-header obj)))

;; cl-bitcoin - Peer to peer money
;; Copyright 2018 Thomas de Grivel <thoxdg@gmail.com> 0614550127

(in-package :cl-bitcoin)

(define-struct out_point
  (txid string)
  (txout_idx integer))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (deftype out_point* () '(or out_point null)))

(defun out_point*-json (obj out)
  (if obj
      (out_point-json obj out)
      (null-json out)))

(define-struct tx_in
  (to_spend out_point*)
  (unlock_sig bytes)
  (unlock_pk bytes)
  (sequence integer))

(define-vector tx_in)

(define-struct tx_out
  (value integer)
  (to_address string))

(define-vector tx_out)

(define-struct unspent_tx_out
  (value integer)
  (to_address string)
  (txid string)
  (txout_idx integer)
  (is_coinbase bool)
  (height integer))

(defun unspent_tx_out-out_point (obj)
  (out_point (unspent_tx_out-txid obj)
             (unspent_tx_out-txout_idx obj)))

(define-struct transaction
  (txins tx_in-vector)
  (txouts tx_out-vector)
  (locktime integer))

(define-vector transaction)

(defun transaction-is_coinbase (tx)
  (let ((txins (transaction-txins tx)))
    (and (= 1 (length txins))
         (null (tx_in-to_spend (elt txins 0))))))

(defun transaction-create_coinbase (to-addr value height)
  (let ((txin (tx_in nil (encode (prin1-to-string height)) nil 0))
        (txout (tx_out value to-addr)))
    (transaction (tx_in-vector txin)
                 (tx_out-vector txout)
                 0)))

(defun transaction-id (obj)
  (double-sha256 (with-output-to-string (out)
                   (transaction-json obj out))))

(defun transaction-txouts-sum (tx)
  (let ((txouts (transaction-txouts tx))
        (sum 0))
    (dotimes (i (length txouts))
      (incf sum (tx_out-value (aref txouts i))))
    sum))

(defun transaction-validate_basics (obj &optional as-coinbase)
  (assert (and (< 0 (length (transaction-txouts obj)))
               (or (< 0 (length (transaction-txins obj)))
                   as-coinbase)))
  (assert (< (length (with-output-to-string (out)
                       (transaction-json obj out)))
             (param max_block_serialized_size)))
  (assert (<= (transaction-txouts-sum obj) (param max_money))))


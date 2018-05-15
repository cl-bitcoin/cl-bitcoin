;; cl-bitcoin - Peer to peer money
;; Copyright 2018 Thomas de Grivel <thoxdg@gmail.com> 0614550127

(in-package :cl-bitcoin)

(defvar *genesis_block*
  (let* ((txin (tx_in nil
                      (bytes 0)
                      (bytes)
                      0))
         (txout (tx_out 5000000000
                        "143UVyz7ooiAv1pMqbwPPpnH4BV9ifJGFF"))
         (tx (transaction (tx_in-vector txin)
                          (tx_out-vector txout)
                          0)))
    (block
        0
      ""
      "7118894203235a955a908c0abfc6d8fe6edec47b0a04ce1bf7263da3b4366d22"
      1501821412
      24
      10126761
      (transaction-vector tx))))

(defvar *active_chain* `(,*genesis_block*))

(defvar *side_branches* ())

(defvar *orphan_blocks* ())

(defvar *active_chain_idx* 0)

(defun get_current_height ()
  (length *active_chain*))

(defmacro do-chain ((tx-var block-var height-var) chain &body body)
  (let ((g-chain (gensym "CHAIN-"))
        (g-height (gensym "HEIGHT-")))
    `(let* ((,g-chain ,chain)
            (,g-height (length ,g-chain)))
       (dolist (,block-var ,g-chain)
         (decf ,g-height)
         (map nil (lambda (,tx-var)
                    (let ((,height-var ,g-height))
                      ,@body))
              (block-txns ,block-var))))))

(defun locate_block (hash &optional (chain (list* *active_chain*
                                                  *side_branches*)

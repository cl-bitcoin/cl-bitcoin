;; cl-bitcoin copyright Thomas de Grivel <thoxdg@gmail.com> 0614550127

(in-package :cl-bitcoin)

(defvar *params*
  (make-hash-table))

(defmacro param (name &optional value)
  (if value
      `(let ((val (gethash ',name *params*))
             (value ,value))
         (assert (or (null val)
                     (equal val value)))
         (setf (gethash ',name *params*) value))
      `(gethash ',name *params*)))

(param max_block_serialized_size 1000000)
(param coinbase_maturity 100)
(param max_future_block_time (* 60 60 2))
(param satoshis_per_coin 100000000)
(param total_coins 21000000)
(param max_money (* (param satoshis_per_coin) (param total_coins)))
(param time_between_blocks_in_secs_target 600)
(param difficulty_period_in_secs_target (* 10 2016))
(param difficulty_period_in_blocks
       (floor (param difficulty_period_in_secs_target)
              (param time_between_blocks_in_secs_target)))
(param initial_difficulty_bits 24)
(param halve_subsidy_after_blocks_num 210000)

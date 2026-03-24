;;; -*- Mode: LISP; Syntax: ANSI-Common-lisp; Package: STAT-GENERICS -*-
;;; Copyright (c) 2026 by Symbolics Pte. Ltd. All rights reserved.
;;; SPDX-License-identifier: MS-PL

;;; Julia-style weight types and weighted statistics via CLOS

(in-package #:stat-generics)

(defclass weights ()
  ((values :initarg :values
           :reader  weight-values
           :type    vector
           :documentation "The weight vector.")
   (sum    :initarg :sum
           :reader  weight-sum
           :type    real
           :documentation "Cached sum of weights."))
  (:documentation "Abstract base class for all weight types."))

(defmethod initialize-instance :after ((w weights) &key &allow-other-keys)
  "Coerce values to a vector and compute the weight sum."
  (let ((v (coerce (slot-value w 'values) 'vector)))
    (setf (slot-value w 'values) v
          (slot-value w 'sum)    (reduce #'+ v))))

(defclass frequency-weights (weights) ()
  (:documentation
   "Integer frequency/count weights (e.g. repeated observations).
    Correction denominator: Σw - 1"))

(defclass analytic-weights (weights) ()
  (:documentation
   "Analytic / reliability weights (e.g. inverse-variance weights).
    Correction denominator: Σw - Σ(w²)/Σw"))

(defclass probability-weights (weights) ()
  (:documentation
   "Sampling probability weights.
    Correction denominator: Σw · (n-1)/n   [i.e. the n/(n-1) Bessel analog]"))

;; Wrappers for brevity
(defun fweights (w) (make-instance 'frequency-weights   :values w))
(defun aweights (w) (make-instance 'analytic-weights    :values w))
(defun pweights (w) (make-instance 'probability-weights :values w))


;;; The key generic: correction-denominator
;;; This is what differs between weight types — everything else is the same.

(defgeneric correction-denominator (weights n)
  (:documentation
   "Return the denominator used in the bias-corrected weighted variance for a sample of size N.  Specialise this to add new weight types."))

(defmethod correction-denominator ((w frequency-weights) n)
  (declare (ignore n))
  (- (weight-sum w) 1))			;equivalent to dividing by (1- total_count)

(defmethod correction-denominator ((w analytic-weights) n)
  (declare (ignore n))
  (let* ((wv (weight-values w))
         (sw (weight-sum w))
         (sw2 (loop for wi across wv sum (* wi wi)))) ;V1 - V2/V1  where V1=Σw, V2=Σw²
    (- sw (/ sw2 sw))))

(defmethod correction-denominator ((w probability-weights) n)
  (* (weight-sum w) (/ (1- n) n)))	;analogous to Bessel's (/ n (1- n)), but in the weighted case


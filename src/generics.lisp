;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: STAT-GENERICS -*-
;;; Copyright (c) 2026 by Symbolics Pte. Ltd. All rights reserved.
;;; SPDX-License-identifier: MS-PL

(in-package #:stat-generics)

(defgeneric mean (object &key &allow-other-keys)
  (:documentation "Mean of OBJECT. Accepts :weights for weighted computation."))

(defgeneric variance (object &key &allow-other-keys)
  (:documentation "Variance of OBJECT. Accepts :weights, :corrected and :mean"))

(defgeneric standard-deviation (object &key &allow-other-keys)
  (:documentation "Standard deviation of OBJECT.
   Accepts :weights, :corrected, :mean — same semantics as VARIANCE."))

(defgeneric quantile (object q &key weights &allow-other-keys)
  (:documentation "Quantile Q of OBJECT.
   :WEIGHTS is a sequence or WEIGHTS object of matching length.
   For distributions, weights are not applicable and should be NIL."))

(defgeneric quantiles (object qs &key weights &allow-other-keys)
  (:documentation "Multiple quantiles QS of OBJECT.
   Prefer defining methods on QUANTILES rather than QUANTILE."))

(defgeneric median (object &key weights &allow-other-keys)
  (:documentation "Median of OBJECT.")
  (:method (object &key weights &allow-other-keys)
    (quantile object 1/2 :weights weights)))

(defgeneric mode (object &key &allow-other-keys)
  (:documentation "Most frequent element of OBJECT.
   If several modes exist, returns the first in order of appearance.  See MODES for all modes."))

(defgeneric modes (object &key &allow-other-keys)
  (:documentation "All most frequent elements of OBJECT, returned as a sequence in order of appearance."))

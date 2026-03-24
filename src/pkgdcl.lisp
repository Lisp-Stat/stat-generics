;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: CL-USER -*-
;;; Copyright (c) 2026 by Symbolics Pte. Ltd. All rights reserved.
;;; SPDX-License-identifier: MS-PL

(uiop:define-package #:stat-generics
  (:use #:cl)
  (:documentation "Generic statistical functions")
  (:export #:mean			;arithmetic mean
	   #:median			;median value
	   #:quantile			;quantiles, including quartiles, etc.
	   #:quantiles			;quantiles, including quartiles, etc.
	   #:standard-deviation		;sample standard deviation
	   ;; #:sdm			;sd with known mean
	   #:variance			;variance
	   #:median
	   #:mode			;most frequent element
	   #:modes			;all most frequent elements

	   ;; Julia-style weight classes
	   #:weights
	   #:frequency-weights
	   #:analytic-weights
	   #:probability-weights))

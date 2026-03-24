;;; -*- Mode: LISP; Syntax: ANSI-Common-lisp; Package: ASDF -*-
;;; Copyright (c) 2026 by Symbolics Pte. Ltd. All rights reserved.
;;; SPDX-License-identifier: MS-PL

(defsystem "stat-generics"
  :name "Stat-Generics"
  :version "1.0.0"
  :license :MS-PL
  :author "Steve Nunez <steve@symbolics.tech>"
  :description "Generic function definitions for statistical operations"
  :long-description "Generic function definitions for statistical operations"
  :homepage "https://lisp-stat.dev/"
  :source-control (:git "https://github.com/Lisp-Stat/stat-generics.git")
  :bug-tracker "https://github.com/Lisp-Stat/stat-generics/issues"
  :pathname "src/"
  :components ((:file "pkgdcl")
	       (:file "weights")
	       (:file "generics"))
  :in-order-to ((test-op (test-op "stat-generics/tests"))))

;;; Any sense in testing generic functions?
#+nil
(defsystem "stat-generics/tests"
  :description "Tests for stat-generics"
  :depends-on ("stat-generics"
               "clunit2")
  :pathname "tests/"
  :components ((:file "test-package")
	       (:file "definitions"))
  :perform (test-op (o s)
             (uiop:symbol-call :stat-generics-tests :run-tests)))

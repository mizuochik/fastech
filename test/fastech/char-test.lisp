(defpackage :fastech.char-test
  (:use :cl
        :cl-test-more)
  (:import-from :fastech
                :parse
                :parse-failed
                :chr
                :any-char
                :str
                :satisfy)
  (:import-from :fastech.test-helper
                :is-parsed
                :is-parse-failed))
(in-package :fastech.char-test)

(plan 9)

(diag "chr")
(is-parsed (chr #\a) "abc"
           #\a "bc"
           "parses a char")
(is-parse-failed (chr #\a) "foo"
                 "foo" "chr"
                 "fails parsing invalid input")

(diag "any-char")
(is-parsed (any-char) "foo"
           #\f "oo"
           "parses an any char")
(is-parse-failed (any-char) ""
                 "" "ensure: end of input"
                 "fails parsing the empty input")

(diag "str")
(is-parsed (str "foo") "foobar"
           "foo" "bar"
           "parses a string")
(is-parse-failed (str "foo") "barfoo"
                 "barfoo" "str"
                 "fails parsing invalid input")
(is-parse-failed (str "foo") ""
                 "" "ensure: end of input"
                 "fails parsing invalid input")

(diag "satisfy")
(flet ((pred (char)
         (eq char #\a)))
  (is-parsed (satisfy #'pred) "abc"
             #\a "bc"
             "parses the satisfied char")
  (is-parse-failed (satisfy #'pred) "bac"
                   "bac" "satisfy"
                   "fails parsing the unsatisfied char"))

(finalize)

;;;; package.lisp

(defpackage #:cl-spatial-hash-grid
  (:use #:cl)
  (:export
   #:make-spatial-hash-grid
   #:shg-insert
   #:shg-remove
   #:shg-find
   #:make-entity
   #:entity-bounds))

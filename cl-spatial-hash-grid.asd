;;;; cl-spatial-hash-grid.asd

(asdf:defsystem #:cl-spatial-hash-grid
  :description "Implementation of a spatial hash grid."
  :author "Timo Netzer <exodiquas@gmail.com>"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :depends-on ("alexandria")
  :components ((:file "package")
	       (:file "src/entity")
	       (:file "src/grid")
	       (:file "src/utility"))
  :in-order-to ((asdf:test-op (asdf:test-op "cl-spatial-hash-grid/tests"))))

(asdf:defsystem "cl-spatial-hash-grid/tests"
  :depends-on ("cl-spatial-hash-grid" "fiveam")
  :components ((:file "test/grid"))
  :perform (asdf:test-op (o c) (uiop:symbol-call :fiveam '#:run! :shg-tests)))

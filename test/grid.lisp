(in-package :cl-spatial-hash-grid)
(fiveam:def-suite shg-tests)
(fiveam:in-suite shg-tests)

(defun create-shg-and-insert (size loc dim)
  (let ((shg (make-spatial-hash-grid size))
	(ent (make-entity loc dim)))
    (shg-insert shg ent)
    shg))

(defun hash-keys (hash-table)
  (loop for key being the hash-keys of hash-table collect key))

(fiveam:test grid-insert
  "Test the insert method of a spatial hash grid."
  (let ((t0 (shg-cells (create-shg-and-insert 1 '(1.9 2.5) '(0.3 0.3))))
	(t1 (shg-cells (create-shg-and-insert 1 '(0.4 0.4) '(0.1 0.1))))
	(t2 (shg-cells (create-shg-and-insert 5 '(0.4 0.4) '(0.1 0.1))))
	(t3 (shg-cells (create-shg-and-insert 1 '(0 0) '(1 1))))
	(t4 (shg-cells (create-shg-and-insert 1 '(5 5) '(1 1))))
	(t5 (shg-cells (create-shg-and-insert 5 '(0 0) '(1 1)))))
    (fiveam:is (not (set-difference '((1 2) (2 2)) (hash-keys t0) :test 'equal)))
    (fiveam:is (not (set-difference '((0 0)) (hash-keys t1) :test 'equal)))
    (fiveam:is (not (set-difference '((0 0)) (hash-keys t2) :test 'equal)))
    (fiveam:is (= 2 (hash-table-count t0)))
    (fiveam:is (= 1 (hash-table-count t1)))
    (fiveam:is (= 1 (hash-table-count t2)))
    (fiveam:is (= 9 (hash-table-count t3)))
    (fiveam:is (= 9 (hash-table-count t4)))
    (fiveam:is (= 4 (hash-table-count t5)))))

(fiveam:run!)

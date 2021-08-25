;;;; grid.lisp

(in-package #:cl-spatial-hash-grid)

(defclass spatial-hash-grid ()
  ((cell-size :accessor shg-cell-size
	      :initarg :cell-size
	      :initform (error "No cell-size given while creating a spatial hash grid. Please use the initarg :cell-size to do so.")
	      :type integer)
   (cells :accessor shg-cells
	  :initform (make-hash-table :test 'equal))))

(defun make-spatial-hash-grid (cell-size)
  "Create a new spatial hash grid with a given CELL-SIZE."
  (make-instance 'spatial-hash-grid :cell-size cell-size))

(defun rollover-down (n)
  "Floors N, but if N is an integer this function returns N - 1."
  (if (integerp n)
      (1- n)
      (floor n)))

(defmethod shg-hashing ((shg spatial-hash-grid) (x real) (y real))
  "This is not really a hash function, it is more of a key generator for a given X and Y input. This method reutns a list (X' Y') where X' and Y' are the inputs coordinates in 2D divided by the CELL-SIZE of the SHG."
  (list (floor (floor x) (shg-cell-size shg))
	(floor (floor y) (shg-cell-size shg))))

(defmethod shg-insert ((shg spatial-hash-grid) (e entity))
  "Insert an entity E into the spatial hash grid SHG, if the entity spans a bigger area than the CELL-SIZE of the spatial hash grid SHG, the entity E gets inserted in every cell it spans."
  (let* ((x-start (rollover-down (first (entity-location e)))) ; 1
	 (y-start (rollover-down (second (entity-location e)))) ; 2
	 (x-end (floor (+ (first (entity-location e)) (first (entity-dimensions e)))))
	 (y-end (floor (+ (second (entity-location e)) (second (entity-dimensions e))))))
    (loop for x from x-start upto x-end do
      (loop for y from y-start upto y-end do
	(let ((k (shg-hashing shg x y)))
	  (push e (gethash k (shg-cells shg))))))))

(defun testo ()
  (let ((shg (make-spatial-hash-grid 1))
	(e (make-entity '(1.9 2.5) '(0.3 0.3))))
    (shg-insert shg e)
    shg))

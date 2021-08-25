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

(defmethod shg-hashing ((shg spatial-hash-grid) (x real) (y real))
  "This is not really a hash function, it is more of a key generator for a given X and Y input. This method reutns a list (X' Y') where X' and Y' are the inputs coordinates in 2D divided by the CELL-SIZE of the SHG."
  (list (floor (floor x) (shg-cell-size shg))
	(floor (floor y) (shg-cell-size shg))))

(defmethod shg-insert ((shg spatial-hash-grid) (e entity))
  "Insert an entity E into the spatial hash grid SHG, if the entity spans a bigger area than the CELL-SIZE of the spatial hash grid SHG, the entity E gets inserted in every cell it spans."
  (multiple-value-bind (x-start x-end y-start y-end) (entity-bounds e)
    (loop for x from x-start upto x-end do
      (loop for y from y-start upto y-end do
	(let ((k (shg-hashing shg x y)))
	  (push e (gethash k (shg-cells shg))))))))

(defmethod shg-remove ((shg spatial-hash-grid) (e entity))
  "Removes a given entity from the SHG, this method removes every occurence of the entity E from every bucket in SHG."
  (multiple-value-bind (x-start x-end y-start y-end) (entity-bounds e)
    (loop for x from x-start upto x-end do
      (loop for y from y-start upto y-end do
	(let ((k (shg-hashing shg x y)))
	  (remhash k (shg-cells shg)))))))

(defmethod shg-find ((shg spatial-hash-grid) (loc list) (dim list))
  "Finds every entity inside the given bounding box. Where LOC is a list (X Y) where X and Y represent the bottom left corner of the bounding box and DIM is a list (W H) where W determines the height of the box and W determines the width. 
!! This bad boy could be improved by a lot I think. !!"
  (let ((results (multiple-value-bind (x-start x-end y-start y-end) (bounds loc dim)
		   (loop for x from x-start upto x-end append
						       (loop for y from y-start upto y-end collect
											   (let ((k (shg-hashing shg x y)))
											     (gethash k (shg-cells shg))))))))
    (hash-keys (uiop:list-to-hash-set (alexandria:flatten results)))))



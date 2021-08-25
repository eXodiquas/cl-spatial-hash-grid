;;;; entity.lisp

(in-package #:cl-spatial-hash-grid)

(defclass entity ()
  ((location :accessor entity-location
	     :initarg :location
	     :initform '(0 0)
	     :documentation "The location (x y) of the entity in the world.")
   (dimensions :accessor entity-dimensions
	       :initarg :dimensions
	       :initform '(1 1)
	       :documentation "The dimensions (width heigth) of the entity in the world."))
  (:documentation "Parent class for data the user wants to store in the hash grid. If you want an object to get stored in the spatial hash grid, you have to inherit from this entity class."))

(defun make-entity (loc dim)
  (make-instance 'entity :location loc :dimensions dim))

(defmethod entity-bounds ((e entity))
  "Calculates the indices of the buckets this entity spans with its position and dimensions."
  (bounds (entity-location e) (entity-dimensions e)))

(in-package #:cl-spatial-hash-grid)

(defun rollover-down (n)
  "Floors N, but if N is an integer this function returns N - 1."
  (if (integerp n)
      (1- n)
      (floor n)))

(defun bounds (loc dim)
  (let* ((x-start (rollover-down (first loc)))
	 (y-start (rollover-down (second loc)))
	 (x-end (floor (+ (first loc) (first dim))))
	 (y-end (floor (+ (second loc) (second dim)))))
    (values x-start x-end y-start y-end)))

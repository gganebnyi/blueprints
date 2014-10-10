;; Local Variables:
;; eval: (slime-eval-on-save)
;; End:
(load "../opensexp.lisp")

; TODO: need to adjust these so when scaled up to inches later, they
; are right...
(defvar *cutter-radius* .2)
(defvar *cutter-depth* .250)
(defvar *cutter* (scad:cylinder *cutter-radius* *cutter-depth*))
(defvar *backplate-thickness* .250)

;; define the shape in relative terms, then scale it to be
;; absolute. the only problem is the relative width/depth of the
;; cutter.
(defun slider ()
  (scad:difference
   (scad:translate 0 -.5 (* -1 (+ *backplate-thickness* .01))
				   (scad:cube 23 7 (+ *backplate-thickness* *cutter-depth*)))
   (scad:translate 10 -1 0 (scad:cube 6 8 *cutter-depth*))
   (scad:translate 0 *cutter-radius* 0
				   (scad:mill '((0 0) 
								(6 0) 
								(9 3) 
								(11 3) 
								(18 2) 
								(22 0) 
								(23 0))
							  *cutter*)
				   (scad:mill '((0 6) 
								(6 6) 
								(9 3) 
								(11 3) 
								(18 4) 
								(22 6) 
								(23 6))
							  *cutter*))))

(defun carry ()
  (scad:difference
   (scad:translate 0 -.5 (* -1 (+ *backplate-thickness* .01))
				   (scad:cube 23 15 (+ *backplate-thickness* *cutter-depth*)))
   (scad:translate 6 -1 0 (scad:cube 6 17 *cutter-depth*))
   (scad:translate 18 -1 0 (scad:cube 6 17 *cutter-depth*))
   (scad:translate 0 *cutter-radius* 0 
	(scad:mill '((0 0)
				 (6 0))
			   *cutter*)
	(scad:mill '((0 3)
				 (6 3))
			   *cutter*)
	(scad:mill '((0 6)
				 (1 6)
				 (5 9)
				 (6 9))
			   *cutter*)
	(scad:mill '((0 9)
				 (1 9)
				 (5 12)
				 (6 12))
			   *cutter*)
	(scad:mill '((12 3)
				 (13 3)
				 (16 2)
				 (18 2))
			   *cutter*)
	(scad:mill '((12 6)
				 (13 6)
				 (16 7)
				 (18 7))
			   *cutter*)
	(scad:mill '((12 9)
				 (13 9)
				 (16 8)
				 (18 8))
			   *cutter*)
	(scad:mill '((12 12)
				 (13 12)
				 (16 14)
				 (18 14))
			   *cutter*))))

(scad:emit
 (slider)
 :file "/home/dr/software/blueprints/3D/openscad/longnow/slider.scad"
 :fn 20)

(scad:emit
 (carry)
 :file "/home/dr/software/blueprints/3D/openscad/longnow/carry.scad"
 :fn 20)
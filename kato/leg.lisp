
(defparameter prep 
  '((dotimes (sheet-index 3) 
      (place paper 8-and-a-half-by-11 paper on desk in landscape)
      (place vertical inch ruler(0 0) to paper:(~1 0) cartesian)
      (make tick at (2 4 6 8) and paper ends at 8.5)
      (place ruler(0 0) in same rotation at paper:(~10 0))
      (make tick at (2 4 6 8) and paper ends at 8.5)
      (rotate rule into horizontal)
      (line up ruller foreach of the 4 pairs of ticks and draw line)
      (dolist (a-line ('top-line 'bottom-line))
	(place ruler on a-line with ruler origin at (0 line-y))
	(make ticks every inch until 10 ticks))
      (flip-ruler :verticle)
      (draw line through dashes)
      (rotate and cut vertically into 4 long segments)
      (dotimes (unit-index 4)
       (with sliver-of-paper
	     (dotimes 4 #'fold)
	     (cut-next-unfolded line)
	     (overlap both ends of folded paper)
	     (glue overlap))))))



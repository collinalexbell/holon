(require 'cl-opengl)
(require 'cl-glu)
(require 'lispbuilder-sdl)
 
(defconstant +window-width+  600)
(defconstant +window-height+ 600)
 
(defconstant +cube-vertices+
  #(#(0 0 0)
    #(0 1 0)
    #(1 1 0)
    #(1 0 0)
    #(0 0 1)
    #(0 1 1)
    #(1 1 1)
    #(1 0 1)))
 
(defconstant +cube-faces+
  '((#(4 7 6 5) #(0 0 1))
    (#(5 6 2 1) #(0 1 0))
    (#(1 2 3 0) #(0 0 -1))
    (#(0 3 7 4) #(0 -1 0))
    (#(4 5 1 0) #(-1 0 0))
    (#(3 2 6 7) #(1 0 0))))
 
(defun draw-figure (verts faces)
  (labels ((set-normal (n)
             (gl:normal (aref n 0) (aref n 1) (aref n 2)))
           (set-vertex (index)
             (let ((v (aref verts index)))
               (gl:vertex (aref v 0) (aref v 1) (aref v 2))))
           (draw-face (vertex-indices normal)
             (set-normal normal)
             (gl:begin :quads)
             (map 'nil #'set-vertex vertex-indices)
             (gl:end)))
 
    (map 'nil #'(lambda (x) (draw-face (first x) (second x))) faces)))
 
 
(defun draw-frame (rotx roty rotz)
  (gl:matrix-mode :modelview)
  (gl:push-matrix)
  (gl:translate 0.5 0.5 0.5)
  (gl:rotate rotx 1 0 0)
  (gl:rotate roty 0 1 0)
  (gl:rotate rotz 0 0 1)
  (gl:translate -0.5 -0.5 -0.5)
  (draw-figure +cube-vertices+ +cube-faces+)
  (gl:pop-matrix))
   
 
(defun start ()
  (let ((rotx 0)
        (roty 0)
        (rotz 0))
    (sdl:with-init ()
      (sdl:window +window-width+ +window-height+ 
                  :opengl t
                  :opengl-attributes '((:sdl-gl-depth-size   16)
                                       (:sdl-gl-doublebuffer 1)))
      (setf (sdl:frame-rate) 10)
 
      (gl:viewport 0 0 +window-width+ +window-height+)
      (gl:matrix-mode :projection)
      (gl:load-identity)
      (glu:perspective 50 (/ +window-height+ +window-width+) 1.0 10.0)
      (glu:look-at -2 2 4 
                    0.5 0.5 0.5 
                    0 1 0)
 
      (gl:matrix-mode :modelview)
      (gl:load-identity)
 
      (gl:clear-color 0 0 0 0)
      (gl:shade-model :flat)
      (gl:cull-face :back)
      (gl:polygon-mode :front :fill)
      (gl:draw-buffer :back)
      (gl:material :front :ambient-and-diffuse #(0.7 0.7 0.7 0.4))
      (gl:light :light0 :position #(0 0 1 0))
      (gl:light :light0 :diffuse #(1 0 0 0))
      (gl:light :light1 :position #(-1 2 -0.5 0))
      (gl:light :light1 :diffuse #(0 1 0 0))
      (gl:enable :cull-face :depth-test
                 :lighting :light0 :light1)
 
      (gl:clear :color-buffer :depth-buffer)
      (draw-frame rotx roty rotz)
      (sdl:update-display)
 
      (sdl:with-events ()
        (:quit-event () t)
        (:video-expose-event () (sdl:update-display))
        (:idle
          (setq rotx (mod (+ rotx 2.5) 360.0))
          (setq roty (mod (+ roty 0.7) 360.0))
          (setq rotz (mod (+ rotz 4.4) 360.0))
          (gl:clear :color-buffer :depth-buffer)
          (draw-frame rotx roty rotz)
          (sdl:update-display))))))

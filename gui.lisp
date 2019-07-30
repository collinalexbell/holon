(defpackage :holon.gui
  (:use :cl :gtk :gdk :gdk-pixbuf :gobject :glib :gio :pango :cairo))

(in-package :holon.gui)

(defun alert (msg)
  (gtk-run
   (within-main-loop
     (let (;; Create a toplevel window.
           (window (gtk-window-new :toplevel)))
       ;; Signal handler for the window to handle the signal "destroy".
       (g-signal-connect window "destroy"
                         (lambda (widget)
                           (declare (ignore widget))
                           (leave-gtk-main)))
       ;; Show the window.
       (gtk-container-add window (gtk-label-new msg))
       (gtk-widget-show-all window)))))

(defmacro gtk-run (&rest body)
  `(sb-int:with-float-traps-masked
       (:divide-by-zero)
     ,@body))

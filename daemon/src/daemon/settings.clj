(ns daemon.settings)

(def data
 {:width (ref 200)
  :height (ref 300)
  :face-image-width 1024
  :face-image-height 600
  :voice-engine :watson
  :frame-rate (ref 20)
  :animation-frame-rate 2
  :available-emotions [:happy :sad :determined :confused :exuberant]
  :face-animation-folder "face_animations"
  :todo-file "resources/todo.org"})





















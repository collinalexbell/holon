(ns dameon.face.emotion-animation-test.clj
  (use clojure.test)
  (require [dameon.face.emotion-animation :as subject]
           [quil.core :as q]
           [quil.middleware :as m]))

(deftest generate-animation-file-paths
  (is (= "happy/emotion.png" (:emotion-loop-path (subject/get-full-file-paths "happy"))));param without trailing slash
  (is (= "happy/neutral_to_emotion.png" (:neutral-to-emotion-path (subject/get-full-file-paths "happy/"))));2nd file. with trailing /
  (is (= "happy/emotion_to_neutral.png" (:emotion-to-neutral-path (subject/get-full-file-paths "happy/"))));param without trailing slash
  ) 

(run-tests)











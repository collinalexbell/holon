(ns daemon.core-test
  (:require [clojure.test :refer :all]
            [daemon.core :refer :all]
            [daemon.brochas-area.core :as brochas-area]
            [daemon.voice.core :as voice]
            [daemon.temporal-lobe.core :as temporal-lobe]
            [daemon.face.core :as face]))


;;Features to test
;;;Voice recognition
(deftest interpret-speech []
  (is
   (= "This is a test."
    (brochas-area/get-words-from-api-result
     @(brochas-area/interpret-speech (brochas-area/slurp-bytes "resources/test/test-interpret-speech.wav"))))))

(deftest meditation []
  (voice/speak "Testing meditations. You should hear 2 test meditations with 10 seconds in between.")
  (Thread/sleep 5000)
  (temporal-lobe/meditate "30" ["the beauty of clojure" "the beauty of nature"]))

(deftest destroy-and-create-screen []
  (.exit face/daemon-face)
  (Thread/sleep 2000)
  (face/create))

(deftest maximize-and-restore-screen []
  (face/maximize face/daemon-face)
  (Thread/sleep 5000)
  (face/restore face/daemon-face))

(interpret-speech)

(meditation)

(maximize-and-restore-screen)

(destroy-and-create-screen)
















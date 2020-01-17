(ns dameon.smart-atom-test
  (:require [clojure.test :refer :all]
            [dameon.smart-atom :as smart-atom]
            [clojure.spec :as s]))

(import '[org.opencv.core Mat]
        '[org.opencv.imgcodecs Imgcodecs])


(deftest smart-atom
  (let [a (smart-atom/create (Imgcodecs/imread "ramen.jpg"))]
    (is (s/valid? :dameon.smart-atom/smart-atom a))
    (is (s/valid? :dameon.smart-atom/live-smart-atom a))
    (is (not (.empty (smart-atom/deref a))))
    (let [b (smart-atom/copy a)
          del-a (smart-atom/delete a)]
      (is (not (s/valid? :dameon.smart-atom/live-smart-atom del-a)))
      (is (not (.empty (smart-atom/deref b))))
      (smart-atom/delete b)
      (is (.empty (smart-atom/deref b))))))

(run-tests)


















(ns daemon.smart-object) 


(import '[org.opencv.core Mat])

(defprotocol SmartObject
  (release [smart-obj]))

(defrecord SmartCVMat [obj counter]
  SmartObject
  (release [smart-obj]
    (.release (get smart-obj :obj))))

(defmulti create class)
(defmethod create Mat [obj]
  (->SmartCVMat obj 1))

(defn pointer-copied [smart-obj]
  (assoc smart-obj :counter (+ 1 (get smart-obj :counter))))

(defn pointer-deleted [smart-obj]
  (let [new-counter (-  (get smart-obj :counter) 1)]
    (if (= new-counter 0)
      ;;side-effect
      (release smart-obj)) 
     (assoc smart-obj :counter new-counter)))

(defn get-object [smart-obj]
  (get smart-obj :obj))



















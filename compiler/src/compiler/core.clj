(ns compiler.core
  (:require [clojure.java.shell :as sh]
            [clojure.test :refer [deftest is run-tests]]))


(defn compile [src dest]
  (sh/sh "nasm" "-f" "elf64"
         (str "buffer/" src)
         "-o" (str "buffer/" dest ".o"))
  (sh/sh "ld" "-s" (str "buffer/" dest ".o") "-o"  (str "buffer/" dest)))


(def registers
  {:general '((rax eax ax al)
              (rbx ebx bx bl)
              (rcx ecx cx cl)
              (rdx edx dx dl)
              (rsi esi si sil)
              (rdi edi di dil)
              (rbp ebp bp bpl)
              (rsp esp sp spl)
              (r8 r8d r8w r8b)
              (r9 r9d r9w r9b)
              (r10 r10d r10w r10b)
              (r11 r11d r11w r11b)
              (r12 r12d r12w r12b)
              (r13 r13d r13w r13b)
              (r14 r14d r14w r14b)
              (r15 r15d r15w r15b))})


(defn get-register [rtype nth-r size]
  (let [size-to-pos {64 0
                     32 1
                     16 2
                     8  3}]
    (when (= :notfound (get size-to-pos size :notfound))
      (throw (Exception. (str "size " size " is not valid for register"))))
    (-> registers
        (rtype)
        (nth nth-r)
        (nth (size-to-pos size)))))

(deftest get-register-test
  (is (= (get-register :general 0 16)) 'ax)
  (is (thrown? Exception (get-register :general 0 15))))

(ns compiler.core
  (:require [clojure.java.shell :as sh]))


(defn compile [src dest]
  (sh/sh "nasm" "-f" "elf64"
         (str "buffer/" src)
         "-o" (str "buffer/" dest ".o"))
  (sh/sh "ld" "-s" (str "buffer/" dest ".o") "-o"  (str "buffer/" dest)))


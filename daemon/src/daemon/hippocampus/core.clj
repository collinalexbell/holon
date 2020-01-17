(ns daemon.hippocampus.core
  (:use korma.db)
  (:require
   [clojure.edn :as edn :only [read-string]]))


(def creds ((edn/read-string (slurp "config/creds.edn")) :postgres))

(defdb db (postgres {:db "daemon"
                     :user (creds :user)
                     :password (creds :password)}))



















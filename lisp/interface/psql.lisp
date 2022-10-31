
(ql:quickload :postmodern)
(use-package :postmodern)

;(connect-toplevel "holon" "kuberlog" "" "localhost")
(connect-toplevel "api" "avisemaster" "sD9B62SsyD2ST0qx19Pc" "temporary-db-testing.cko3vpg0edsk.us-east-2.rds.amazonaws.com")


(query "select * from users")

;(query (:create-table 'files
                      ;((id :type integer :primary-key t :identity-always t)
                      ; (name :type string)
                      ; (language :type string)
                      ; (loc :type integer))))

(query "SELECT * from files")

(defmacro mk-table (name body)
  `(query (:create-table ,name
                         ,body)))

;; here is how it mk-table is used;
;(mk-table 'daemons ((name :type string)
;                    (purpose :type string)))

;;
;

;;
;

;(query "INSERT INTO files (name, language, loc) VALUES ('psql.lisp', 'lisp', 13)")
;(query "UPDATE files SET name='psql.lisp', language= 'lisp' ,loc=18")

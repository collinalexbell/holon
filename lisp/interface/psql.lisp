
(ql:quickload :postmodern)
(use-package :postmodern)

(connect-toplevel "holon" "kuberlog" "" "localhost")

(query "select * from users")

(query (:create-table 'files
                      ((id :type integer :primary-key t :identity-always t)
                       (name :type string)
                       (language :type string)
                       (loc :type integer))))

(query "SELECT * from files")

;(query "INSERT INTO files (name, language, loc) VALUES ('psql.lisp', 'lisp', 13)")
;(query "UPDATE files SET name='psql.lisp', language= 'lisp' ,loc=18")

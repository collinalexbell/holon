(defclass todo ()
  ((description :accessor todo-description
                :initarg :description)
   (priority :accessor todo-priority
             :initarg :priority
             :initform 0)
   (groups :accessor todo-groups
           :initarg :groups
           :initform 0)))


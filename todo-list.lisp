(in-package :todo)

(defclass todo-list ()
  ((todos :initform '()
	  :initarg :todos
	  :accessor .todos)
   (selected-todo :initform nil
		  :accessor .selected-todo)
   (selected-group :initform 'ALL
		   :accessor .selected-group)))

(defun remove-nth (n list)
  (declare
   (type (integer 0) n)
   (type list list))
  (if (or (zerop n) (null list))
      (cdr list)
      (cons (car list) (remove-nth (1- n) (cdr list)))))

(defun save-todos (&optional (file-name *global-save-file*))
  (cl-store:store *todo-list* file-name))

(defun save-and-redisplay ()
  (save-todos)
  (todos))

(defun delete-todos (&rest indicies)
  (loop for i in indicies do (setf *todo-list* (remove-nth i *todo-list*))))

(defun load-todos (&optional (file-name *global-save-file*))
  (setf *todo-list* (cl-store:restore file-name)))

(defun push-todo-and-re-sort (todo-instance)
  (push todo-instance *todo-list*)
  (setf *todo-list* (sort-by-priority *todo-list*)))

(defun group-constants ()
  (let ((todo-groups '(all)))
    (unless (eq *selected-group* 'all)
      (push *selected-group* todo-groups))
    todo-groups))

(defun add-todo (item &key (priority 0) (todo-groups '()) (parent nil))
  (setf todo-groups (append todo-groups (group-constants)))
  (push-todo-and-re-sort
   (new-todo item priority todo-groups parent))
  (save-and-redisplay))

(define-test add-todo-test
  (let ((*todo-list* '())
	(*selected-group* 'foo))
    (add-todo '(all i do is test) :todo-groups '(test))
    (true (find 'test (groups-in-todo-list)))
    (true (= 1 (length *todo-list*)))
    (true (find 'foo (todo-groups (first *todo-list*))))))

(defun add-templated-todos (fname)
  (with-open-file (f fname :direction :input)
    (loop for todo in (read f)
          do (add-todo todo :priority 9001 :todo-groups '(templated))))
  (todos))

(defun load-day-todos (day)
  (add-templated-todos
   (concatenate 'string
		"resources/"
		(string-downcase (symbol-name day))
		".todos")))

(defun sort-by-priority (l)
  (sort l
        (lambda (a b) (> (todo-priority a)
                         (todo-priority b)))))

(defvar *save-completed-todo* #'save-completed-todo)
(defun complete-todo (item)
  (accumulate-work-time *selected-todo*)
  (apply *save-completed-todo* `(,*selected-todo*))
  (gen-hook *selected-todo* 'complete)
  (delete-todo item))

(define-test t-complete-todo
  (let* ((*todo-list* '())
	 (*selected-todo* nil)
	 (*derp* nil)
	 (*save-completed-todo* #'(lambda (todo) (setf *derp* todo))))
    (declare (special *derp*))
    (add-todo '(all i do is win))
    (select 0)
    (complete-todo (first *todo-list*))
    (true (null *selected-todo*))
    (true (= 0 (length *todo-list*)))
    (true (equal (type-of *derp*) 'todo))))

(defun delete-todo (item)
  (setf *selected-todo* nil)
  (setf *todo-list*
        (delete item *todo-list* :test #'equal)))

(define-test t-delete-todo
  (let ((*todo-list* '())
	(*selected-todo* nil))
    (add-todo '(all i do is win))
    (select 0)
    (delete-todo (first *todo-list*))
    (true (null *selected-todo*))
    (true (= 0 (length *todo-list*)))))


(defun filter-todos-by-group (l g)
  (remove-if-not (lambda (t-d)
                   (find g (todo-groups t-d)))
                 l))

(defun groups-in-todo-list ()
  (let ((current-groups '()))
    (loop for todo in *todo-list*
          do (loop for group in (todo-groups todo)
                   do (setf current-groups
                            (adjoin group current-groups))))
    current-groups))

(defun select-todo (item)
  (if (find item *todo-list* :test #'equal)
      (progn (setf *selected-todo* item)
	     (gen-hook *selected-todo* 'select))
      (format t "Item does not exist in todo list")))

(define-test t-select-todo
  (let ((*todo-list* '())
	 (*selected-todo* nil))
     (add-todo '(become a millionaire))
     (select-todo (first *todo-list*))
    (true (equal '(become a millionaire) (todo-description
					  *selected-todo*)))))

(defun find-todo (description)
  (find description *todo-list*
	:test #'(lambda (item todo)
		  (if (equal item (todo-description todo)) t nil))))

(define-test t-find-todo
  (let* ((*todo-list* '()))
    (add-todo '(all i do is test))
    (true (equal
           '(all i do is test)
           (todo-description (find-todo '(all i do is test)))))
    (true (equal nil (find-todo '(this is not a todo))))))



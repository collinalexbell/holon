(in-package :holon.task)

(defclass task-list ()
  ((tasks :initform '()
	  :initarg :tasks
	  :accessor .tasks)
   (selected-task :initform nil
		  :accessor .selected-task)
   (selected-group :initform 'ALL
		   :accessor .selected-group)))

(defun yes-no (prompt)
  (format t prompt)
  (format t "~%Enter y/n to respond:")
  (eq 'y (read)))

(defun remove-nth (n list)
  (declare
   (type (integer 0) n)
   (type list list))
  (if (or (zerop n) (null list))
      (cdr list)
      (cons (car list) (remove-nth (1- n) (cdr list)))))

(defun save-tasks (&optional (file-name *global-save-file*))
  (cl-store:store (inferior-holons *selected-task*) file-name))

(defun redisplay ()
  (save-tasks)
  (tasks))

(defun delete-tasks (&rest indicies)
  (loop for i in indicies do (setf (inferior-holons *selected-task*) (remove-nth i (inferior-holons *selected-task*)))))

(defun push-task-and-re-sort (task-instance)
  (push task-instance (inferior-holons *selected-task*))
  (setf (inferior-holons *selected-task*)
	(sort-by-priority (inferior-holons *selected-task*))))

(defun group-constants ()
  (let ((task-groups '(all)))
    (unless (eq *selected-group* 'all)
      (push *selected-group* task-groups))
    task-groups))

(defun add-task (item &key (priority 0)
			(task-groups '())
			(parent *selected-task*))
  (setf task-groups (append task-groups (group-constants)))
  (push-task-and-re-sort
   (new-task item priority task-groups parent))
  (redisplay)
  (backup *root-task*))

(defun add-tasks (&optional (tasks '()))
  ;;tasks is a list of tasks
  (loop for task in tasks
        do (add-task task)))

(define-test add-task-test
  (let (((inferior-holons *selected-task*) '())
	(*selected-group* 'foo))
    (add-task '(all i do is test) :task-groups '(test))
    (true (find 'test (groups-in-task-list)))
    (true (= 1 (length (inferior-holons *selected-task*))))
    (true (find 'foo (task-groups (first (inferior-holons *selected-task*)))))))

(defun load-day-tasks (day)
  (add-templated-tasks
   (concatenate 'string
		"resources/"
		(string-downcase (symbol-name day))
		".tasks")))

(defun sort-by-priority (l)
  (sort l
        (lambda (a b) (> (task-priority a)
                         (task-priority b)))))

;(defvar *save-completed-task* #'save-completed-task)
(defvar *save-completed-task* (lambda () nil))
(defun complete-task (item)
  (accumulate-work-time *selected-task*)
  (cond
    ((eql *saved-task-backend* 'twitter)
     (apply #'twitter-save-completed-task `(,*selected-task*)))
    ((eql *saved-task-backend* 'txt)
     (txt-save-completed-task *selected-task*)))
  (gen-hook *selected-task* 'complete)
  (delete-task item))

(define-test t-complete-task
  (let* (((inferior-holons *selected-task*) '())
	 (*selected-task* nil)
	 (*derp* nil)
	 (*save-completed-task* #'(lambda (task) (setf *derp* task))))
    (declare (special *derp*))
    (add-task '(all i do is win))
    (select 0)
    (complete-task (first (inferior-holons *selected-task*)))
    (true (null *selected-task*))
    (true (= 0 (length (inferior-holons *selected-task*))))
    (true (equal (type-of *derp*) 'task))))

(defun delete-task (item)
  (setf *selected-task* (.parent *selected-task*))
  (setf (inferior-holons *selected-task*)
        (delete item (inferior-holons *selected-task*) :test #'equal)))

(define-test t-delete-task
  (let (((inferior-holons *selected-task*) '())
	(*selected-task* nil))
    (add-task '(all i do is win))
    (select 0)
    (delete-task (first (inferior-holons *selected-task*)))
    (true (null *selected-task*))
    (true (= 0 (length (inferior-holons *selected-task*))))))


(defun filter-tasks-by-group (l g)
  (remove-if-not (lambda (t-d)
                   (find g (task-groups t-d)))
                 l))

(defun groups-in-task-list ()
  (let ((current-groups '()))
    (loop for task in (inferior-holons *selected-task*)
          do (loop for group in (task-groups task)
                   do (setf current-groups
                            (adjoin group current-groups))))
    current-groups))

(defun select-task (item)
  (if (find item (inferior-holons *selected-task*) :test #'equal)
      (progn (setf *selected-task* item)
	     (gen-hook *selected-task* 'select))
      (format t "Item does not exist in task list")))

(define-test t-select-task
  (let (((inferior-holons *selected-task*) '())
	 (*selected-task* nil))
     (add-task '(become a millionaire))
     (select-task (first (inferior-holons *selected-task*)))
    (true (equal '(become a millionaire) (task-description
					  *selected-task*)))))

(defun find-task (description)
  (find description (inferior-holons *selected-task*)
	:test #'(lambda (item task)
		  (if (equal item (task-description task)) t nil))))

(define-test t-find-task
  (let* (((inferior-holons *selected-task*) '()))
    (add-task '(all i do is test))
    (true (equal
           '(all i do is test)
           (task-description (find-task '(all i do is test)))))
    (true (equal nil (find-task '(this is not a task))))))



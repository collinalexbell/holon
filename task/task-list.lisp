(in-package :task)

(defclass task-list ()
  ((tasks :initform '()
	  :initarg :tasks
	  :accessor .tasks)
   (selected-task :initform nil
		  :accessor .selected-task)
   (selected-group :initform 'ALL
		   :accessor .selected-group)))

(defun remove-nth (n list)
  (declare
   (type (integer 0) n)
   (type list list))
  (if (or (zerop n) (null list))
      (cdr list)
      (cons (car list) (remove-nth (1- n) (cdr list)))))

(defun save-tasks (&optional (file-name *global-save-file*))
  (cl-store:store *task-list* file-name))

(defun save-and-redisplay ()
  (save-tasks)
  (tasks))

(defun delete-tasks (&rest indicies)
  (loop for i in indicies do (setf *task-list* (remove-nth i *task-list*))))

(defun push-task-and-re-sort (task-instance)
  (push task-instance *task-list*)
  (setf *task-list* (sort-by-priority *task-list*)))

(defun group-constants ()
  (let ((task-groups '(all)))
    (unless (eq *selected-group* 'all)
      (push *selected-group* task-groups))
    task-groups))

(defun add-task (item &key (priority 0) (task-groups '()) (parent nil))
  (setf task-groups (append task-groups (group-constants)))
  (push-task-and-re-sort
   (new-task item priority task-groups parent))
  (save-and-redisplay))

(define-test add-task-test
  (let ((*task-list* '())
	(*selected-group* 'foo))
    (add-task '(all i do is test) :task-groups '(test))
    (true (find 'test (groups-in-task-list)))
    (true (= 1 (length *task-list*)))
    (true (find 'foo (task-groups (first *task-list*))))))

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

(defvar *save-completed-task* #'save-completed-task)
(defun complete-task (item)
  (accumulate-work-time *selected-task*)
  (apply *save-completed-task* `(,*selected-task*))
  (gen-hook *selected-task* 'complete)
  (delete-task item))

(define-test t-complete-task
  (let* ((*task-list* '())
	 (*selected-task* nil)
	 (*derp* nil)
	 (*save-completed-task* #'(lambda (task) (setf *derp* task))))
    (declare (special *derp*))
    (add-task '(all i do is win))
    (select 0)
    (complete-task (first *task-list*))
    (true (null *selected-task*))
    (true (= 0 (length *task-list*)))
    (true (equal (type-of *derp*) 'task))))

(defun delete-task (item)
  (setf *selected-task* nil)
  (setf *task-list*
        (delete item *task-list* :test #'equal)))

(define-test t-delete-task
  (let ((*task-list* '())
	(*selected-task* nil))
    (add-task '(all i do is win))
    (select 0)
    (delete-task (first *task-list*))
    (true (null *selected-task*))
    (true (= 0 (length *task-list*)))))


(defun filter-tasks-by-group (l g)
  (remove-if-not (lambda (t-d)
                   (find g (task-groups t-d)))
                 l))

(defun groups-in-task-list ()
  (let ((current-groups '()))
    (loop for task in *task-list*
          do (loop for group in (task-groups task)
                   do (setf current-groups
                            (adjoin group current-groups))))
    current-groups))

(defun select-task (item)
  (if (find item *task-list* :test #'equal)
      (progn (setf *selected-task* item)
	     (gen-hook *selected-task* 'select))
      (format t "Item does not exist in task list")))

(define-test t-select-task
  (let ((*task-list* '())
	 (*selected-task* nil))
     (add-task '(become a millionaire))
     (select-task (first *task-list*))
    (true (equal '(become a millionaire) (task-description
					  *selected-task*)))))

(defun find-task (description)
  (find description *task-list*
	:test #'(lambda (item task)
		  (if (equal item (task-description task)) t nil))))

(define-test t-find-task
  (let* ((*task-list* '()))
    (add-task '(all i do is test))
    (true (equal
           '(all i do is test)
           (task-description (find-task '(all i do is test)))))
    (true (equal nil (find-task '(this is not a task))))))



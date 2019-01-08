(in-package :holon)

;;; Will not run, macro `with-holon` not yet defined

(defun shower (human)
  (with-holon human
    (choose-post-shower-clothing)
    (get-towel)
    (get-washcloth)
    (enter-restroom)
    (turn-on-water)
    (get-undressed)
    (when (bladder-full human) (use-toilet))
    (get-into-shower)
    (stretch)
    (become-concious-of-the-water-on-skin)
    (wash-body (lather-washcloth))
    (wash-face)
    (wash-hair)
    (massage-head-for-increased-hair-growth)
    (towel-dry)
    (exit-shower)
    (get-dressed)
    (exit-restroom)))

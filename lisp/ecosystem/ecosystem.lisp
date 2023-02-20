(defpackage :holon.ecosystem)
(in-package :holon.ecosystem)


(defun holon-ecosystem ()
  '((code . (
             (holon . ((url . "https://github.com/kuberlog/holon")))
             (text . ((url . "https://github.com/kuberlog/text")
                      (description . "a simple text editor")
                      (usefulness-to-ecosystem . ("learning project"
                                                  "example of tdd"
                                                  "example of cli"
                                                  "minimal usefulness as an actual text editor"))))
             (choreo . ((url . "https://github.com/kuberlog/choreo")))))
    (daemons . (
                (simple-man . ((description . "simplest robot I can think of"))
                 )))
    (pictures . ())
    (videos . ((title . "the simplest mobile robot I can think of")))
    (writing . (
               (holon-book . ("https://github.com/kuberlog/holon/blob/master/book/holon.md" "A pretty poorly written and embarrasing essay, not really a book")
                )))
    (other-distributables . ())))

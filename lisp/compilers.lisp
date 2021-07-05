
(defun is-clonable (link)
  t)

(defun get-links (git-site)
  '())

(defun go-to-AwesomeCompilers-github ()
  (git-get "https://github.com/aalhour/awesome-compilers"))

(let ((links (filter #'is-clonable (get-links (go-to-AwesomeCompilers-github)))))
  (for link in links do
       (into-folder "/home/kuberlog/code/compilers"
                   (clone link))))

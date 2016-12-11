#!/usr/bin/sbcl --script

(defun join-strings (strs delim)
  (reduce (lambda (s1 s2) (concatenate 'string s1 delim s2)) strs))

(defun split-string (str delim-char)
  (loop for pos0 = -1 then pos1
        for pos1 = (position delim-char str :start (1+ pos0))
        collect (subseq str (1+ pos0) (or pos1 (length str)))
        while pos1))

(defun abbreviate-butlast (path)
  (maplist
   (lambda (part)
     (if (cdr part)
         (if (equal "" (car part)) "" (subseq (car part) 0 1))
         (car part)))
   path))

(defun abbreviate* (home-str cwd-str)
  (let* ((cwd-path (split-string cwd-str #\/))
         (home-path (split-string home-str #\/))
         (home-shortened (if (eql 0 (search home-path cwd-path :test #'equalp))
                             (cons "~" (nthcdr (length home-path) cwd-path))
                             cwd-path)))
    (join-strings (abbreviate-butlast home-shortened) "/")))

(defun abbreviate (cwd-str)
  (let* ((home-str (sb-ext:posix-getenv "HOME")))
    (cond ((equal cwd-str home-str) "~")
          ((equal cwd-str "/") "/")
          (t (abbreviate* home-str cwd-str)))))

(loop for cwd = (read-line *standard-input* nil 'end)
      until (eq cwd 'end)
      do (princ (format nil "~a~%" (abbreviate cwd))))

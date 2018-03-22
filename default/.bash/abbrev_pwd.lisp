#!/usr/bin/sbcl --script

(defun split-string (str delim-char)
  (loop for pos0 = -1 then pos1
        for pos1 = (position delim-char str :start (1+ pos0))
        collect (subseq str (1+ pos0) (or pos1 (length str)))
        while pos1))

(defun abbreviate-butlast (path)
  (loop for (item . rest) on path
        collect (if (and rest (> (length item) 1))
                    (subseq item 0 1)
                    item)))

(defun abbreviate* (home-str cwd-str)
  (let* ((cwd-path (split-string cwd-str #\/))
         (home-path (split-string home-str #\/))
         (home-shortened (if (eql 0 (search home-path cwd-path :test #'equalp))
                             (cons "~" (nthcdr (length home-path) cwd-path))
                             cwd-path)))
    (format nil "~{~A~^/~}" (abbreviate-butlast home-shortened))))

(defun abbreviate (cwd-str)
  (let* ((home-str (sb-ext:posix-getenv "HOME")))
    (cond ((equal cwd-str home-str) "~")
          ((equal cwd-str "/") "/")
          (t (abbreviate* home-str cwd-str)))))

(loop for line = (read-line nil nil nil)
      while line
      do (princ (abbreviate line)))

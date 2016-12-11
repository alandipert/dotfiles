#!/usr/bin/sbcl --script

(defun join-strings (strs delim)
  (if (eq 1 (length strs))
      (elt strs 0)
    (loop with str = (elt strs 0)
          for i from 1 to (1- (length strs))
          when (elt strs i)
          do (setq str (concatenate 'string str delim (elt strs i)))
          finally (return str))))

(defun split-string (str delim-char)
  (let* ((num-delims 2)
         (delim-idxs (loop with idxs = (list (length str))
                           for idx from (1- (length str)) downto 0
                           when (eq (elt str idx) delim-char)
                           do (setq idxs (cons idx idxs)
                                    num-delims (1+ num-delims))
                           finally (return (cons -1 idxs)))))
    (loop with parts = (make-array (1- num-delims) :fill-pointer 0)
          for idxs on delim-idxs by #'cdr
          for (x y) = idxs
          when y
          do (vector-push (subseq str (1+ x) y) parts)
          finally (return parts))))

(defun common-prefix? (path1 path2)
  (let* ((shorter (if (< (length path1) (length path2)) path1 path2))
         (longer  (if (eq path1 shorter) path2 path1)))
    (equalp (subseq longer 0 (length shorter)) shorter)))

(defun add-slashes (path)
  (if (equal (elt path 0) "~")
      (join-strings path "/")
    (join-strings path "/")))

(defun abbreviate-home! (home-path cwd-path)
  (when (common-prefix? home-path cwd-path)
    (setf (elt cwd-path 0) "~")
    (loop for i from 1 to (1- (length home-path))
          do (setf (elt cwd-path i) nil))))

(defun abbreviate-intermediate! (cwd-path &optional (size 1))
  (loop for i from 1 to (- (length cwd-path) 2)
        for item = (elt cwd-path i)
        when item
        do (setf (elt cwd-path i) (subseq item 0 size))))

(defun abbreviate (cwd-string)
  (let* ((cwd (split-string cwd-string #\/))
         (home-path (split-string (sb-ext:posix-getenv "HOME") #\/)))
    (cond ((equalp cwd home-path) "~")
          ((equal cwd-string "/") "/")
          (t (progn (abbreviate-home! home-path cwd)
                    (abbreviate-intermediate! cwd)
                    (add-slashes cwd))))))

(loop for cwd = (read-line *standard-input* nil 'end)
      until (eq cwd 'end)
      do (princ (format nil "~a~%" (abbreviate cwd))))

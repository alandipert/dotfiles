#!/bin/sh
":"; exec emacs --quick --script "$0" -- "$@" # -*- mode: emacs-lisp; lexical-binding: t; -*-

(require 'cl)

;; simple Clojure-style multimethod implementation. No hierarchies.

(defmacro defmulti (name dispatch-fn)
  `(progn
     (defun ,name (&rest args)
       (let* ((dispatch-val (apply (get ',name 'multi-dispatch-fn) args))
              (found-fn     (or (cl-gethash dispatch-val (get ',name 'multi-methods))
                                (get ',name 'multi-default-fn))))
         (if found-fn (apply found-fn args)
           (error "No dispatch function found for method %s, value %s" ',name dispatch-val))))
     (put ',name 'multi-default-fn nil)
     (put ',name 'multi-dispatch-fn ,dispatch-fn)
     (put ',name 'multi-methods (cl-make-hash-table :test #'equal))))

(defmacro defmethod (name dispatch-val args &rest body)
  `(let* ((fn (lambda ,args ,@body)))
     (if (eq ,dispatch-val :default)
         (put ',name 'multi-default-fn fn)
       (let ((tbl (get ',name 'multi-methods)))
         (cl-puthash ,dispatch-val fn tbl)))))

;; util

(defun rm (path)
  (message "Deleting %s..." path)
  (if (or (file-symlink-p path)
          (not (file-directory-p path)))
      (delete-file path)
    (delete-directory path t)))

(defun cp (src dest &optional options)
  (message "Copying %s to %s..." src dest)
  (let* ((cmd (concat "cp" (if options (concat " " options)))))
    (call-process-shell-command
     (format "%s '%s' '%s'" cmd src dest)
     nil
     0)))

;; default dotfile handlers

(cl-defstruct dotfile name src dest)

(defmulti clean-dotfile #'dotfile-name)

(defmethod clean-dotfile :default (dotfile)
  (let* ((dest (dotfile-dest dotfile)))
    (when (file-exists-p dest) 
      (rm dest))))

(defmulti install-dotfile #'dotfile-name)

(defmethod install-dotfile :default (dotfile)
  (let* ((src  (dotfile-src dotfile))
         (dest (dotfile-dest dotfile)))
    (cp src dest "-RT")))

;; customized dotfiles

(defmethod clean-dotfile "boot" (dotfile)
  (let* ((old-boot-profile (concat (dotfile-dest dotfile) "/profile.boot")))
    (when (file-exists-p old-boot-profile)
      (rm old-boot-profile))))

;; make initial dotfiles

(defun collect-dotfiles (dir)
  (cl-loop for f in (directory-files dir)
           when (not (string-prefix-p "." f))
           collect (make-dotfile :name f
                                 :src (concat dir "/" f)
                                 :dest (concat (getenv "HOME") "/." f))))

(setq dotfiles-dir (or (elt argv 1) "dotfiles"))
(message "Dotfiles directory is '%s'" dotfiles-dir)
(setq dotfiles (collect-dotfiles dotfiles-dir))

(dolist (dotfile dotfiles) (clean-dotfile dotfile))
(dolist (dotfile dotfiles) (install-dotfile dotfile))

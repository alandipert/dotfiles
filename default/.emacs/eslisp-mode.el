;;; eslisp-mode.el --- An emacs major mode for editing eslisp files.

(defconst eslisp-keywords-re
  (regexp-opt
   '("+" "-" "*" "/" "%" "&" "|" "<<" ">>" ">>>" "~" "&&" "||" "!" "==" "==="
     "!=" "!==" "<" ">" ">=" "<=" "+=" "-=" "*=" "/=" "%=" "<<=" ">>=" ">>>="
     "&=" "|=" "^=" "++" "--" "++_" "--_" "_++" "_--" "array" "object" "regex"
     "var" "." "get" "switch" "if" "?:" "while" "dowhile" "for" "forin" "break"
     "continue" "label" "lambda" "function" "return" "new" "debugger" "throw"
     "try" "seq" "block" "macro" "capmacro" "quote" "quasiquote" "unquote"
     "unquote-splicing")
   'words))

(defconst eslisp-keywords
  `(("<.*>" . font-lock-constant-face)
    ("#.*$" . font-lock-comment-face)
    ,eslisp-keywords-re
    ("\\?\\w+" . font-lock-variable-name-face)
    ("\"[^\"]*\"" . font-lock-string-face)
    ("'[^']*'" . font-lock-string-face)))

(define-derived-mode eslisp-mode lisp-mode
  "eslisp"
  :group 'esl-mode
  ;; Font-lock support
  (setq font-lock-defaults '(eslisp-keywords))
  (put 'function 'lisp-indent-function 1)
  (put 'lambda 'lisp-indent-function 1)
  (put 'macro 'lisp-indent-function 1)
  ;; Key maps
  ;;(define-key eslisp-mode-map (kbd "C-c C-x") 'whatever)
  )

(provide 'eslisp-mode)
;;; eslisp-mode.el ends here

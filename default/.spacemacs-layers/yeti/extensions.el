;;; extensions.el --- yeti Layer extensions File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq yeti-pre-extensions
      '(
        ;; pre extension names go here
        ))

(setq yeti-post-extensions
      '(yeti-mode
        ;; post extension names go here
        ))

;; For each extension, define a function yeti/init-<extension-name>
;;
(defun yeti/init-yeti-mode ()
  (use-package yeti-mode
    ;; :load-path "~/.spacemacs-layers/yeti/extensions"
    :mode "\\.yeti\\'"))
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package

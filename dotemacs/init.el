;;; init.el --- Literate Configuration Bootstrap -*- lexical-binding: t; -*-
;;; Commentary:
;; This file bootstraps the literate configuration from config.org

;;; Code:

;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Install use-package via straight
(straight-use-package 'use-package)

;; Configure use-package to use straight.el by default
(setq straight-use-package-by-default t)

;; Load org-mode early so we can tangle our config
(straight-use-package 'org)

;; Tangle and load the literate configuration
(let* ((config-org (expand-file-name "config.org" user-emacs-directory))
       (config-el (expand-file-name "config.el" user-emacs-directory))
       (config-org-modified (file-attribute-modification-time (file-attributes config-org)))
       (config-el-modified (if (file-exists-p config-el)
                               (file-attribute-modification-time (file-attributes config-el))
                             nil)))
  ;; Tangle if config.org is newer than config.el or if config.el doesn't exist
  (when (or (not config-el-modified)
            (time-less-p config-el-modified config-org-modified))
    (require 'org)
    (org-babel-tangle-file config-org config-el "emacs-lisp"))
  ;; Load the tangled configuration
  (load-file config-el))

;; Custom file (keep custom settings separate)
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(provide 'init)
;;; init.el ends here

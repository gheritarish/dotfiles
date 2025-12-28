;;; early-init.el --- Early initialization -*- lexical-binding: t; -*-
;;; Commentary:
;; Emacs 27+ loads this file before init.el, before GUI is initialized
;; and before package.el is initialized.

;;; Code:

;; Defer garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; Restore after startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024)
                  gc-cons-percentage 0.1)))

;; Disable package.el in favor of straight.el
(setq package-enable-at-startup nil)

;; Inhibit resizing frame
(setq frame-inhibit-implied-resize t
      frame-resize-pixelwise t)

;; Disable GUI elements early
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; Prevent the glimpse of un-styled Emacs by disabling these UI elements early
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message user-login-name
      inhibit-default-init t
      initial-major-mode 'fundamental-mode
      initial-scratch-message nil)

;; Ignore X resources
(advice-add #'x-apply-session-resources :override #'ignore)

;; Increase process output read limit for better LSP performance
(setq read-process-output-max (* 512 1024)) ;; 512kb

(provide 'early-init)
;;; early-init.el ends here

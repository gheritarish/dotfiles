;;; keybindings-helpers.el --- Helper functions for keybindings.el -*- lexical-binding: t; -*-
;;; Commentary:
;; This file provides wrapper and placeholder functions for keybindings
;; that reference functions which may not be available or need custom definitions.

;;; Code:

;;
;;; Recentf setup

;; Ensure recentf is available and autoload its commands
(autoload 'recentf-open-files "recentf" "Open recent files." t)
(with-eval-after-load 'recentf
  (recentf-mode 1))

;;
;;; Git timemachine

(defun git-timemachine-toggle ()
  "Toggle git-timemachine mode.
This is a wrapper that calls git-timemachine if the package is available."
  (interactive)
  (if (fboundp 'git-timemachine)
      (call-interactively 'git-timemachine)
    (if (and (require 'git-timemachine nil t)
             (fboundp 'git-timemachine))
        (call-interactively 'git-timemachine)
      (message "git-timemachine is not installed. Install it with: (package-install 'git-timemachine)"))))

;;
;;; Python / Ruff formatting

(defun ruff-format-import-buffer ()
  "Format imports in the current Python buffer using ruff.
This runs `ruff check --select I --fix' to organize imports."
  (interactive)
  (if (executable-find "ruff")
      (let* ((temp-file (make-temp-file "ruff-imports" nil ".py"))
             (content (buffer-string)))
        (unwind-protect
            (progn
              ;; Write buffer content to temp file
              (with-temp-file temp-file
                (insert content))
              ;; Run ruff on the temp file
              (shell-command-to-string
               (format "ruff check --select I --fix %s 2>&1"
                      (shell-quote-argument temp-file)))
              ;; Read back the formatted content
              (let ((formatted-content
                     (with-temp-buffer
                       (insert-file-contents temp-file)
                       (buffer-string))))
                ;; Replace buffer content if changed
                (unless (string= content formatted-content)
                  (erase-buffer)
                  (insert formatted-content)
                  (message "Imports formatted with ruff"))))
          ;; Clean up temp file
          (when (file-exists-p temp-file)
            (delete-file temp-file))))
    (message "ruff executable not found. Please install ruff: pip install ruff")))

(provide 'keybindings-helpers)
;;; keybindings-helpers.el ends here

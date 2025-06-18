;;; $DOOMDIR/config.el --- Summary -*- lexical-binding: t; -*-
;;; Commentary:

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;;; Code:
(setq user-full-name "telmar")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)

(setq doom-font (font-spec :family "FantasqueSansM Nerd Font" :size 13 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "FantasqueSansM Nerd Font" :size 13 :weight 'regular))


(custom-set-faces
 '(markdown-header-face ((t (:inherit doom-font :weight bold :family "FantasqueSansM Nerd Font"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.35))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.3))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.25))))
 '(markdown-header-face-4 ((t (:inherit markdown-header-face :height 1.2))))
 '(markdown-header-face-5 ((t (:inherit markdown-header-face :height 1.15))))
 '(markdown-header-face-6 ((t (:inherit markdown-header-face :height 1.1)))))

(custom-set-faces
 '(org-header-face ((t (:inherit doom-font :weight bold :family "FantasqueSansM Nerd Font"))))
 '(org-level-1 ((t (:inherit org-header-face :height 1.35))))
 '(org-level-2 ((t (:inherit org-header-face :height 1.3))))
 '(org-level-3 ((t (:inherit org-header-face :height 1.25))))
 '(org-level-4 ((t (:inherit org-header-face :height 1.2))))
 '(org-level-5 ((t (:inherit org-header-face :height 1.15))))
 '(org-level-6 ((t (:inherit org-header-face :height 1.1))))
 '(org-level-7 ((t (:inherit org-header-face :height 1.1))))
 '(org-level-8 ((t (:inherit org-header-face :height 1.1)))))

(remove-hook! 'doom-first-buffer-hook #'smartparens-global-mode)

;; cursor
(setq-default evil-insert-state-cursor 'box)
(setq-default evil-replace-state-cursor 'box)
(setq-default evil-visual-state-cursor 'box)
(setq-default evil-operator-state-cursor 'box)

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'catppuccin)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(map! :n "SPC -" #'org-cycle-list-bullet)
(map! :n "C-c l" #'org-store-link)
(map! :i "C-c l" #'org-store-link)
(map! :v "C-c l" #'org-store-link)
(require 'ox-beamer)
(setq-default org-display-custom-times t)
(setq org-time-stamp-custom-formats '("<%Y-%m-%d>" . "<%Y-%m-%d %H:%M>"))

(setq select-enable-clipboard t)
(global-set-key (kbd "C-S-C") 'kill-ring-save)
(global-set-key (kbd "C-S-V") 'yank)


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(map! :n "k" #'evil-substitute)
(map! :n "K" #'evil-change-whole-line)
(map! :n "h" #'evil-replace)
(map! :n "H" #'evil-enter-replace-state)

(map! :n "C-w t" #'evil-window-left)
(map! :n "C-w T" #'evil-window-move-far-left)
(map! :n "C-w r" #'evil-window-up)
(map! :n "C-w R" #'evil-window-move-very-top)
(map! :n "C-w s" #'evil-window-down)
(map! :n "C-w S" #'evil-window-move-very-bottom)
(map! :n "C-w n" #'evil-window-right)
(map! :n "C-w N" #'evil-window-move-far-right)
(map! :n "C-w l" #'evil-window-new)
(map! :n "C-w k" #'evil-window-rotate-downwards)
(map! :n "C-w K" #'evil-window-rotate-upwards)
(map! :n "C-w h" #'evil-window-split)
(map! :n "C-w H" #'evil-window-split)
(map! :n "C-w j" #'evil-window-top-left)

(map! :n "T" #'evil-beginning-of-line)
(map! :n "t" #'evil-backward-char)
(map! :n "R" #'evil-scroll-up)
(map! :n "s" #'evil-next-line)
(map! :n "r" #'evil-previous-line)
(map! :n "n" #'evil-forward-char)
(map! :n "N" #'evil-end-of-line)
;; (map! :n  (kbd "C-j") #'evil-lookup)
(map! :n "S" #'evil-scroll-down)
(map! :n "l" #'evil-ex-search-next)
(map! :n "L" #'evil-ex-search-previous)
(map! :n "j" #'evil-find-char-to)
(map! :n "J" #'evil-find-char-to-backward)

(map! :v "T" #'evil-beginning-of-line)
(map! :v "t" #'evil-backward-char)
(map! :v "R" #'evil-scroll-up)
(map! :v "s" #'evil-next-line)
(map! :v "r" #'evil-previous-line)
(map! :v "n" #'evil-forward-char)
(map! :v "N" #'evil-end-of-line)
(map! :v "S" #'evil-scroll-down)

(map! :n ", t" #'vterm)
(map! :n ", s p" #'consult-ripgrep)

;; pylsp
(setq lsp-pylsp-plugins-flake8-enabled nil)
(setq lsp-pylsp-plugins-autopep8-enabled nil)
(setq lsp-pylsp-plugins-pylint-enabled nil)
(setq lsp-pylsp-plugins-mccabe-enabled nil)
(setq lsp-pylsp-plugins-pycodestyle-enabled nil)
(setq lsp-pylsp-plugins-pydocstyle-enabled nil)
(setq lsp-pylsp-plugins-ruff-enabled t)
(setq lsp-pylsp-plugins-ruff-format t)
(setq lsp-pylsp-plugins-mypy-live-mode nil)
(setq lsp-pylsp-configuration-sources ["ruff"])
(setq lsp-pylsp-plugins-ruff-config "~/Documents/Code/padam-dispatch/ruff.toml")

(defcustom ruff-format-import-command "ruff"
  "Ruff command to use for formatting."
  :type 'string
  :group 'ruff-format-import)

;;;###autoload (autoload 'ruff-format-import-buffer "ruff-format-import" nil t)
;;;###autoload (autoload 'ruff-format-import-region "ruff-format-import" nil t)
;;;###autoload (autoload 'ruff-format-import-on-save-mode "ruff-format-import" nil t)
(reformatter-define ruff-format-import
  :program ruff-format-import-command
  :args (list "check" "--fix" "--select=I" "--stdin-filename" (or (buffer-file-name) input-file))
  :lighter " RuffFmt"
  :group 'ruff-format-import)

(add-hook 'python-mode-hook 'eglot-ensure)
(add-hook! (python-mode . lsp))

(map! :n ", f" #'ruff-format-buffer)
(map! :n ", i" #'ruff-format-import-buffer)

;; tree-sitter
(global-tree-sitter-mode)
(add-hook! 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(map! :n ", c c" #'comment-line)
(map! :v ", c c" #'comment-line)
(map! :n ", n" #'lsp-find-references)
(map! :v ", n" #'lsp-find-references)

(map! :i "C-s" #'yas-expand)

;; rainbow-delimiters
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(provide 'config)
;;; config.el ends here

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

(setq read-process-output-max (* 512 1024)) ;; increase process read limits for better lsp performance

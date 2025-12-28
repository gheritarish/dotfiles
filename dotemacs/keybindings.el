;;; keybindings.el --- Evil keybindings inspired by Doom Emacs -*- lexical-binding: t; -*-
;;; Commentary:
;; This file contains keybindings translated from Doom Emacs default bindings
;; to work with general.el

;;; Code:

(require 'general)

;; Load helper functions (use load-file to ensure it's found)
(let ((helpers-file (expand-file-name "keybindings-helpers.el" user-emacs-directory)))
  (when (file-exists-p helpers-file)
    (load-file helpers-file)))

;; Ensure general.el leader keys are set up
(general-create-definer my/leader-keys
  :states '(normal visual insert emacs)
  :keymaps 'override
  :prefix "SPC"
  :global-prefix "M-SPC")

(general-create-definer my/local-leader-keys
  :states '(normal visual)
  :keymaps 'override
  :prefix ","
  :global-prefix "M-,")

;;
;;; Global keybindings

;; Misc
(general-define-key
 :states 'normal
 "C-S-f" #'toggle-frame-fullscreen)

;;
;;; Leader keybindings

(my/leader-keys
  ";" '(pp-eval-expression :wk "Eval expression")
  ":" '(execute-extended-command :wk "M-x")
  "u" '(universal-argument :wk "Universal argument")
  
  ;; File operations
  "." '(find-file :wk "Find file")
  "," '(switch-to-buffer :wk "Switch buffer")
  "`" '(evil-switch-to-windows-last-buffer :wk "Switch to last buffer")
  "SPC" '(projectile-find-file :wk "Find file in project")
  "RET" '(bookmark-jump :wk "Jump to bookmark"))

;;; <leader> b --- buffer
(my/leader-keys
  "b" '(:ignore t :wk "buffer")
  "b [" '(previous-buffer :wk "Previous buffer")
  "b ]" '(next-buffer :wk "Next buffer")
  "b b" '(switch-to-buffer :wk "Switch buffer")
  "b c" '(clone-indirect-buffer :wk "Clone buffer")
  "b C" '(clone-indirect-buffer-other-window :wk "Clone buffer other window")
  "b d" '(kill-current-buffer :wk "Kill buffer")
  "b i" '(ibuffer :wk "ibuffer")
  "b k" '(kill-current-buffer :wk "Kill buffer")
  "b l" '(evil-switch-to-windows-last-buffer :wk "Switch to last buffer")
  "b m" '(bookmark-set :wk "Set bookmark")
  "b M" '(bookmark-delete :wk "Delete bookmark")
  "b n" '(next-buffer :wk "Next buffer")
  "b N" '(evil-buffer-new :wk "New empty buffer")
  "b p" '(previous-buffer :wk "Previous buffer")
  "b r" '(revert-buffer :wk "Revert buffer")
  "b R" '(rename-buffer :wk "Rename buffer")
  "b s" '(save-buffer :wk "Save buffer")
  "b S" '(evil-write-all :wk "Save all buffers")
  "b z" '(bury-buffer :wk "Bury buffer"))

;;; <leader> c --- code
(my/leader-keys
  "c" '(:ignore t :wk "code")
  "c c" '(compile :wk "Compile")
  "c C" '(recompile :wk "Recompile")
  "c d" '(xref-find-definitions :wk "Jump to definition")
  "c D" '(xref-find-references :wk "Jump to references")
  "c f" '(format-all-buffer :wk "Format buffer/region")
  "c k" '(eldoc :wk "Jump to documentation")
  "c x" '(flycheck-list-errors :wk "List errors"))

;; LSP-specific bindings (when lsp-mode is available)
(with-eval-after-load 'lsp-mode
  (my/leader-keys
    "c a" '(lsp-execute-code-action :wk "LSP Execute code action")
    "c r" '(lsp-rename :wk "LSP Rename")
    "c o" '(lsp-organize-imports :wk "LSP Organize imports")
    "c l" '(lsp-command-map :wk "LSP")))

;; Eglot-specific bindings (when eglot is available)
(with-eval-after-load 'eglot
  (my/leader-keys
    "c a" '(eglot-code-actions :wk "Eglot code actions")
    "c r" '(eglot-rename :wk "Eglot rename")))

;;; <leader> f --- file
(my/leader-keys
  "f" '(:ignore t :wk "file")
  "f f" '(find-file :wk "Find file")
  "f r" '(recentf-open-files :wk "Recent files")
  "f s" '(save-buffer :wk "Save file")
  "f S" '(write-file :wk "Save file as...")
  "f d" '(dired :wk "Find directory")
  "f D" '(delete-file :wk "Delete this file")
  "f R" '(rename-file :wk "Rename/move file"))

;;; <leader> g --- git/version control
(my/leader-keys
  "g" '(:ignore t :wk "git")
  "g g" '(magit-status :wk "Magit status")
  "g s" '(magit-status :wk "Magit status")
  "g b" '(magit-branch-checkout :wk "Magit switch branch")
  "g B" '(magit-blame-addition :wk "Magit blame")
  "g c" '(magit-clone :wk "Magit clone")
  "g f" '(magit-fetch :wk "Magit fetch")
  "g F" '(magit-pull :wk "Magit pull")
  "g p" '(magit-push :wk "Magit push")
  "g L" '(magit-log-buffer-file :wk "Magit buffer log")
  "g S" '(magit-stage-file :wk "Git stage file")
  "g U" '(magit-unstage-file :wk "Git unstage file")
  "g R" '(vc-revert :wk "Revert file")
  "g t" '(git-timemachine-toggle :wk "Git time machine"))

;; Magit submenus
(with-eval-after-load 'magit
  (my/leader-keys
    "g /" '(magit-dispatch :wk "Magit dispatch")
    "g ." '(magit-file-dispatch :wk "Magit file dispatch")))

;;; <leader> h --- help
(my/leader-keys
  "h" '(:ignore t :wk "help")
  "h f" '(helpful-callable :wk "Describe function")
  "h v" '(helpful-variable :wk "Describe variable")
  "h k" '(helpful-key :wk "Describe key")
  "h m" '(describe-mode :wk "Describe mode")
  "h p" '(describe-package :wk "Describe package"))

;;; <leader> i --- insert
(my/leader-keys
  "i" '(:ignore t :wk "insert")
  "i s" '(yas-insert-snippet :wk "Snippet")
  "i u" '(insert-char :wk "Unicode")
  "i y" '(yank :wk "From clipboard"))

;;; <leader> n --- notes
(my/leader-keys
  "n" '(:ignore t :wk "notes")
  "n a" '(org-agenda :wk "Org agenda")
  "n c" '(org-capture :wk "Org capture")
  "n f" '(org-roam-node-find :wk "Find note")
  "n i" '(org-roam-node-insert :wk "Insert note")
  "n l" '(org-store-link :wk "Org store link")
  "n t" '(org-todo-list :wk "Todo list"))

;; Org-roam submenu
(with-eval-after-load 'org-roam
  (my/leader-keys
    "n r" '(:ignore t :wk "roam")
    "n r f" '(org-roam-node-find :wk "Find node")
    "n r i" '(org-roam-node-insert :wk "Insert node")
    "n r r" '(org-roam-buffer-toggle :wk "Toggle roam buffer")
    "n r s" '(org-roam-db-sync :wk "Sync database")
    "n r g" '(org-roam-graph :wk "Show graph")))

;;; <leader> o --- open
(my/leader-keys
  "o" '(:ignore t :wk "open")
  "o -" '(dired-jump :wk "Dired")
  "o t" '(vterm :wk "Terminal")
  "o b" '(browse-url-of-file :wk "Default browser"))

;;; <leader> p --- project
(my/leader-keys
  "p" '(:ignore t :wk "project")
  "p p" '(projectile-switch-project :wk "Switch project")
  "p f" '(projectile-find-file :wk "Find file in project")
  "p b" '(projectile-switch-to-buffer :wk "Switch to project buffer")
  "p c" '(projectile-compile-project :wk "Compile project")
  "p d" '(projectile-remove-known-project :wk "Remove known project")
  "p k" '(projectile-kill-buffers :wk "Kill project buffers")
  "p r" '(projectile-recentf :wk "Recent project files")
  "p s" '(projectile-save-project-buffers :wk "Save project files")
  "p t" '(projectile-test-project :wk "Test project")
  "p i" '(projectile-invalidate-cache :wk "Invalidate cache"))

;;; <leader> q --- quit/session
(my/leader-keys
  "q" '(:ignore t :wk "quit/session")
  "q q" '(save-buffers-kill-terminal :wk "Quit Emacs")
  "q Q" '(evil-quit-all-with-error-code :wk "Quit without saving")
  "q K" '(save-buffers-kill-emacs :wk "Kill Emacs (and daemon)")
  "q f" '(delete-frame :wk "Delete frame"))

;;; <leader> s --- search
(my/leader-keys
  "s" '(:ignore t :wk "search")
  "s b" '(consult-line :wk "Search buffer")
  "s p" '(consult-ripgrep :wk "Search project")
  "s i" '(imenu :wk "Jump to symbol")
  "s j" '(evil-show-jumps :wk "Jump list")
  "s m" '(bookmark-jump :wk "Jump to bookmark")
  "s r" '(evil-show-marks :wk "Jump to mark")
  "s s" '(consult-line :wk "Search buffer"))

;;; <leader> t --- toggle
(my/leader-keys
  "t" '(:ignore t :wk "toggle")
  "t d" '(diff-hl-mode :wk "Diff highlights")
  "t f" '(flycheck-mode :wk "Flycheck")
  "t F" '(toggle-frame-fullscreen :wk "Frame fullscreen")
  "t l" '(display-line-numbers-mode :wk "Line numbers")
  "t r" '(read-only-mode :wk "Read-only mode")
  "t v" '(visible-mode :wk "Visible mode")
  "t w" '(visual-line-mode :wk "Soft line wrapping"))

;;; <leader> w --- window
(my/leader-keys
  "w" '(:ignore t :wk "window")
  "w w" '(other-window :wk "Other window")
  "w d" '(delete-window :wk "Delete window")
  "w s" '(split-window-below :wk "Split below")
  "w v" '(split-window-right :wk "Split right")
  "w h" '(evil-window-left :wk "Window left")
  "w j" '(evil-window-down :wk "Window down")
  "w k" '(evil-window-up :wk "Window up")
  "w l" '(evil-window-right :wk "Window right")
  "w H" '(evil-window-move-far-left :wk "Move window left")
  "w J" '(evil-window-move-very-bottom :wk "Move window down")
  "w K" '(evil-window-move-very-top :wk "Move window up")
  "w L" '(evil-window-move-far-right :wk "Move window right"))

;;
;;; Local leader keybindings (comma prefix)

;;; Search bindings
(my/local-leader-keys
  "s" '(:ignore t :wk "search")
  "s p" '(consult-ripgrep :wk "Ripgrep")
  "s l" '(consult-line :wk "Search line"))

;;; Code bindings
(my/local-leader-keys
  "c" '(:ignore t :wk "code")
  "c c" '(comment-line :wk "Comment line"))

;;; LSP/References
(my/local-leader-keys
  "n" '(lsp-find-references :wk "Find references"))

;;; Terminal
(my/local-leader-keys
  "t" '(vterm :wk "Terminal"))

;;; Python-specific bindings
(with-eval-after-load 'python
  (my/local-leader-keys
    :keymaps 'python-mode-map
    "f" '(ruff-format-buffer :wk "Format buffer")
    "i" '(ruff-format-import-buffer :wk "Format imports")))

;;; Org-mode specific bindings
(with-eval-after-load 'org
  (my/leader-keys
    :keymaps 'org-mode-map
    "-" '(org-cycle-list-bullet :wk "Cycle list bullet")))

;;
;;; Additional useful bindings

;; Window navigation (C-w prefix, like vim)
(general-define-key
 :states '(normal visual)
 :prefix "C-w"
 "h" 'evil-window-left
 "j" 'evil-window-down
 "k" 'evil-window-up
 "l" 'evil-window-right
 "s" 'split-window-below
 "v" 'split-window-right
 "d" 'delete-window
 "o" 'delete-other-windows)

;; Better escape and minibuffer bindings
(general-define-key
 :keymaps '(minibuffer-local-map
            minibuffer-local-ns-map
            minibuffer-local-completion-map
            minibuffer-local-must-match-map
            minibuffer-local-isearch-map)
 [escape] 'abort-recursive-edit
 "C-w" 'backward-kill-word
 "C-u" 'backward-kill-sentence)

;; Insert mode bindings (like terminal)
(general-define-key
 :states 'insert
 "C-u" 'evil-delete-back-to-indentation)

(provide 'keybindings)
;;; keybindings.el ends here

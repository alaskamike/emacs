(setq exec-path(
                append
                '("/home/mike/utils"
                  "/home/mike/emacs"
                  ;;"C:/msys64/usr/bin"
                  ;;"/home/mike/utils/hunspell/bin"
                  ;;"/home/mike/utils/curl/bin"
                  ;;"C:/Program Files/Git/cmd"
                  ;;"C:/Program Files/R/R-3.5.0/bin"
                  ;;"C:/Program Files (x86)/Pandoc"
                  ;;"c:/Program Files/KDiff3/bin/"
                  )))

;; ask to kill emacs
(setq confirm-kill-emacs 'y-or-n-p)

;; scroll lock
(setq scroll-preserve-screen-position 'always)


;; hide UI elements
;;(menu-bar-mode -1)
;;(tool-bar-mode -1)
;;(toggle-scroll-bar -1)

;; hide scroll bar on new frames
;;(add-to-list 'default-frame-alist
;;             '(vertical-scroll-bars . nil))

;; Fix magit on Windows
;;(setenv "SSH_ASKPASS" "git-gui--askpass")
                                      ;
;; indent two spaces only
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; no bell
(setq ring-bell-function 'ignore)

;; no blinking cursor
(blink-cursor-mode -1)

;; no permanent delete
(setq delete-by-moving-to-trash t)

;; themes are safe
(setq custom-safe-themes t)

;; UTF8 everything
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; no startup messages
(setq inhibit-startup-message t)

;; use bookmarks
(setq bookmark-save-flag 1)

;; use winner mode
(winner-mode 1)

;; autofill everything
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; use external packages
(setq package-enable-at-startup nil)

;;use eww to browse the web
(setq browse-url-browser-function 'eww-browse-url)

;; highligh matching parens
(show-paren-mode 1)
(setq show-paren-delay 0)

;; use autofill always
(auto-fill-mode t)
(setq message-kill-buffer-on-exit t)
(setq kill-whole-line t)

;; highlight current line
(global-hl-line-mode 1)
(setq split-height-threshold 0)
(setq split-width-threshold nil)

;;Dired config
(add-hook 'dired-mode-hook 'auto-revert-mode)
(eval-after-load "dired"
  '(progn (define-key dired-mode-map (kbd "C-x C-j") 'dired-up-directory)))
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))
(setq dired-dwim-target t
      dired-recursive-copies 'always
      dired-recursive-deletes 'top
      dired-listing-switches "-lahp")
(require 'dired-x)
(setq auto-revert-verbose nil)

;; short questions
(fset 'yes-or-no-p 'y-or-n-p)

;; don't remember this one
(setq-default indent-tabs-mode nil)

;; always revert files if changes by dropbox
(global-auto-revert-mode t)

;; start maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; use good buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; use escape everywhere
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

;; save the line I was on in a buffer
(save-place-mode 1)
(setq-default save-place t)

;; misc formatting
(electric-pair-mode 1)
(setq electric-pair-delete-adjacent-pairs nil)

(add-hook 'LaTeX-mode-hook
          (lambda () (set (make-variable-buffer-local 'TeX-electric-math)
                          (cons "$" "$"))))

;; delete trailing whitespace
(add-hook 'before-save-hook
          'delete-trailing-whitespace)

;; Automatically move the point to the new window when it is created
(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

;; "Pop" the current window into a dedicated frame
(defun turn-my-current-window-into-frame ()
  (interactive)
  (let ((buffer (current-buffer)))
    (unless (one-window-p)
      (delete-window))
    (display-buffer-pop-up-frame buffer nil)))
(global-set-key (kbd "C-x p") 'turn-my-current-window-into-frame)

;; better defaults config
(setq x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      require-final-newline t
      visible-bell t
      load-prefer-newer t
      save-place-file (concat user-emacs-directory "places"))

;; How I want to handle backup files
(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
    (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 120              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 300 ; number of keystrokes between auto-saves (default: 300)
      )


;; recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-saved-items 1000)
(setq recentf-max-menu-items 1000)
(run-at-time nil (* 30 60) 'recentf-save-list)
(setq recentf-auto-cleanup 'never)

;; start server if not already running
(require 'server)
(unless (server-running-p)
  (server-start))

;; cleaner modeline
;;setq-default mode-line-format
;;             (list
;;              mode-line-modified
;;              " "
;;              "%l"
;;              " "
;;              mode-line-buffer-identification
;;              " "
;;              '(vc-mode vc-mode)
;;              ))


;;;; more informative frame titles
;;(setq frame-title-format '(buffer-file-name "%b - %f" (dired-directory
;;                                                       dired-directory (revert-buffer-function "%b" ("%b - Dir: " default-directory)))))

;;add some extra repositories
(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; update package list
(unless package-archive-contents
  (package-refresh-contents))

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(require 'bind-key)

;; auto-download all packages
(setq use-package-always-ensure t)

;; Use Everything on Windows
(add-to-list 'load-path "~/.emacs.d/personalpackages/")
;;(setq everything-ffap-integration nil)
;;(setq everything-cmd "C:/Users/mmellor/utils/es.exe")
;;(require 'everything)

(use-package csv-mode)

(use-package evil
  :init
  (setq evil-want-integration nil)
  ;; don't let modes override any states (!)
  ;; (setq evil-overriding-maps nil
  ;;       evil-intercept-maps nil
  ;;       evil-pending-intercept-maps nil
  ;;       evil-pending-overriding-maps nil)
  ;; subvert evil-operation.el overrides (dired, ibuffer etc.)
  ;; (advice-add 'evil-make-overriding-map :override #'ignore)
  ;; (advice-add 'evil-make-intercept-map  :override #'ignore)
  ;; (advice-add 'evil-add-hjkl-bindings   :override #'ignore)
  :config
  (evil-mode 1)
  (setq evil-mode-line-format '(before . mode-line-front-space))
  (defun scroll-up-half-page ()
    (interactive)
    (evil-scroll-up 5)
    (evil-scroll-line-to-center
     (line-number-at-pos)))

  (defun scroll-down-half-page ()
    (interactive)
    (evil-scroll-down 5)
    (evil-scroll-line-to-center
     (line-number-at-pos)))

  (define-key evil-normal-state-map (kbd "C-u") 'scroll-up-half-page)
  (define-key evil-normal-state-map (kbd "C-d") 'scroll-down-half-page)
  (setq evil-want-fine-undo 'fine)
  (add-hook 'org-capture-mode-hook 'evil-insert-state)
  (setq evil-want-Y-yank-to-eol t)
  (with-eval-after-load 'evil-maps
    (define-key evil-normal-state-map (kbd "U") 'undo-tree-redo))
  (setq evil-emacs-state-modes (delq 'ibuffer-mode evil-emacs-state-modes))
  (define-key evil-normal-state-map (kbd "H") 'evil-first-non-blank)
  (define-key evil-normal-state-map (kbd "f") 'avy-goto-word-1)
  (define-key evil-normal-state-map (kbd "L") 'evil-end-of-line)
  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
  (lambda ()
    (interactive)
    (evil-delete (point-at-bol) (point)))
  )

(use-package general
  :config
  (general-define-key
   :states '(normal visual insert emacs motion)
   :keymaps 'override
   :prefix "SPC"
   :non-normal-prefix "C-SPC"
   "1" 'delete-other-windows
   "2" 'split-and-follow-horizontally
   "3" 'split-and-follow-vertically
   "0" 'delete-window
   "j" 'dired-jump
   "p" 'winner-undo
   "P" 'winner-redo
   "a" 'org-agenda
   "c" 'org-capture
   "k" 'kill-buffer
   ;;"g" 'magit-status
   "h" 'mark-whole-buffer
   "d" 'dired
   "l" 'everything
   "n" 'elfeed
   "SPC" 'save-some-buffers
   "w" 'write-file
   "s" 'swiper
   "S" 'query-replace
   "y" 'counsel-yank-pop
   "o" 'ace-window
   "i" 'other-window
   "f" 'counsel-find-file
   "F" 'projectile-find-file
   "b" 'ivy-switch-buffer
   "x" 'counsel-M-x
   "q" 'fill-paragraph
   ";" 'comment-dwim
   "t" 'new-frame
   "e" 'shell
   "E" 'eshell
   "-" 'calendar
   "=" 'er/expand-region
   "r" 'list-packages
   "," 'eww
   ))

(use-package eww
  :config
  (setq shr-inhibit-images t)
  (defadvice shr-color-check (before unfuck compile activate)
    "Don't let stupid shr change background colors."
    (setq bg (face-background 'default)))
  )

;;(use-package evil-surround
;;  :config
;;  (global-evil-surround-mode 1))

(use-package company
  :config
  (global-company-mode))

(use-package aggressive-indent
  :config
  (global-aggressive-indent-mode 1)
  (add-to-list 'aggressive-indent-excluded-modes 'LaTeX-mode))

(use-package company-math
  :config
  (add-to-list 'company-backends 'company-math-symbols-unicode))

(use-package restart-emacs)

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package org-plus-contrib
  :ensure org-plus-contrib
  :mode (("\\.org$" . org-mode))
  :init
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((R . t)
     (org . t)
     (ditaa . t)
     (latex . t)
     (dot . t)
     (emacs-lisp . t)
     (gnuplot . t)
     (screen . nil)
     (sql . nil)
     (sqlite . t)))

  ;; auto start in agenda mode
  (setq org-todo-keywords
        '((sequence "TODO" "IN PROGRESS" "|" "DONE")))
  (setq org-confirm-babel-evaluate nil)
  (setq org-replace-disputed-keys t)
  (setq org-M-RET-may-split-line nil)
  (add-hook 'org-mode-hook 'turn-on-flyspell)
  (setq org-src-fontify-natively t
        org-src-tab-acts-natively t)
  (setq org-hide-emphasis-markers t)
  (setq org-startup-truncated nil)
  (setq org-highlight-latex-and-related '(latex script entities))
  (setq org-default-notes-file "~/emacs/#todo_list.org#")
  (define-key global-map "\C-cc" 'org-capture)
  (setq org-log-done t)
  (setq org-capture-templates
        '(("c" "todo" entry (file+headline "~/emacs/#todo_list.org#" "Tasks")
           "* TODO %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")))
  (setq org-agenda-files (list "~/emacs/#todo_list.org#"))
  (define-key global-map "\C-ca" 'org-agenda))

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook 'org-bullets-mode))

(use-package undo-tree
  :config
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t)))

(use-package counsel)

(use-package swiper)

(use-package ace-window
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (global-set-key (kbd "M-o") 'ace-window)
  (global-set-key (kbd "C-x o") 'ace-window))

(use-package avy)



(use-package expand-region
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

(use-package google-this)

;; my stuff

(require 'workgroups2)
(workgroups-mode 1)

;;powerline m2
(require 'powerline)
(powerline-default-theme)

(require 'airline-themes)
(load-theme 'airline-light)

;; use a nice theme
(use-package solarized-theme
  :config
  (setq solarized-use-variable-pitch nil)
  (setq solarized-height-plus-1 1.0)
  (setq solarized-height-plus-2 1.0)
  (setq solarized-height-plus-3 1.0)
  (setq solarized-height-plus-4 1.0)
  (setq solarized-scale-org-headlines nil)
  (setq solarized-emphasize-indicators nil)
  (setq solarized-high-contrast-mode-line t)
  (setq solarized-use-more-italic t)
  ;; (load-theme 'solarized-light t)
  (load-theme 'solarized-dark t)
  )

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fringe ((t (:background "SystemWindow")))))
(put 'dired-find-alternate-file 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("b59d7adea7873d58160d368d42828e7ac670340f11f36f67fa8071dbf957236a" default)))
 '(package-selected-packages
   (quote
    (polymode ess-view ess-R-data-view workgroups2 workgroups wgrep-ag use-package swiper-helm smex smart-mode-line restart-emacs powerline-evil ox-pandoc org-plus-contrib org-bullets markdown-mode magit-popup iedit helm-google gscholar-bibtex google-translate google-this google-maps google git-commit ggtags general flycheck flx expand-region evil-surround evil-org evil-ediff evil-collection diffview csv-mode counsel company-math centered-window auctex airline-themes aggressive-indent ace-window academic-phrases))))

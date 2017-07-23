;; Startup options

(setq inhibit-startup-message t)

;; Add user-local site-lisp from homedir (recursively).

(when (file-directory-p "~/site-lisp")
  (let ((default-directory "~/site-lisp"))
    (normal-top-level-add-subdirs-to-load-path)))

;; Enable or disable global minor modes.
;;
;; Minor-modes are disabled unconditionally with a negative
;; argument. A non-negative value, including nil, unconditionally
;; _enables_ the minor mode.

(menu-bar-mode -1)
(line-number-mode t)
(column-number-mode t)
(icomplete-mode t)           ; Mini-buffer autocomplete.
(show-paren-mode t)          ; Highlight matching pairs of parentheses.

;; Config when running on a windowing system.

(if (display-graphic-p)
    (progn
      (tool-bar-mode -1)
      (scroll-bar-mode -1)

      (when (string-equal system-type "darwin")
        (custom-set-faces
         '(default ((t (:height 137 :width normal :foundry "apple" :family "Monaco"))))))))

;; Use a nicer color scheme
;;
;; "Custom themes" are included by default as part of Emacs 24, and
;; are the strategic direction instead of the color-theme package.
;; Try to load the solarized theme if it's installed, otherwise
;; default to the standard tango-dark theme.

(unless (version< emacs-version "24")

  ;; TODO: Automatically add all sub-dirs of ~/site-lisp/themes to the
  ;; custom theme load path

  (add-to-list 'custom-theme-load-path "~/site-lisp/themes")
  (add-to-list 'custom-theme-load-path "~/site-lisp/themes/emacs-color-theme-solarized")

  (custom-set-variables
   '(custom-safe-themes
     ;; solarized theme
     (quote ("8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default))))

  (condition-case err
      (progn
        ;; Annoyingly complicated method required to select the light
        ;; or dark version of the solarized theme
        (defun solarized-dark (frame)
          (set-frame-parameter frame 'background-mode 'dark)
          (enable-theme 'solarized))

        (load-theme 'solarized 'no-confirm)
        (solarized-dark nil)

        ;; Make sure every frame uses the same mode of the theme.
        (add-hook 'after-make-frame-functions 'solarized-dark))

    ('error (load-theme 'tango-dark 'no-confirm))))

;; Configure backup and autosave.
;;
;; Save them to /tmp or the equivalent (autosave writes to /tmp by
;; default).

(setq backup-directory-alist `(("." . ,temporary-file-directory)))

;; Save mini-buffer history between sessions.
;;
;; Configuration needs to be done before savehist-mode is turned on,
;; otherwise the config will be ignored. Save search rings in addition
;; to minibuffer history. The default savehist-file is
;; ~/.emacs.d/history.

(setq savehist-additional-variables '(search-ring regexp-search-ring))
(savehist-mode t)

;; General editing configuration

(setq-default indent-tabs-mode nil)
(setq tab-width 4)

;; General coding configuration

(defun dbo-common-prog-hook ()
  (setq show-trailing-whitespace t)
  (electric-pair-mode t))              ; Auto-insert matching braces.

(when (require 'xcscope nil 'noerror)
  (progn
    (setq cscope-index-recursively t)
    (setq cscope-use-relative-paths t)
    (cscope-setup)))

;; Configuration for C coding

(defun dbo-c-mode-hook ()
  (setq c-basic-offset 4
        c-default-style "k&r"))

(add-hook 'c-mode-hook 'dbo-common-prog-hook)
(add-hook 'c-mode-hook 'dbo-c-mode-hook)

;; Configuration for e-lisp coding

(add-hook 'emacs-lisp-mode-hook 'dbo-common-prog-hook)

;; Configuration for assembler coding

(add-hook 'asm-mode-hook 'dbo-common-prog-hook)

;; Autoload Ledger mode for Ledger files
;;
;; Assumes the `ledger-mode` package is on the load-path, and that the `ledger`
;; binary is on $PATH.

(autoload 'ledger-mode "ledger-mode" "Major mode for Ledger" t)
(add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))

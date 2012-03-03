(require 'multi-term)
(setq multi-term-program shell-file-name)
(add-hook 'term-mode-hook '(lambda ()
           (define-key term-raw-map "\C-y" 'term-paste)
           (define-key term-raw-map "\C-q" 'move-beginning-of-line)
           (define-key term-raw-map "\C-d" 'kill-this-buffer)
           (define-key term-raw-map "\C-f" 'forward-char)
           (define-key term-raw-map "\C-b" 'backward-char)
           (define-key term-raw-map "\C-t" 'set-mark-command)
           (define-key term-raw-map (kbd "ESC") 'term-send-raw)
           (define-key term-raw-map [delete] 'term-send-raw)
                             (define-key term-raw-map "\C-z"
                               (lookup-key (current-global-map) "\C-z"))))


(require 'ucs-normalize)
(setq file-name-coding-system 'utf-8-hfs)
(setq locale-coding-system 'utf-8-hfs)

(require 'yafastnav)
(add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes

(require 'jaunte)

(require 'simple-hatena-mode)
(setq simple-hatena-default-id "mizchi")

(when (eq window-system 'mac)
  (add-hook 'window-setup-hook
            (lambda ()
;;              (setq mac-autohide-menubar-on-maximize t)
              (set-frame-parameter nil 'fullscreen 'fullboth)
              )))

(defun describe-face-at-point ()
  "Return face used at point."
  (interactive)
  (message "%s" (get-char-property (point) 'face)))

(if window-system (progn
   (set-background-color "Black")
   (set-foreground-color "LightGray")
   (set-cursor-color "Gray")
   (set-frame-parameter nil 'alpha 90)
))

(custom-set-variables
 '(display-time-mode t)
 '(tool-bar-mode nil)
 '(transient-mark-mode t))

;; indent
(add-hook 'c-mode-hook
 (lambda ()
            (hs-minor-mode 1)
            (setq tab-width 4)))

(add-hook 'lisp-mode-hook
 (lambda ()
            (hs-minor-mode 1)
            (setq tab-width 4)))


(add-hook 'python-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq indent-level 4)
            (setq python-indent 4)
            (setq tab-width 4)))



(require 'ess-site)
(require 'html-helper-mode)
(require 'simple-hatena-mode)
(require 'textmate)

(setq evernote-enml-formatter-command '("w3m" "-dump" "-I" "UTF8" "-O" "UTF8"))
(require 'evernote-mode)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.(coffee|cf)$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

;; (defun coffee-custom ()
;;   "coffee-mode-hook"
;;  (set (make-local-variable 'tab-width) 2)

;; )

;; (add-hook 'coffee-mode-hook
;;           '(lambda ()
;;              ;; (auto-complete-mode t)
;;              ;; (vimpulse-map "C" 'coffee-comment-dwim)
;;              ;; (define-key vimpulse-visual-basic-map "C" 'coffee-comment-dwim)
;;              ;; (define-key vimpulse-visual-basic-map "c" 'coffee-comment-dwim)
;;              (coffee-custom)
;;              ))

(setq-default tab-width 4)
(defun coffee-custom ()
  "coffee-mode-hook"
 (set (make-local-variable 'tab-width) 2)
 )

(add-hook 'coffee-mode-hook '(lambda() 
                               (coffee-custom)
                               (vimpulse-map "C" 'coffee-comment-dwim)
                               (define-key vimpulse-visual-basic-map "c" 'coffee-comment-dwim)
                               ))

(require 'magit)
(vimpulse-map "gm" 'magit-status)
;; (require 'shadow)
;; (add-hook 'find-file-hooks 'shadow-on-find-file)
;; (add-hook 'shadow-find-unshadow-hook
;;           (lambda () 
;;             (auto-revert-mode 1)
;;             ))

(global-auto-complete-mode)
(setq uniquify-buffer-name-style 'forward)

(setq auto-revert-check-vc-info t)
(setq auto-revert-interval 1)

(add-hook 'find-file-hook
          '(lambda () 
             (when   
                 (and buffer-file-name
                      (vc-backend buffer-file-name))
               (auto-revert-mode))))

(setq haskell-program-name "/Library/Frameworks/GHC.framework/Versions/Current/usr/bin/ghci")
;; (setq haskell-program-name "cabal-dev ghci")
(load "~/.emacs.d/plugin/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(load "~/.emacs.d/plugin/smart-compile")
(require 'smart-compile)
(defvar smart-compile-alist '(
  ("\\.c\\'"          . "gcc -O2 %f -lm -o %n")
  ("\\.[Cc]+[Pp]*\\'" . "g++ -O2 %f -lm -o %n")
  ("\\.java\\'"       . "javac %f")
  ("\\.f90\\'"        . "gfortran %f -o %n")
  ("\\.[Ff]\\'"       . "gfortran %f -o %n")
  ("\\.tex\\'"        . (tex-file))
  ("\\.pl\\'"         . "perl -cw %f")
  ("\\.hs\\'"         . "runghc %f")
  ("\\.py\\'"         . "python %f")
  ("\\.rb\\'"         . "ruby %f")
  ("\\.coffee\\'"     . "coffee %f")
  ("\\.cf\\'"         . "cf %f")
  (emacs-lisp-mode    . (emacs-lisp-byte-compile))
  (coffee-mode        . "coffee %f")
) "...")
(define-key menu-bar-tools-menu [compile] '("Compile..." . smart-compile))


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


(defun mac-toggle-max-window ()
  (interactive)
  (if (frame-parameter nil 'fullscreen)
      (set-frame-parameter nil 'fullscreen nil)
    (set-frame-parameter nil 'fullscreen 'fullboth)))

(custom-set-variables
 '(display-time-mode t)
 '(tool-bar-mode nil)
 '(transient-mark-mode t))

(require 'cedet)
(require 'ecb)
(defun ecb-toggle ()
    (interactive)
      (if ecb-minor-mode
                (ecb-deactivate)
            (ecb-activate)))
(global-set-key [f2] 'ecb-toggle)
(setq ecb-tip-op-the-day nil)
(setq ecb-auto-activate t)
(setq ecb-windows-width 0.15)
(setq semantic-load-turn-useful-things-on t)

(if window-system (progn
                    (tool-bar-mode 0)
                    (set-scroll-bar-mode nil)
                    (setq line-spacing 0.05)
                    (create-fontset-from-ascii-font "Inconsolata-16:weight=normal:slant=normal" nil "Inconsolata")
                    (set-default-font "Inconsolata-16")
                    (set-fontset-font (frame-parameter nil 'font)
                                      'japanese-jisx0208
                                      '("Hiragino Kaku Gothic ProN" . "unicode-bmp"))

                    (add-to-list 'default-frame-alist '(alpha . 90))
                    ))
 (custom-set-variables
 '(ecb-auto-activate t)
 '(ecb-auto-compatibility-check nil)
 '(ecb-source-path (quote (("/Users/mzi/workplace" "/Users/mzi/"))))
 '(ecb-version-check nil))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-activation-selects-ecb-frame-if-already-active t)
 '(ecb-compilation-buffer-names (quote (("*slime-repl clojure*")("*vc*") ("*vc-diff*") ("*anything*") ("*Apropos*") ("*eshell*") ("*Occur*") ("*shell*" . t) ("€€*[cC]ompilation.*€€*" . t) ("€€*i?grep.*€€*" . t) ("*Help*") ("*Completions*") ("*Backtrace*") ("*Compile-log*") ("*Messages*") ("*magit: " . t))))
 ;; '(ecb-compile-window-height 6)
 ;; '(ecb-compile-window-temporally-enlarge (quote both))
 ;; '(ecb-compile-window-width (quote frame))
 '(ecb-layout-name "left1")
 '(ecb-maximize-ecb-window-after-selection t)
 '(ecb-mode-line-display-window-number nil)
 '(ecb-options-version "2.40")
 '(ecb-tip-of-the-day nil)
 '(ecb-tree-indent 2)
 '(ecb-vc-enable-support t)
 '(ecb-windows-width 0.2)
 '(linum-format "%4d ")
 '(mumamo-chunk-coloring 0)
 '(show-paren-mode t)
 '(transient-mark-mode t))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(mumamo-background-chunk-major ((((class color) (min-colors 88) (background dark)) (:background "#2A2828"))))
 '(mumamo-background-chunk-submode1 ((((class color) (min-colors 88) (background dark)) (:background "#373436"))))
)

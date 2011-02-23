
; anything
(require 'anything-startup)
(require 'auto-install)
(require 'recentf)
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)
(define-key anything-map "\C-p" 'anything-previous-line)
(define-key anything-map "\C-n" 'anything-next-line)
(defvar my-minibuffer-minor-mode nil)
(setq recentf-max-saved-items 3000)
(recentf-mode 1)

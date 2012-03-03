(require 'auto-complete)
(global-auto-complete-mode t)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/dict")


(require 'auto-complete-config)
(ac-config-default)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-j" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
(define-key ac-complete-mode-map "\C-k" 'ac-previous)
(setq ac-use-quick-help nil)
(setq ac-use-menu-map t)
(add-to-list 'ac-modes 'coffee-mode)
(setq ac-auto-show-menu 0.4)
(setq ac-menu-height 20)

(require 'autoinsert)
(require 'zencoding-mode)
(define-key zencoding-mode-keymap "\C-j" 'newline-and-indent)

(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugin/yasnippet/snippets/")
(setq yas/prompt-functions '(yas/dropdown-prompt))
(setq ac-sources '(ac-source-semantic ac-source-yasnippet))

; anything
(require 'anything-startup)
(require 'auto-install)
(require 'recentf)
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)
(defvar my-minibuffer-minor-mode nil)
(setq recentf-max-saved-items 3000)
(recentf-mode 1)

(require 'color-moccur)
(setq moccur-split-word t)
(require 'anything-c-moccur)
(setq anything-c-moccur-anything-idle-delay 0.2 ;
      anything-c-moccur-higligt-info-line-flag t ;
      anything-c-moccur-enable-auto-look-flag t ;
      anything-c-moccur-enable-initial-pattern t) 

(defvar anything-c-source-shell-command
  '((name . "Shell Command")
    (dummy)
    (action
     ("Execute" . (lambda (candidate)
                            (save-excursion
                              (message "wait....")
                              (call-process-shell-command candidate nil (get-buffer-create "*Shell Command*"))
                              (switch-to-buffer "*Shell Command*")
                              (message (delete-and-extract-region (point-min) (point-max)))
                              (set-buffer-modified-p (buffer-modified-p))
                              (kill-buffer "*Shell Command*"))))
     ("Execute and Insert" . (lambda (candidate)
                            (save-excursion
                              (call-process-shell-command candidate nil t)))))))
(setq anything-sources (list
                        anything-c-source-buffers
                        anything-c-source-recentf
                        ))
(define-key global-map (kbd "C-;") 'anything)


(setq anything-sources
      (list anything-c-source-buffers+
            anything-c-source-recentf
            anything-c-source-emacs-commands
            ))

(defun my-horizontally-split-window (buf)
  (delete-other-windows)
  (split-window-horizontally)
  (funcall (if anything-samewindow 'switch-to-buffer 'pop-to-buffer) buf))
(setq anything-display-function 'my-horizontally-split-window) 

(setq anything-startup)
(setq anything-c-filelist-file-name "/tmp/all.filelist")
(setq anything-grep-candidates-fast-directory-regexp "^/t")



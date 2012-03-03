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
(setq anything-c-moccur-anything-idle-delay 0.2 ;`anything-idle-delay'
      anything-c-moccur-higligt-info-line-flag t ;
      anything-c-moccur-enable-auto-look-flag t ; 現在選択中の候補の位置を他のwindowに表示する
      anything-c-moccur-enable-initial-pattern t) ; `anythi

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

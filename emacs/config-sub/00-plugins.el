; auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/dict")
(require 'auto-complete-config)
(ac-config-default)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-j" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
(define-key ac-complete-mode-map "\C-k" 'ac-previous)

(require 'autoinsert)
;; (require 'elscreen )
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
(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes
; elscreen
;; (setq elscreen-display-tab 8) ; タブの幅（６以上じゃないとダメ）
;; (setq elscreen-tab-display-kill-screen nil) ; タブの左端の×を非表示
;; (load  "elscreen" "ElScreen" t)
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugin/yasnippet/snippets/")
(setq yas/prompt-functions '(yas/dropdown-prompt))
(setq ac-sources '(ac-source-semantic ac-source-yasnippet))

(require 'jaunte)
(require 'simple-hatena-mode)
(setq simple-hatena-default-id "mizchi")

;; (defun copy-from-osx ()
;;  (shell-command-to-string "pbpaste"))

;; (defun paste-to-osx (text &optional push)
;;  (let ((process-connection-type nil))
;;      (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
;;        (process-send-string proc text)
;;        (process-send-eof proc))))
;; (setq interprogram-cut-function 'paste-to-osx)
;; (setq interprogram-paste-function 'copy-from-osx)


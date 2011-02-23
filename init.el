; set load-path
(let ((default-directory "~/.emacs.d/"))
    (setq load-path (cons default-directory load-path))
    (normal-top-level-add-subdirs-to-load-path))
; options
(setq ring-bell-function 'ignore);;ビープ音を消す                                                                                                                             
(setq completion-ignore-case t); file名の補完で大文字小文字を区別しない
(icomplete-mode 1) ;;ミニバッファで補完
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
(blink-cursor-mode t);;カーソルの点滅
(column-number-mode t);;; カーソルの位置が何文字目かを表示する
(setq truncate-lines nil);;; 行の折り返しをしない
(setq truncate-partial-width-windows t);;; 選択範囲に色付けする
(setq transient-mark-mode t)
(setq make-backup-files nil)
; load plugin
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")
(global-set-key "\C-h" 'delete-backward-char)

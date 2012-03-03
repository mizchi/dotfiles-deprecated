; options
(setq ring-bell-function 'ignore);;ビープ音を消す
(setq completion-ignore-case t); file名の補完で大文字小文字を区別しない
(icomplete-mode 1) ;;ミニバッファで補完
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(prefer-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8-unix)
(setq file-name-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)

(if window-system (menu-bar-mode 1) (menu-bar-mode -1))
(which-function-mode 1)
(blink-cursor-mode t);;カーソルの点滅
(column-number-mode t);;; カーソルの位置が何文字目かを表示する
(setq truncate-lines nil);;; 行の折り返しをしない
(setq truncate-partial-width-windows t);;; 選択範囲に色付けする
(setq transient-mark-mode t)
(setq make-backup-files nil)
(setq-default tab-width 4 indent-tabs-mode nil)
(setq inhibit-startup-screen -1)
; load plugin


(if window-system
    (when (eq window-system 'x)
      (setq x-select-enable-clipboard t)))

; PATH
(setq exec-path (cons "/usr/local/bin" exec-path))

(setenv "PATH"
    (concat '"/usr/local/bin:~/bin:/usr/bin" (getenv "PATH")))



(require 'color-theme)
(color-theme-initialize)

(let* ((fontset-name "myfonts") ; フォントセットの名前
       (size 15)
       (asciifont "Inconsolata") ; ASCIIフォント
       (jpfont "Hiragino Maru Gothic ProN") ; 日本語フォント
       (font (format "%s-%d:weight=normal:slant=normal" asciifont size))
       (fontspec (font-spec :family asciifont))
       (jp-fontspec (font-spec :family jpfont)) 
       (fsn (create-fontset-from-ascii-font font nil fontset-name)))
  (set-fontset-font fsn 'japanese-jisx0213.2004-1 jp-fontspec)
  (set-fontset-font fsn 'japanese-jisx0213-2 jp-fontspec)
  (set-fontset-font fsn 'katakana-jisx0201 jp-fontspec) ; 半角カナ
  (set-fontset-font fsn '(#x0080 . #x024F) fontspec) ; 分音符付きラテン
  (set-fontset-font fsn '(#x0370 . #x03FF) fontspec) ; ギリシャ文字
  )
(add-to-list 'default-frame-alist '(font . "fontset-myfonts"))
(dolist (elt '(("^-apple-hiragino.*" . 1.0)
		 (".*osaka-bold.*" . 1.0)
		 (".*osaka-medium.*" . 1.0)
		 (".*courier-bold-.*-mac-roman" . 1.0)
		 (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
		 (".*monaco-bold-.*-mac-roman" . 0.9)))
    (add-to-list 'face-font-rescale-alist elt))

(set-face-font 'default "fontset-myfonts")

(set-scroll-bar-mode nil)
;; (require 'yascroll)
;; (global-yascroll-bar-mode 1)

(setq elscreen-display-tab 12) ; タブの幅（６以上じゃないとダメ）
(setq elscreen-tab-display-kill-screen nil) ; タブの左端の×を非表示
(load  "elscreen" "ElScreen" t)
(server-start)
(require 'elscreen)
(require 'elscreen-server)

(set-frame-height (selected-frame) 52)
(set-frame-width (selected-frame) 93)

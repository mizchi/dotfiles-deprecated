;;; -*- Emacs-Lisp -*-
;;; Sample startup file to invoke yatex-mode with outline-minor mode.
;;; (c)1993 by HIROSE Yuuji [yuuji@yatex.org]
;;; Last modified Fri Jun 27 12:10:15 2003 on firestorm

;;;
;; outline-minor-mode(�g�p���Ȃ��ꍇ�͕s�v�ł�)
;;; 
(autoload 'outline-minor-mode "min-out" t)
(make-variable-buffer-local 'outline-prefix-char)
(make-variable-buffer-local 'outline-regexp)
(setq  default-outline-regexp "[*\^l]+")
(make-variable-buffer-local 'outline-level-function)
(setq-default outline-level-function 'outline-level-default)
(setq LaTeX-outline-regexp
  (concat "[ \t]*" (regexp-quote "\\")
	  "\\(appendix\\|documentstyle\\|part\\|chapter\\|section\\|"
	  "subsection\\|subsubsection\\|paragraph\\|subparagraph\\)"
          "\\*?[ \t]*[[{]"))

;;;
;; yatex-mode
;;;
(setq auto-mode-alist (cons '("\\.tex$" . yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
;;��min-out���g�p���Ȃ��ꍇ�A;;@ �̍s�͕s�v�ł��B
(defvar yatex-mode-hook
  '(lambda ()
     (setq outline-regexp LaTeX-outline-regexp)			    ;;@
     (outline-minor-mode 1)					    ;;@
     ))
(defvar yatex-mode-load-hook
  '(lambda ()
     (setq-default outline-prefix-char (concat YaTeX-prefix "\C-o"));;@
     (require 'min-out)						    ;;@
     ;;auctex �t���� min-out.el �̏ꍇ���ꁫ
     ;(define-key outline-minor-keymap "\C-?" 'hide-subtree)	    ;;@
     ;;Emacs �t���� outline.el �̏ꍇ���ꁫ
     (define-key outline-mode-prefix-map "\C-?" 'hide-subtree)
     (YaTeX-define-begend-key "ba" "abstract")
     ))

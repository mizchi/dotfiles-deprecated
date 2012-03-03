;;; -*- Emacs-Lisp -*-
;;; YaTeX interfaces for Texinfo mode.
;;; (c)1994,1998,2001 by HIROSE, Yuuji [yuuji@yatex.org]
;;; Last modified Fri Jun 27 12:10:03 2003 on firestorm

(require 'yatex)
(or (boundp 'texinfo-mode-map)
    (load "texinfo"))

;;Put next expressions into your ~/.emacs
;;(defvar texinfo-mode-hook nil)
;;(or (featurep 'yatexinf)
;;    (setq texinfo-mode-hook
;;	  (append (or texinfo-mode-hook '(lambda ()))
;;		  '((require 'yatexinf) (yatexinfo-setup)))))

(defun yatexinfo-define-key (map key binding)
  "Define keys of yatexinfo with YaTeX-prefix."
  (if YaTeX-inhibit-prefix-letter
      (let ((c (aref key 0)))
	(cond
	 ((and (>= c ?a) (<= c ?z)) (aset key 0 (1+ (- c ?a))))
	 ((and (>= c ?A) (<= c ?Z) (numberp YaTeX-inhibit-prefix-letter))
	  (aset key 0 (1+ (- c ?A))))
	 (t nil))))
  (define-key map (concat YaTeX-prefix key) binding))

(if (featurep 'yatexinf) nil
  (yatexinfo-define-key texinfo-mode-map "s" 'YaTeX-make-section)
  (yatexinfo-define-key texinfo-mode-map "S" 'YaTeX-make-section-region)
  (yatexinfo-define-key texinfo-mode-map "b" 'YaTeX-make-begin-end)
  (yatexinfo-define-key texinfo-mode-map "B" 'YaTeX-make-begin-end-region)
  (yatexinfo-define-key texinfo-mode-map "m" 'YaTeX-make-singlecmd)
  (yatexinfo-define-key texinfo-mode-map "g" 'YaTeX-goto-corresponding-*)
  (yatexinfo-define-key texinfo-mode-map ">" 'YaTeX-comment-region)
  (yatexinfo-define-key texinfo-mode-map "<" 'YaTeX-uncomment-region)
  (yatexinfo-define-key texinfo-mode-map "." 'YaTeX-comment-paragraph)
  (yatexinfo-define-key texinfo-mode-map "," 'YaTeX-uncomment-region)
  (yatexinfo-define-key texinfo-mode-map "t" 'YaTeX-typeset-menu)
  (define-key texinfo-mode-map "\e\C-t" 'lisp-complete-symbol))

(defvar yatexinfo-section-table
  '(("leftline") ("file") ("kbd") ("key") ("code") ("var") ("samp")
    ("ref") ("xref") ("pxref") ("value") ("footnote")
    )
  "Completion table of section-type command of Texinfo.")

(defvar yatexinfo-singlecmd-table
  '(("TeX{}") ("copyright{}") ("setfilename") ("settitle") ("author")
    ("noindent") ("dots{}") ("bullet") ("cindex")
    ("chapter") ("section") ("subsection") ("subsubsection")
    ("unnumbered") ("unnumberedsec") ("unnumberedsubsec")
    ("unnumberedsubsubsec")
    ("item") ("itemx"))
  "Completion table of maketitle-type command of Texinfo.")

(defvar yatexinfo-env-table
  '(("example") ("enumerate") ("iftex") ("titlepage") ("menu") ("table")
    ("lisp") ("itemize") ("display") ("quotation")
    ("flushright") ("flushleft") ("center"))
  "Completion table of begin-type command of Texinfo.")

(defvar yatexinfo-struct-begin
  "@%1%2"
  "Structure beginning form of Texinfo begin-type commands.")

(defvar yatexinfo-struct-end
  "@end %1"
  "Structure ending form of Texinfo begin-type commands.")

(defvar yatexinfo-struct-name-regexp
  "table\\|itemize\\|enumerate\\|display\\|example\\|lisp\\|group\\|menu"
  "All of begin-end type structures")

(defvar yatexinfo-ec "@" "Escape character of Texinfo.")
(defvar yatexinfo-ec-regexp "@" "Regexp of the escape character of Texinfo.")
(defvar yatexinfo-comment-prefix "@c " "Comment prefix of Texinfo.")

(defvar yatexinfo-user-completion-table
  (if YaTeX-dos "~/_inforc" ".yatexinforc")
  "*Default dictionary of completion table.")

(defun yatexinfo-setup ()
  "Setup all for yatexinfo."
  (mapcar 'make-local-variable
	  '(env-table section-table singlecmd-table
	    YaTeX-user-completion-table YaTeX-comment-prefix
	    YaTeX-struct-name-regexp
	    YaTeX-struct-begin YaTeX-struct-end YaTeX-ec YaTeX-ec-regexp))
  (setq env-table		yatexinfo-env-table
	section-table		yatexinfo-section-table
	singlecmd-table		yatexinfo-singlecmd-table
	YaTeX-user-completion-table yatexinfo-user-completion-table
	YaTeX-comment-prefix	yatexinfo-comment-prefix
	YaTeX-struct-begin	yatexinfo-struct-begin
	YaTeX-struct-end	yatexinfo-struct-end
	YaTeX-struct-name-regexp yatexinfo-struct-name-regexp
	YaTeX-ec		yatexinfo-ec
	YaTeX-ec-regexp		yatexinfo-ec-regexp)
  (load yatexinfo-user-completion-table t)
  (run-hooks 'yatex-mode-hook))

(provide 'yatexinf)

;;; yalinum.el --- yet another display line numbers.

;; Copyright (C) 2010 tm8st

;; Author: tm8st <tm8st@hotmail.co.jp>
(defconst yalinum-version "0.1")
;; Keywords: convenience, linum, line, number

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the

;; GNU General Public License for more details.

;; You should have received ba  copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.	If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; linum.elをベースとして、
;; 現在の位置がバッファ全体から見てどのぐらいの位置かをスクロールバーのように表示する機能を追加したもの。
;; 主に変更したのは yalinum-update-window。

;; Installation:

;; (require 'yalinum)
;; (global-yalinum-mode t)

;;; Code:

(defvar yalinum-overlays nil "Overlays used in this buffer.")
(defvar yalinumavailable nil "Overlays available for reuse.")
(defvar yalinum-before-numbering-hook nil
  "Functions run in each buffer before line numbering starts.")

(defcustom yalinum-line-number-length-min 1
  "Line number length min."
  :group 'yalinum
  :type 'integer
  )

(defcustom yalinum-width-base 1
  "Line number length offset."
  :group 'yalinum
  :type 'integer
  )

(defcustom yalinum-width-scale 0.5
  "Line number length to margin space scale."
  :group 'yalinum
  :type 'float
  )

(defcustom yalinum-line-number-display-format " %0$numd"
  "Line number display format. replace $num by line number."
  :group 'yalinum
  :type 'string
  )

(mapc #'make-variable-buffer-local '(yalinum-overlays yalinum-available))

(defgroup yalinum nil
  "Yet another show line numbers in the left margin."
  :group 'convenience)

(defface yalinum-face
  '((t (:foreground "gray70" :background "black")))
  "Face for displaying line numbers in the display margin."
  :group 'yalinum)

(defface yalinum-bar-face
  '((t (:foreground "gray85" :background "gray20")))
  "Face for displaying scroll bar and line numbers in the display margin."
  :group 'yalinum)

(defcustom yalinum-eager t
  "Whether line numbers should be updated after each command.
The conservative setting `nil' might miss some buffer changes,
and you have to scroll or press \\[recenter-top-bottom] to update the numbers."
  :group 'yalinum
  :type 'boolean)

(defcustom yalinum-delay nil
  "Delay updates to give Emacs a chance for other changes."
  :group 'yalinum
  :type 'boolean)

;;;###autoload
(define-minor-mode yalinum-mode
  "Toggle display of line numbers in the left margin."
  :lighter ""                           ; for desktop.el
  (if yalinum-mode
      (progn
        (if yalinum-eager
            (add-hook 'post-command-hook (if yalinum-delay
                                             'yalinum-schedule
                                           'yalinum-update-current) nil t)
          (add-hook 'after-change-functions 'yalinum-after-change nil t))
        (add-hook 'window-scroll-functions 'yalinum-after-scroll nil t)
        ;; Using both window-size-change-functions and
        ;; window-configuration-change-hook seems redundant. --Stef
        ;; (add-hook 'window-size-change-functions 'yalinum-after-size nil t)
        (add-hook 'change-major-mode-hook 'yalinum-delete-overlays nil t)
        (add-hook 'window-configuration-change-hook
                  ;; FIXME: If the buffer is shown in N windows, this
                  ;; will be called N times rather than once.  We should use
                  ;; something like yalinum-update-window instead.
                  'yalinum-update-current nil t)
        (yalinum-update-current))
    (remove-hook 'post-command-hook 'yalinum-update-current t)
    (remove-hook 'post-command-hook 'yalinum-schedule t)
    ;; (remove-hook 'window-size-change-functions 'yalinum-after-size t)
    (remove-hook 'window-scroll-functions 'yalinum-after-scroll t)
    (remove-hook 'after-change-functions 'yalinum-after-change t)
    (remove-hook 'window-configuration-change-hook 'yalinum-update-current t)
    (remove-hook 'change-major-mode-hook 'yalinum-delete-overlays t)
    (yalinum-delete-overlays)))

;;;###autoload
(define-globalized-minor-mode global-yalinum-mode yalinum-mode yalinum-on)

(defun yalinum-on ()
  (unless (minibufferp)
    (yalinum-mode 1)))

(defun yalinum-delete-overlays ()
  "Delete all overlays displaying line numbers for this buffer."
  (mapc #'delete-overlay yalinum-overlays)
  (setq yalinum-overlays nil)
  (dolist (w (get-buffer-window-list (current-buffer) nil t))
    (set-window-margins w 0 (cdr (window-margins w)))))

(defun yalinum-update-current ()
  "Update line numbers for the current buffer."
  (yalinum-update (current-buffer)))

(defun yalinum-update (buffer)
  "Update line numbers for all windows displaying BUFFER."
  (with-current-buffer buffer
    (when yalinum-mode
      (setq yalinum-available yalinum-overlays)
      (setq yalinum-overlays nil)
      (save-excursion
        (mapc #'yalinum-update-window
              (get-buffer-window-list buffer nil 'visible)))
      (mapc #'delete-overlay yalinum-available)
      (setq yalinum-available nil))))

(defun yalinum-update-window (win)
  "Update line numbers for the portion visible in window WIN."
  ;; calc position in window.
  (save-excursion
    (move-to-window-line 0)
    (let* ((top-line (count-lines (point) (point-min)))
	   (line-max (count-lines (point-min) (point-max)))
	   ;; avoid zero divide.
	   (start-line (+ top-line (* (/ (float top-line) (max 1 line-max)) (window-height win))))
	   )
      (goto-char (window-start win))
      (let* ((line (line-number-at-pos))
	     (limit (window-end win t))
	     (fmt
	      (let ((w (length (number-to-string line-max))))
		;; replace format string.
		(replace-regexp-in-string
		 "\\$num"
		 (number-to-string (max w yalinum-line-number-length-min))
		 yalinum-line-number-display-format)))
	     (width 0)
	     ;; calc bar variables.
	     (bar-height (max 1 (truncate (* (/ (window-height win) (float (max 1 line-max))) (window-height win)))))
	     (bar-min (min (max start-line 0) (- line-max bar-height)))
	     (bar-max (min line-max (+ bar-min bar-height))))
	(run-hooks 'yalinum-before-numbering-hook)
	;; Create an overlay (or reuse an existing one) for each
	;; line visible in this window, if necessary.
	(while (and (not (eobp)) (<= (point) limit))
	  (let* ((str (if fmt
			  (propertize (format fmt line)
				      'face
				      (if (and (>= line bar-min) (<= line bar-max))
					  'yalinum-bar-face
					'yalinum-face))))
		 (visited (catch 'visited
			    (dolist (o (overlays-in (point) (point)))
			      (when (equal-including-properties
				     (overlay-get o 'yalinum-str) str)
				(unless (memq o yalinum-overlays)
				  (push o yalinum-overlays))
				(setq yalinum-available (delq o yalinum-available))
				(throw 'visited t))))))
	    (setq width (max width (length str)))
	    (unless visited
	      (let ((ov (if (null yalinum-available)
			    (make-overlay (point) (point))
			  (move-overlay (pop yalinum-available) (point) (point)))))
		(push ov yalinum-overlays)
		(overlay-put ov 'before-string
			     (propertize " " 'display `((margin left-margin) ,str)))
		(overlay-put ov 'yalinum-str str))))
	  ;; Text may contain those nasty intangible properties, but that
	  ;; shouldn't prevent us from counting those lines.
	  (let ((inhibit-point-motion-hooks t))
	    (forward-line))
	  (setq line (1+ line)))
	(set-window-margins win (truncate (* (+ width yalinum-width-base) yalinum-width-scale)))      
	))))

(defun yalinum-after-change (beg end len)
  ;; update overlays on deletions, and after newlines are inserted
  (when (or (= beg end)
            (= end (point-max))
            (string-match-p "\n" (buffer-substring-no-properties beg end)))
    (yalinum-update-current)))

(defun yalinum-after-scroll (win start)
  (yalinum-update (window-buffer win)))

;; (defun yalinum-after-size (frame)
;;   (yalinum-after-config))

(defun yalinum-schedule ()
  ;; schedule an update; the delay gives Emacs a chance for display changes
  (run-with-idle-timer 0 nil #'yalinum-update-current))

;; (defun yalinum-after-config ()
;;   (walk-windows (lambda (w) (yalinum-update (window-buffer w))) nil 'visible))

(defun yalinum-unload-function ()
  "Unload the Yalinum library."
  (global-yalinum-mode -1)
  ;; continue standard unloading
  nil)

(provide 'yalinum)

;;; yalinum.el ends here

;; elscreen にタブもどきをくっつけてみる．
;; 手動更新
;; (global-set-key [f9] #'elscreen-tab-toggle)
;; (global-set-key [f10] #'elscreen-tab-mode-line-update)
;; リアルタイム更新（ウザイ，遅い，危険？）
;; (setq timer (run-at-time t 1 #'elscreen-tab-mode-line-update))

(require 'cl)
(require 'elscreen)

(defface elscreen-tab-unselected-retrieving-face
  '((t :background "Gray70" :foreground "Gray50"
       :underline "Gray85" :box (:line-width -1 :style released-button)))
  "unselected")

(defface elscreen-tab-selected-retrieving-face
  '((t :background "Gray85" :foreground "black"
       :underline "Gray85" :box (:line-width -1 :style released-button)))
  "selected")

(defface elscreen-tab-background-face
  '((t :background "LightSteelBlue" :foreground "black"
       :underline "Gray85"))
  "background")

(defvar elscreen-tab-modified-hook)
(defvar *elscreen-tab-list*)

(defun elscreen-tab-create-name (name)
  (cond
   ((string-match "\\*navi2ch" name) "[navi2ch]")
   ((string-match "Messenger" name) "[messenger]")
   (t
    (if (< len limit)
	name
      (concat (truncate-string-to-width name (- limit 3)) "...")))))

(defun elscreen-tab-list ()
  (interactive)
  (if (string-match "Minibuf" (buffer-name (current-buffer)))
      *elscreen-tab-list*
    (do ((lst nil) (s (elscreen-get-current-screen)) (i 0 (+ i 1)))
	((>= i 10)
	 (when (elscreen-get-winconf s) (elscreen-goto0 s))
	 (setq *elscreen-tab-list*
	       (mapcar
		(lambda (e)
		  (let ((n (car e))
			(str (cdr e))
			(limit 13)
			(len (length (cdr e))))
		    (list
		     (propertize
		      (concat (int-to-string n) 
			      (if (eq n s) "+ " "- ")
			      (elscreen-tab-create-name str))
		      'face (if (eq n s)
				'elscreen-tab-selected-retrieving-face
			      'elscreen-tab-unselected-retrieving-face))
		     (propertize " " 'face 'elscreen-tab-background-face))))
		(nreverse lst)))
	 (append *elscreen-tab-list*
		 (list
		  (propertize (make-string (window-width) ?\ )
			      'face 'elscreen-tab-background-face))))
      (when (elscreen-get-winconf i)
	(elscreen-goto0 i)
	(setq lst (cons (cons i (elscreen-get-buffer-name-list)) lst))))))

(add-hook 'elscreen-tab-modified-hook
	  (lambda ()
	    ;;(setq header-line-format (elscreen-tab-list))))
	    (elscreen-tab-mode-line-update)))

(defun elscreen-tab-click (e)
  (interactive "e")
  (let* ((title (car (nth 4 (cadr e))))
	 (m (string-match "^\\([0-9]\\)[+-] " title))
	 (s (substring title (match-beginning 1) (match-end 1)))
	 (n (string-to-int s)))
    (when (elscreen-get-winconf n)
      (elscreen-goto n))))
      ;;(setq header-line-format (elscreen-tab-list)))))

(global-set-key [header-line down-mouse-1] 'ignore)
(global-set-key [header-line down-mouse-2] 'ignore)
;;(global-set-key [header-line drag-mouse-1] 'ignore)
;;(global-set-key [header-line drag-mouse-2] 'ignore)
(global-set-key [header-line mouse-1] #'elscreen-tab-click)
(global-set-key [header-line mouse-2] #'elscreen-tab-click)

(defmacro elscreen-tab-set-hooks (&rest functions)
  (cons 'progn
	(mapcar (lambda (f)
		  `(defadvice ,f (after elscreen-modified-hook activate)
		     (when (null (string-match "Minibuf" (buffer-name (current-buffer))))
		       (run-hooks 'elscreen-tab-modified-hook))))
		functions)))

(defun elscreen-tab-mode-line-update ()
  (interactive)
  (let* ((s (selected-window))
	 (lst (window-list))
	 (w nil))
    (mapcar (lambda (e)
	      (when (eq (window-at 0 0) e) (setq w e))
	      (select-window e)
	      (setq header-line-format nil)
	      (force-mode-line-update)) lst)
    (select-window w)
    (setq header-line-format (when (eq *elscreen-tab-show* :on) (elscreen-tab-list)))
    (force-mode-line-update)
    (select-window s)))

(defvar *elscreen-tab-show* :on)
(defun elscreen-tab-toggle (&optional on-off)
  (interactive)
  (setq *elscreen-tab-show*
	(if (or (eq on-off :on) (eq on-off :off))
	    on-off
	  (if (eq *elscreen-tab-show* :on) :off :on)))
  (elscreen-tab-mode-line-update))

(elscreen-tab-set-hooks
 elscreen-message elscreen-create elscreen-kill
 elscreen-previous elscreen-next elscreen-goto
 elscreen-toggle elscreen-jump elscreen-name
 ;;switch-to-buffer
 split-window delete-window find-file)

(provide 'elscreen-tab)

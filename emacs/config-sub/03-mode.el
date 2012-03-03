(add-hook 'python-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq indent-level 4)
            (setq python-indent 4)
            (unless (eq buffer-file-name nil) (flymake-mode t))
            (setq tab-width 4)))

(add-hook 'c-mode-hook
 (lambda ()
            (hs-minor-mode 1)
            (setq tab-width 4)))

(add-hook 'lisp-mode-hook
 (lambda ()
            (hs-minor-mode 1)
            (setq tab-width 4)))

(defun electric-pair ()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))

(require 'python)
(defvar is_emacs23 (>= emacs-major-version 23)) ;
;; (when is_emacs23
  ;; (defun python-partial-symbol ()
    ;; "Return the partial symbol before point (for completion)."
    ;; (let ((end (point))
          ;; (start (save-excursion
                   ;; (and (re-search-backward
                         ;; (rx (or buffer-start (regexp "[^[:alnum:]._]"))
                             ;; (group (1+ (regexp "[[:alnum:]._]"))) point)
                         ;; nil t)
                        ;; (match-beginning 1)))))
      ;; (if start (buffer-substring-no-properties start end))))
  ;; )

;; (defun ac-python-candidates ()
;;   (python-find-imports)
;;   (car (read-from-string
;;         (python-send-receive
;;          (format "emacs.complete(%S,%s)"
;;                  (python-partial-symbol)
;;                  python-imports)))))

;; (ac-define-source python
;;   '((candidates . ac-python-candidates)
;;     (prefix . (unless
;;                   (save-excursion
;;                     (re-search-backward "^import"
;;                                         (save-excursion
;;                                           (re-search-backward "^")) t))
;;                 (let ((symbol
;;                        (python-partial-symbol)
;;                        ))
;;                   (if symbol
;;                       (save-excursion (search-backward symbol))))))
;;     (symbol . "py-f")))

;; (add-hook
;;  'python-mode-hook
;;  '(lambda ()
;;     (add-to-list 'ac-sources 'ac-source-python)
;;     ))

;; (add-hook
;;  'inferior-python-mode-hook
;;  '(lambda ()
;;     (define-key inferior-python-mode-map "\C-c\C-f" 'python-describe-symbol)
;;     (define-key inferior-python-mode-map "\C-c\C-z" 'kill-buffer-and-window)
;;     (process-kill-without-query (get-process "Python"))
;;     ))

;; (setq my-hs-hide nil)
(defun my-toggle-hideshow-all () "Toggle hideshow all."
  (interactive)
  (setq my-hs-hide (not my-hs-hide))
  (if my-hs-hide
     (hs-hide-all)
     (hs-show-all)))


(setq whitespace-style
      '(tabs tab-mark spaces space-mark))
(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□])
        (tab-mark   ?\t   [?\xBB ?\t])
        ))
(require 'whitespace)
(global-whitespace-mode 1)
(set-face-foreground 'whitespace-space "LightSlateGray")
(set-face-background 'whitespace-space "DarkSlateGray")
(set-face-foreground 'whitespace-tab "LightSlateGray")
(set-face-background 'whitespace-tab "DarkSlateGray")

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(defun my-js2-indent-function ()
  (interactive)
  (save-restriction
    (widen)
    (let* ((inhibit-point-motion-hooks t)
           (parse-status (save-excursion (syntax-ppss (point-at-bol))))
           (offset (- (current-column) (current-indentation)))
           (indentation (espresso--proper-indentation parse-status))
           node)

      (save-excursion

        ;; I like to indent case and labels to half of the tab width
        (back-to-indentation)
        (if (looking-at "case\\s-")
            (setq indentation (+ indentation (/ espresso-indent-level 2))))

        ;; consecutive declarations in a var statement are nice if
        ;; properly aligned, i.e:
        ;;
        ;; var foo = "bar",
        ;;     bar = "foo";
        (setq node (js2-node-at-point))
        (when (and node
                   (= js2-NAME (js2-node-type node))
                   (= js2-VAR (js2-node-type (js2-node-parent node))))
          (setq indentation (+ 4 indentation))))

      (indent-line-to indentation)
      (when (> offset 0) (forward-char offset)))))

(defun my-indent-sexp ()
  (interactive)
  (save-restriction
    (save-excursion
      (widen)
      (let* ((inhibit-point-motion-hooks t)
             (parse-status (syntax-ppss (point)))
             (beg (nth 1 parse-status))
             (end-marker (make-marker))
             (end (progn (goto-char beg) (forward-list) (point)))
             (ovl (make-overlay beg end)))
        (set-marker end-marker end)
        (overlay-put ovl 'face 'highlight)
        (goto-char beg)
        (while (< (point) (marker-position end-marker))
          ;; don't reindent blank lines so we don't set the "buffer
          ;; modified" property for nothing
          (beginning-of-line)
          (unless (looking-at "\\s-*$")
            (indent-according-to-mode))
          (forward-line))
        (run-with-timer 0.5 nil '(lambda(ovl)
                                   (delete-overlay ovl)) ovl)))))

(defun my-js2-mode-hook ()
  (require 'espresso)
  (setq espresso-indent-level 4
        indent-tabs-mode nil
        c-basic-offset 4)
  (c-toggle-auto-state 0)
  (c-toggle-hungry-state 1)
  (set (make-local-variable 'indent-line-function) 'my-js2-indent-function)
  (define-key js2-mode-map [(meta control |)] 'cperl-lineup)
  (define-key js2-mode-map [(meta control \;)] 
    '(lambda()
       (interactive)
       (insert "/* -----[ ")
       (save-excursion
         (insert " ]----- */"))
       ))
  (define-key js2-mode-map [(return)] 'newline-and-indent)
  (define-key js2-mode-map [(backspace)] 'c-electric-backspace)
  (define-key js2-mode-map [(control d)] 'c-electric-delete-forward)
  (define-key js2-mode-map [(control meta q)] 'my-indent-sexp)
  (if (featurep 'js2-highlight-vars)
    (js2-highlight-vars-mode))
  (message "My JS2 hook"))

(add-hook 'js2-mode-hook 'my-js2-mode-hook)
(yas/reload-all)


(require 'yatex)
(setq auto-mode-alist (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq tex-command "/usr/texbin/platex")
(setq dvi2-command "/usr/texbin/xdvi")
(setq YaTeX-kanji-code 4) 
(add-hook 'yatex-mode-hook'(lambda ()(setq auto-fill-function nil)))


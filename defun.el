(defmacro m-cycle-values (var values)
  `(let ((i (cl-position ,var ,values)))
     (setq ,var (elt ,values (if (and i (< (1+ i) (length ,values))) (1+ i) 0)))))

(defmacro m-minibuffer-cmd (cmd)
  `(unless (minibufferp)
     (visual-mode -1)
     (call-interactively ,cmd)))

(defun c-backward-kill-line ()
  (interactive)
  (kill-region (f-beginning-of-line 0) (point)))

(defun c-backward-kill-sexp ()
  (interactive)
  (let ((pt (point)))
    (call-interactively (key-binding (kbd "C-M-b")))
    (kill-region (point) pt)))

(defun c-clear-shell ()
  (interactive)
  (unless (minibufferp)
    (let* ((modes '(python-mode ess-mode))
	   (buffers '("*Python*" "*R*"))
	   (i (cl-position major-mode modes)))
      (if i (with-temp-buffer
	      (switch-to-buffer (elt buffers i))
	      (f-clear-shell)
	      (switch-to-prev-buffer))
	(f-clear-shell)))))

(defun c-copy-buffer ()
  (interactive)
  (unless (minibufferp)
    (f-delete-trailing-whitespace)
    (kill-ring-save (point-min) (point-max))
    (message "Current buffer copied")))

(defun c-cua-rectangle-mark-mode (arg)
  (interactive "P")
  (unless (minibufferp)
    (visual-mode -1)
    (cua-rectangle-mark-mode)))

(defun c-cua-sequence-rectangle (first incr fmt)
  (interactive
   (let ((seq (split-string
	       (read-string (concat "1 (+1) ("
				    (substring cua--rectangle-seq-format 1)
				    "): ") nil nil))))
     (list (string-to-number (or (car seq) "1"))
    	   (string-to-number (or (cadr seq) "1"))
	   (concat "%" (cadr (cdr seq))))))
  (if (string= fmt "%") (setq fmt cua--rectangle-seq-format)
    (setq cua--rectangle-seq-format fmt))
  (cua--rectangle-operation 'clear nil t 1 nil
			    (lambda (s e _l _r)
			      (delete-region s e)
			      (insert (format fmt first))
			      (setq first (+ first incr)))))

(defun c-cycle-paren-shapes ()
  (interactive)
  (save-excursion
    (unless (looking-at-p (rx (any "(["))) (backward-up-list))
    (let ((pt (point))
	  (new (cond ((looking-at-p (rx "(")) (cons "[" "]"))
		     ((looking-at-p (rx "[")) (cons "(" ")"))
		     (t (beep) nil))))
      (when new
	(forward-sexp)
	(delete-char -1)
	(insert (cdr new))
	(goto-char pt)
	(delete-char 1)
	(insert (car new))))))

(defun c-cycle-search-whitespace-regexp ()
  (interactive)
  (unless (minibufferp)
    (m-cycle-values search-whitespace-regexp '("\\s-+" ".*?"))
    (message "search-whitespace-regexp: \"%s\"" search-whitespace-regexp)))

(defun c-delete-indentation ()
  (interactive)
  (delete-indentation))

(defun c-delete-pair ()
  (interactive)
  (while (not (looking-at-p "[([{<'\"]"))
    (left-char))
  (save-excursion (forward-sexp 1) (delete-char -1))
  (delete-char 1))

(defun c-dired ()
  (interactive)
  (switch-to-buffer (dired-noselect default-directory))
  (revert-buffer))

(defun c-eval-expression ()
  (interactive)
  (m-minibuffer-cmd 'eval-expression))

(defun c-execute-extended-command ()
  (interactive)
  (m-minibuffer-cmd 'execute-extended-command))

(defun c-find-file ()
  (interactive)
  (m-minibuffer-cmd 'find-file))

(defun c-highlight-symbol ()
  (interactive)
  (unless (minibufferp)
    (let ((s (highlight-symbol-get-symbol)))
      (if (or (not s) (highlight-symbol-symbol-highlighted-p s))
	  (highlight-symbol-remove-all)
	(highlight-symbol)
	(setq symbol/pos (point))))))

(defun c-highlight-symbol-definition ()
  (interactive)
  (unless (minibufferp)
    (let ((p t) (pt (point)) (s (highlight-symbol-get-symbol)))
      (when s
	(highlight-symbol-count s t)
	(unless (f-highlight-symbol-def-p s)
	  (setq symbol/pos pt)
	  (while (and p (not (f-highlight-symbol-def-p s)))
	    (highlight-symbol-jump 1)
	    (when (= pt (point)) (setq p nil))))))))

(defun c-highlight-symbol-next ()
  (interactive)
  (unless (minibufferp)
    (highlight-symbol-jump 1)
    (setq symbol/pos (point))))

(defun c-highlight-symbol-prev ()
  (interactive)
  (unless (minibufferp)
    (highlight-symbol-jump -1)
    (setq symbol/pos (point))))

(defun c-highlight-symbol-recall ()
  (interactive)
  (when symbol/pos
    (goto-char symbol/pos)
    (highlight-symbol-count (highlight-symbol-get-symbol) t)))

(defun c-indent-paragraph ()
  (interactive)
  (save-excursion
    (mark-paragraph)
    (indent-region (region-beginning) (region-end)))
  (when (bolp) (skip-chars-forward skip/chars)))

(defun c-isearch-yank ()
  (interactive)
  (if (not (use-region-p)) (isearch-yank-string (current-kill 0))
    (deactivate-mark)
    (isearch-yank-internal (lambda () (mark)))))

(defun c-kill-region ()
  (interactive)
  (if (use-region-p)
      (kill-region (region-beginning) (region-end))
    (kill-whole-line)
    (skip-chars-forward skip/chars)))

(defun c-kill-ring-save (bg ed)
  (interactive
   (if (use-region-p) (list (region-beginning) (region-end))
     (list (f-beginning-of-line 0) (line-end-position))))
  (kill-ring-save bg ed)
  (unless (minibufferp) (message "Current line copied")))

(defun c-kmacro-cycle-ring-next ()
  (interactive)
  (unless (minibufferp)
    (if (and last-kbd-macro (not kmacro-ring))
	(kmacro-display last-kbd-macro nil "Last macro")
      (kmacro-cycle-ring-next))))

(defun c-kmacro-cycle-ring-previous ()
  (interactive)
  (unless (minibufferp)
    (if (and last-kbd-macro (not kmacro-ring))
	(kmacro-display last-kbd-macro nil "Last macro")
      (kmacro-cycle-ring-previous))))

(defun c-kmacro-delete-ring-head ()
  (interactive)
  (unless (minibufferp)
    (kmacro-delete-ring-head)))

(defun c-kmacro-edit-macro ()
  (interactive)
  (unless (minibufferp)
    (kmacro-edit-macro)))

(defun c-kmacro-end-or-call-macro (arg)
  (interactive "P")
  (visual-mode)
  (cond ((minibufferp)
	 (if (eq last-command 'c-kmacro-end-or-call-macro) (insert "'()")
	   (insert "\\,(f-each )"))
	 (left-char))
	(defining-kbd-macro (kmacro-end-macro arg))
	((use-region-p)
	 (apply-macro-to-region-lines (region-beginning) (region-end)))
	(t (kmacro-call-macro arg t))))

(defun c-kmacro-start-macro (arg)
  (interactive "P")
  (visual-mode)
  (cond ((minibufferp)
	 (insert "\\,(f-incf)")
	 (left-char))
	(t (setq defining-kbd-macro nil)
	   (kmacro-start-macro arg))))

(defun c-mark-paragraph ()
  (interactive)
  (call-interactively (key-binding (kbd "M-h"))))

(defun c-move-backward-line ()
  (interactive)
  (let ((co (f-beginning-of-line 1)))
    (if (eq major-mode 'org-mode)
	(if (or (> (current-column) co) (= co 2)) (f-beginning-of-line)
	  (org-up-element) (skip-chars-forward skip/chars))
      (cond ((and (bolp) (not (eolp))) (end-of-line))
	    ((<= (current-column) co) (beginning-of-line))
	    (t (f-beginning-of-line))))))

(defun c-move-forward-line ()
  (interactive)
  (if (eq major-mode 'org-mode)
      (if (eolp) (f-beginning-of-line) (end-of-line))
    (cond ((and (eolp) (not (bolp))) (beginning-of-line))
	  ((>= (current-column) (f-beginning-of-line 1)) (end-of-line))
	  (t (f-beginning-of-line)))))

(defun c-org-evaluate-time-range ()
  (interactive)
  (or
   (org-clock-update-time-maybe)
   (save-excursion
     (unless (org-at-timestamp-p)
       (beginning-of-line)
       (re-search-forward org-tsr-regexp (line-end-position) t))
     (unless (org-at-timestamp-p)
       (user-error "")))
   (let* ((ts1 (match-string 0))
	  (time1 (org-time-string-to-time ts1))
	  (t1 (time-to-days time1))
	  (t2 (time-to-days (current-time)))
	  (diff (- t2 t1)))
     (message "%s" (f-org-make-tdiff-string diff)))))

(defun c-other-window ()
  (interactive)
  (if (minibufferp) (minibuffer-keyboard-quit)
    (let ((md major-mode))
      (other-window 1)
      (f-visual-mode (eq md major-mode)))))

(defun c-page-down ()
  (interactive)
  (unless (minibufferp) (beginning-of-line (1+ page/range))))

(defun c-page-up ()
  (interactive)
  (unless (minibufferp) (beginning-of-line (- (1- page/range)))))

(defun c-paragraph-backward ()
  (interactive)
  (call-interactively (key-binding (kbd "M-{")))
  (skip-chars-forward skip/chars))

(defun c-paragraph-forward ()
  (interactive)
  (call-interactively (key-binding (kbd "M-}")))
  (skip-chars-forward skip/chars))

(defun c-python-shell-send-line ()
  (interactive)
  (python-shell-send-region
   (line-beginning-position) (line-end-position)))

(defun c-query-replace ()
  (interactive)
  (unless (minibufferp)
    (if (highlight-symbol-symbol-highlighted-p
	 (highlight-symbol-get-symbol))
	(call-interactively 'highlight-symbol-query-replace)
      (call-interactively 'query-replace))))

(defun c-query-replace-regexp ()
  (interactive)
  (unless (minibufferp)
    (call-interactively 'query-replace-regexp)))

(defun c-racket-send-buffer ()
  (interactive)
  (racket-send-region
   (point-min) (point-max)))

(defun c-read-only-mode ()
  (interactive)
  (unless (minibufferp)
    (call-interactively (key-binding (kbd "C-x C-q")))
    (f-visual-mode)))

(defun c-revert-buffer ()
  (interactive)
  (and (not (minibufferp)) (buffer-modified-p)
       (revert-buffer t t)))

(defun c-set-or-exchange-mark (arg)
  (interactive "P")
  (if (use-region-p) (exchange-point-and-mark)
    (set-mark-command arg)))

(defun c-sort-lines-or-paragraphs ()
  (interactive)
  (unless (minibufferp)
    (if (use-region-p)
	(sort-lines nil (region-beginning) (region-end))
      (when (y-or-n-p "Sort all paragraphs?")
	(sort-paragraphs nil (point-min) (point-max))))))

(defun c-switch-to-next-buffer ()
  (interactive)
  (unless (minibufferp)
    (let ((p t) (bn (buffer-name)))
      (switch-to-next-buffer)
      (while (and p (not (f-normal-buffer-p)))
	(switch-to-next-buffer)
	(when (string= bn (buffer-name)) (setq p nil))))))

(defun c-switch-to-prev-buffer ()
  (interactive)
  (unless (minibufferp)
    (let ((p t) (bn (buffer-name)))
      (switch-to-prev-buffer)
      (while (and p (not (f-normal-buffer-p)))
	(switch-to-prev-buffer)
	(when (string= bn (buffer-name)) (setq p nil))))))

(defun c-switch-to-scratch ()
  (interactive)
  (switch-to-buffer "*scratch*"))

(defun c-toggle-comment (bg ed)
  (interactive
   (if (use-region-p) (list (region-beginning) (region-end))
     (list (line-beginning-position) (line-beginning-position 2))))
  (unless (minibufferp)
    (comment-or-uncomment-region bg ed)))

(defun c-toggle-frame ()
  (interactive)
  (m-cycle-values frame/transparency '(100 70))
  (set-frame-parameter (selected-frame) 'alpha frame/transparency))

(defun c-toggle-page ()
  (interactive)
  (unless (minibufferp)
    (m-cycle-values page/range '(10 20 50))
    (message "page/range: %s" page/range)))

(defun c-transpose-lines-down ()
  (interactive)
  (unless (minibufferp)
    (delete-trailing-whitespace)
    (end-of-line)
    (unless (eobp)
      (forward-line)
      (unless (eobp)
	(transpose-lines 1)
	(forward-line -1)
	(end-of-line)))))

(defun c-transpose-lines-up ()
  (interactive)
  (unless (minibufferp)
    (delete-trailing-whitespace)
    (beginning-of-line)
    (or (bobp) (eobp)
	(progn (forward-line)
	       (transpose-lines -1)
	       (beginning-of-line -1)))
    (skip-chars-forward skip/chars)))

(defun c-transpose-paragraphs-down ()
  (interactive)
  (unless (minibufferp)
    (let (p)
      (delete-trailing-whitespace)
      (backward-paragraph)
      (when (bobp) (setq p t) (newline))
      (forward-paragraph)
      (unless (eobp) (transpose-paragraphs 1))
      (when p (save-excursion (goto-char (point-min)) (kill-line))))))

(defun c-transpose-paragraphs-up ()
  (interactive)
  (or (minibufferp) (save-excursion (backward-paragraph) (bobp))
      (let (p)
	(delete-trailing-whitespace)
	(backward-paragraph 2)
	(when (bobp) (setq p t) (newline))
	(forward-paragraph 2)
	(transpose-paragraphs -1)
	(backward-paragraph)
	(when p (save-excursion (goto-char (point-min)) (kill-line))))))

(defun c-visual-mode ()
  (interactive)
  (visual-mode (and visual-mode -1)))

(defun c-word-capitalize ()
  (interactive)
  (capitalize-word -1))

(defun c-word-downcase ()
  (interactive)
  (downcase-word -1))

(defun c-word-upcase ()
  (interactive)
  (upcase-word -1))

(defun f-beginning-of-line (&optional arg)
  (let (pt co)
    (save-excursion
      (beginning-of-line)
      (skip-chars-forward skip/chars)
      (setq pt (point) co (current-column)))
    (cond ((eq arg 0) pt)
	  ((eq arg 1) co)
	  (t (move-to-column co)))))

(defun f-clear-shell ()
  (if (not (get-buffer-process (current-buffer)))
      (message "No inferior process")
    (delete-region (point-min) (point-max))
    (comint-send-input)
    (goto-char (point-min))
    (kill-line)))

(defun f-delete-trailing-whitespace ()
  (save-excursion
    (goto-char (point-max))
    (or buffer-read-only (bolp) (newline)))
  (delete-trailing-whitespace))

(defun f-each (ls &optional repeat)
  (let ((index (/ (cl-incf count 0) (or repeat 1))))
    (if (< index (length ls)) (elt ls index)
      (keyboard-quit))))

(defun f-highlight-symbol-def-p (symbol)
  (save-excursion
    (f-beginning-of-line)
    (looking-at-p (concat symbol/def symbol))))

(defun f-incf (&optional first incr repeat)
  (let ((index (/ (cl-incf count 0) (or repeat 1))))
    (+ (or first 1) (* (or incr 1) index))))

(defun f-normal-buffer-p ()
  (or (buffer-file-name)
      (string-match "*scratch\\|shell*" (buffer-name))))

(defun f-org-make-tdiff-string (diff)
  (let ((y (floor (/ diff 365))) (d (mod diff 365)) (fmt "") (l nil))
    (cond ((= diff 0) (setq fmt "today"))
	  ((< diff 0)
	   (if (< y 0) (setq fmt (concat fmt "%d year"  (if (< y -1) "s") " ")
			     l (push (- y) l)))
	   (setq fmt (concat fmt "%d day"  (if (< d 364) "s") " until")
		 l (push (- 365 d) l)))
	  ((> diff 0)
	   (if (> y 0) (setq fmt (concat fmt "%d year"  (if (> y 1) "s") " ")
			     l (push y l)))
	   (setq fmt (concat fmt "%d day"  (if (> d 1) "s") " since")
		 l (push d l))))
    (apply 'format fmt (nreverse l))))

(defun f-paragraph-set ()
  (setq paragraph-start "\f\\|[ \t]*$"
	paragraph-separate "[ \t\f]*$"))

(defun f-visual-mode (&optional p)
  (and visual-mode (not p) (visual-mode)))

(defvar frame/transparency 100)

(defvar move/pos 0)
(make-variable-buffer-local 'move/pos)

(defvar page/range 10)
(make-variable-buffer-local 'page/range)

(defvar skip/chars " \t")
(make-variable-buffer-local 'skip/chars)

(defvar symbol/def "(?def[a-z-]* ")
(make-variable-buffer-local 'symbol/def)

(defvar symbol/pos nil)
(make-variable-buffer-local 'symbol/pos)

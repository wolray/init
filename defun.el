(defmacro m-cycle-values (var values)
  `(let ((i (cl-position ,var ,values)))
     (setq ,var (elt ,values (if (and i (< (1+ i) (length ,values))) (1+ i) 0)))))

(defun c-backward-kill-line ()
  (interactive)
  (kill-region (f-beginning-of-line 0) (point)))

(defun c-backward-kill-sexp ()
  (interactive)
  (let ((pt (point))) (C-M-b) (kill-region (point) pt)))

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

(defun c-cycle-search-whitespace-regexp ()
  (interactive)
  (unless (minibufferp)
    (m-cycle-values search-whitespace-regexp '(" -+" ".*?"))
    (message "search-whitespace-regexp: \"%s\"" search-whitespace-regexp)))

(defun c-delete-pair ()
  (interactive)
  (when (re-search-backward (rx (any "([{<'\"")))
    (save-excursion (forward-sexp) (delete-char -1))
    (delete-char 1)))

(defun c-dired ()
  (interactive)
  (switch-to-buffer (dired-noselect default-directory))
  (revert-buffer))

(defun c-exchange-mark ()
  (interactive)
  (let ((marker (mark)))
    (push-mark nil t)
    (when marker (goto-char marker))))

(defun c-hs ()
  (interactive)
  (unless (minibufferp)
    (when (highlight-symbol-get-symbol)
      (highlight-symbol))))

(defun c-hs-definition ()
  (interactive)
  (unless (minibufferp)
    (let ((p t) (pt (point)) (s (highlight-symbol-get-symbol))
	  (highlight-symbol-occurrence-message nil))
      (when s
	(unless (f-hs-definition-p s)
	  (setq mark-active nil)
	  (while (and p (not (f-hs-definition-p s)))
	    (highlight-symbol-jump 1)
	    (when (= pt (point)) (setq p nil)))
	  (highlight-symbol-count s t))))))

(defun c-hs-next ()
  (interactive)
  (unless (minibufferp)
    (setq mark-active nil)
    (highlight-symbol-jump 1)))

(defun c-hs-prev ()
  (interactive)
  (unless (minibufferp)
    (setq mark-active nil)
    (highlight-symbol-jump -1)))

(defun c-indent-paragraph ()
  (interactive)
  (save-excursion
    (mark-paragraph)
    (indent-region (region-beginning) (region-end)))
  (when (bolp) (skip-chars-forward skip_chars)))

(defun c-isearch-done ()
  (interactive)
  (isearch-done))

(defun c-isearch-yank ()
  (interactive)
  (if (not (use-region-p)) (isearch-yank-string (current-kill 0))
    (setq mark-active nil)
    (isearch-yank-internal (lambda () (mark)))))

(defun c-kill-region ()
  (interactive)
  (if (use-region-p)
      (kill-region (region-beginning) (region-end))
    (kill-whole-line)
    (skip-chars-forward skip_chars)))

(defun c-kill-ring-save (bg ed)
  (interactive
   (if (use-region-p) (list (region-beginning) (region-end))
     (list (f-beginning-of-line 0) (line-end-position))))
  (kill-ring-save bg ed)
  (unless (minibufferp) (message "Current line copied")))

(defun c-kill-sexp ()
  (interactive)
  (let ((pt (point))) (C-M-f) (kill-region pt (point))))

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
  (unless (minibufferp) (kmacro-delete-ring-head)))

(defun c-kmacro-edit-macro ()
  (interactive)
  (unless (minibufferp) (kmacro-edit-macro)))

(defun c-kmacro-end-or-call-macro (arg)
  (interactive "P")
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
  (cond ((minibufferp) (insert "\\,(f-incf)") (left-char))
	(t (setq defining-kbd-macro nil)
	   (kmacro-start-macro arg))))

(defun c-move-backward-line ()
  (interactive)
  (let ((co (f-beginning-of-line 1)))
    (if (eq major-mode 'org-mode)
	(if (or (> (current-column) co) (= co 2)) (f-beginning-of-line)
	  (org-up-element) (skip-chars-forward skip_chars))
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

(defun c-open-current-folder ()
  (interactive)
  (when buffer-file-name
    (w32-shell-execute
     "open" "explorer"
     (concat "/e,/select,"
	     (convert-standard-filename buffer-file-name)))))

(defun c-push-mark ()
  (interactive)
  (push-mark))

(defun c-python-shell-send-line ()
  (interactive)
  (python-shell-send-region
   (line-beginning-position) (line-end-position)))

(defun c-query-replace ()
  (interactive)
  (unless (minibufferp)
    (cond ((use-region-p) (f-query-replace-region))
	  ((and (region-active-p) (setq mark-active nil)))
	  ((highlight-symbol-symbol-highlighted-p
	    (highlight-symbol-get-symbol))
	   (f-query-replace-hs))
	  (t (call-interactively 'query-replace)))))

(defun c-racket-send-buffer ()
  (interactive)
  (racket-send-region
   (point-min) (point-max)))

(defun c-reload-current-mode ()
  (interactive)
  (funcall major-mode))

(defun c-rename-file-and-buffer ()
  (interactive)
  (let ((old buffer-file-name) new)
    (when (and old (not (buffer-modified-p)))
      (setq new (read-file-name "Rename: " old))
      (when (file-exists-p new) (error "File already exists!"))
      (rename-file old new)
      (set-visited-file-name new t t))))

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
  (m-cycle-values frame_alpha '(100 70))
  (set-frame-parameter (selected-frame) 'alpha frame_alpha))

(defun c-transpose-lines-down ()
  (interactive)
  (unless (minibufferp)
    (let ((pt (point)) (co (current-column)))
      (f-delete-trailing-whitespace)
      (end-of-line 2)
      (if (eobp) (goto-char pt)
	(transpose-lines 1)
	(forward-line -1)
	(move-to-column co)))))

(defun c-transpose-lines-up ()
  (interactive)
  (unless (minibufferp)
    (let ((co (current-column)))
      (f-delete-trailing-whitespace)
      (beginning-of-line)
      (or (bobp) (eobp)
	  (progn (forward-line)
		 (transpose-lines -1)
		 (beginning-of-line -1)))
      (move-to-column co))))

(defun c-transpose-paragraphs-down ()
  (interactive)
  (unless (minibufferp)
    (let (p)
      (f-delete-trailing-whitespace)
      (backward-paragraph)
      (when (bobp) (setq p t) (newline))
      (forward-paragraph)
      (unless (eobp) (transpose-paragraphs 1))
      (when p (save-excursion (goto-char (point-min)) (kill-line))))))

(defun c-transpose-paragraphs-up ()
  (interactive)
  (or (minibufferp) (save-excursion (backward-paragraph) (bobp))
      (let (p)
	(f-delete-trailing-whitespace)
	(backward-paragraph 2)
	(when (bobp) (setq p t) (newline))
	(forward-paragraph 2)
	(transpose-paragraphs -1)
	(backward-paragraph)
	(when p (save-excursion (goto-char (point-min)) (kill-line))))))

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
      (skip-chars-forward skip_chars)
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

(defun f-hs-definition-p (symbol)
  (save-excursion
    (f-beginning-of-line)
    (looking-at-p (concat sym_def symbol))))

(defun f-incf (&optional first incr repeat)
  (let ((index (/ (cl-incf count 0) (or repeat 1))))
    (+ (or first 1) (* (or incr 1) index))))

(defun f-normal-buffer-p ()
  (or visual-mode
      buffer-file-name
      (eq (key-binding (kbd "q")) 'self-insert-command)))

(defun f-paragraph-set ()
  (setq paragraph-start "\f\\|[ \t]*$"
	paragraph-separate "[ \t\f]*$"))

(defun f-query-replace-hs ()
  (let ((hs (highlight-symbol-get-symbol))
	(replacement (read-string "Replacement: ")))
    (goto-char (beginning-of-thing 'symbol))
    (query-replace-regexp hs replacement)
    (setq query-replace-defaults (cons hs replacement))))

(defun f-query-replace-region ()
  (let ((region (buffer-substring-no-properties
		 (region-beginning) (region-end)))
	(replacement (read-string "Replacement: ")))
    (goto-char (region-beginning))
    (setq mark-active nil)
    (query-replace region replacement)
    (setq query-replace-defaults (cons region replacement))))

(defvar frame_alpha 100)

(defvar skip_chars " \t")
(make-variable-buffer-local 'skip_chars)

(defvar sym_def "(?def[a-z-]* ")
(make-variable-buffer-local 'sym_def)

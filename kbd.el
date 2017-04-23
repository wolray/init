(define-minor-mode visual-mode
  nil nil nil
  :keymap (make-sparse-keymap)
  (setq cursor-type (if visual-mode 'box 'bar)))

(defmacro m-ctrl-key (func)
  (let ((pfx (substring (symbol-name func) -1)))
    `(progn
       (define-key visual-mode-map (kbd ,pfx) ',func)
       (defun ,func ()
	 (interactive)
	 (let ((k (read-key-sequence nil)) ks cmd)
	   (unless (stringp k) (C-g))
	   (setq ks (concat "C-" ,pfx " " k)
		 cmd (key-binding (kbd ks)))
	   (if (commandp cmd) (call-interactively cmd)
	     (message "No command")))))))
(m-ctrl-key c-ctrl-c)
(m-ctrl-key c-ctrl-h)
(m-ctrl-key c-ctrl-x)

(defmacro m-key-to-command (func &optional before after)
  (let ((ks (subst-char-in-string ?+ ? (symbol-name func))))
    `(defun ,func ()
       (interactive)
       (let ((cmd (key-binding (kbd ,ks))))
	 ,before (when (commandp cmd) (call-interactively cmd)) ,after))))
(m-key-to-command <down>)
(m-key-to-command <left>)
(m-key-to-command <right>)
(m-key-to-command <up>)
(m-key-to-command C-/)
(m-key-to-command C-<down>)
(m-key-to-command C-<left>)
(m-key-to-command C-<right>)
(m-key-to-command C-<up>)
(m-key-to-command C-M-b)
(m-key-to-command C-M-f)
(m-key-to-command C-c+C-c)
(m-key-to-command C-c+C-h (unless (region-active-p) (beginning-of-line) (push-mark (point-max) t)))
(m-key-to-command C-c+C-y)
(m-key-to-command C-c+C-z)
(m-key-to-command C-g)
(m-key-to-command C-k)
(m-key-to-command C-y)
(m-key-to-command DEL)
(m-key-to-command M-h)
(m-key-to-command RET)
(m-key-to-command TAB)

(defmacro m-map-key (key obj)
  `(let* ((ks (cadr ',key)) (mk (kbd (concat "M-g " ks))))
     (define-key key-translation-map
       ,key (if (symbolp ,obj) (progn (global-set-key mk ,obj) mk) ,obj))))
(m-map-key (kbd "<f10>") 'toggle-truncate-lines)
(m-map-key (kbd "<f12>") 'c-toggle-frame)
(m-map-key (kbd "<f1>") 'c-visual-mode-turn)
(m-map-key (kbd "<f5>") (kbd "C-x C-s"))
(m-map-key (kbd "<f8>") 'auto-complete-mode)
(m-map-key (kbd "<f9>") 'nlinum-mode)
(m-map-key (kbd "<tab>") 'c-tab)
(m-map-key (kbd "M-'") 'comment-kill)
(m-map-key (kbd "M-,") nil)
(m-map-key (kbd "M-.") nil)
(m-map-key (kbd "M-/") nil)
(m-map-key (kbd "M-0") 'c-transpose-paragraphs-down)
(m-map-key (kbd "M-7") 'c-transpose-paragraphs-up)
(m-map-key (kbd "M-8") 'c-transpose-lines-up)
(m-map-key (kbd "M-9") 'c-transpose-lines-down)
(m-map-key (kbd "M-<") nil)
(m-map-key (kbd "M->") nil)
(m-map-key (kbd "M-[") nil)
(m-map-key (kbd "M-\"") nil)
(m-map-key (kbd "M-]") nil)
(m-map-key (kbd "M-a") nil)
(m-map-key (kbd "M-b") nil)
(m-map-key (kbd "M-c") nil)
(m-map-key (kbd "M-d") nil)
(m-map-key (kbd "M-e") (kbd "M-:"))
(m-map-key (kbd "M-f") nil)
(m-map-key (kbd "M-g") (kbd "C-g"))
(m-map-key (kbd "M-h") nil)
(m-map-key (kbd "M-i") 'c-word-downcase)
(m-map-key (kbd "M-j") 'c-kmacro-cycle-ring-previous)
(m-map-key (kbd "M-k") 'c-kmacro-delete-ring-head)
(m-map-key (kbd "M-l") 'c-kmacro-cycle-ring-next)
(m-map-key (kbd "M-m") nil)
(m-map-key (kbd "M-n") (kbd "C-M-i"))
(m-map-key (kbd "M-o") 'c-word-upcase)
(m-map-key (kbd "M-p") 'kmacro-edit-macro)
(m-map-key (kbd "M-q") (kbd "C-M-%"))
(m-map-key (kbd "M-r") 'other-window)
(m-map-key (kbd "M-s") (kbd "C-M-s"))
(m-map-key (kbd "M-t") nil)
(m-map-key (kbd "M-u") 'c-word-capitalize)
(m-map-key (kbd "M-v") nil)
(m-map-key (kbd "M-w") nil)
(m-map-key (kbd "M-y") nil)
(m-map-key (kbd "M-z") nil)
(m-map-key (kbd "M-{") nil)
(m-map-key (kbd "M-}") nil)
(m-map-key (kbd "TAB") 'c-tab)

(defun c-visual-mode ()
  (interactive)
  (visual-mode (and visual-mode -1)))

(defun c-visual-mode-turn ()
  (interactive)
  (visual-mode -1)
  (if (eq (key-binding (kbd ";")) 'c-visual-mode)
      (local-set-key (kbd ";") 'self-insert-command)
    (local-set-key (kbd ";") 'c-visual-mode)
    (visual-mode)))

(global-set-key (kbd "C-c C-c") 'eval-buffer)
(global-set-key (kbd "C-c C-h") 'eval-region)
(global-set-key (kbd "C-c C-y") 'eval-last-sexp)
(global-set-key (kbd "C-c c") 'C-c+C-c)
(global-set-key (kbd "C-c g") 'C-g)
(global-set-key (kbd "C-c h") 'C-c+C-h)
(global-set-key (kbd "C-c i") 'c-sort-text)
(global-set-key (kbd "C-c p") 'c-kmacro-start-macro)
(global-set-key (kbd "C-c y") 'C-c+C-y)
(global-set-key (kbd "C-c z") 'C-c+C-z)
(global-set-key (kbd "C-h g") 'keyboard-quit)
(global-set-key (kbd "C-x 4") 'winner-undo)
(global-set-key (kbd "C-x 8") 'beginning-of-buffer)
(global-set-key (kbd "C-x 9") 'end-of-buffer)
(global-set-key (kbd "C-x DEL") 'nil)
(global-set-key (kbd "C-x b") 'c-byte-compile)
(global-set-key (kbd "C-x c") 'save-buffers-kill-terminal)
(global-set-key (kbd "C-x d") 'c-dired)
(global-set-key (kbd "C-x e") 'eval-last-sexp)
(global-set-key (kbd "C-x f") 'find-file)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x i") 'c-open-folder)
(global-set-key (kbd "C-x k") 'c-revert-buffer)
(global-set-key (kbd "C-x l") 'c-clear-shell)
(global-set-key (kbd "C-x m") 'c-reload-current-mode)
(global-set-key (kbd "C-x q") 'read-only-mode)
(global-set-key (kbd "C-x r") 'c-rename-file-and-buffer)
(global-set-key (kbd "C-x s") 'save-buffer)
(global-set-key (kbd "C-x t") 'c-switch-to-scratch)
(global-set-key (kbd "C-x w") 'write-file)
(global-set-key (kbd "C-x x") 'c-copy-buffer)
(global-set-key (kbd "C-x z") 'suspend-frame)

(let ((map edmacro-mode-map))
  (define-key map (kbd "M-g M-p") 'kill-this-buffer)
  )

(let ((map isearch-mode-map))
  (define-key map (kbd "H-SPC") 'c-isearch-done)
  (define-key map (kbd "H-i") 'c-isearch-yank)
  (define-key map (kbd "H-o") 'isearch-repeat-forward)
  (define-key map (kbd "H-p") 'isearch-query-replace-regexp)
  (define-key map (kbd "H-u") 'isearch-repeat-backward)
  (define-key map (kbd "H-y") 'isearch-query-replace)
  )

(let ((map minibuffer-local-map))
  (define-key map (kbd "H-p") 'c-incf)
  (define-key map (kbd "M-g M-p") 'c-each)
  )

(let ((map query-replace-map))
  (define-key map (kbd ".") 'exit)
  (define-key map (kbd "4") 'recenter)
  (define-key map (kbd "h") 'automatic)
  (define-key map (kbd "r") 'backup)
  )

(let ((map visual-mode-map))
  (define-key map (kbd ",") 'C-M-b)
  (define-key map (kbd ".") 'C-M-f)
  (define-key map (kbd "0") 'C-<down>)
  (define-key map (kbd "1") 'delete-indentation)
  (define-key map (kbd "2") 'c-move-backward-line)
  (define-key map (kbd "3") 'c-move-forward-line)
  (define-key map (kbd "4") 'recenter-top-bottom)
  (define-key map (kbd "5") 'c-indent-paragraph)
  (define-key map (kbd "6") 'read-only-mode)
  (define-key map (kbd "7") 'C-<up>)
  (define-key map (kbd "8") '<up>)
  (define-key map (kbd "9") '<down>)
  (define-key map (kbd ";") 'self-insert-command)
  (define-key map (kbd "a") 'C-k)
  (define-key map (kbd "b") 'bs-show)
  (define-key map (kbd "d") 'c-kill-region)
  (define-key map (kbd "e") 'C-y)
  (define-key map (kbd "f") 'c-set-or-exchange-mark)
  (define-key map (kbd "g") 'C-g)
  (define-key map (kbd "i") 'c-visual-mode)
  (define-key map (kbd "j") '<left>)
  (define-key map (kbd "k") 'DEL)
  (define-key map (kbd "l") '<right>)
  (define-key map (kbd "m") 'RET)
  (define-key map (kbd "n") 'C-/)
  (define-key map (kbd "o") 'C-<right>)
  (define-key map (kbd "p") 'c-kmacro-end-or-call-macro)
  (define-key map (kbd "q") 'c-query-replace)
  (define-key map (kbd "r") 'other-window)
  (define-key map (kbd "s") 'c-isearch-forward)
  (define-key map (kbd "t") 'c-toggle-comment)
  (define-key map (kbd "u") 'C-<left>)
  (define-key map (kbd "v") 'split-line)
  (define-key map (kbd "w") 'c-kill-ring-save)
  (define-key map (kbd "y") 'c-marker-set-mark)
  (define-key map (kbd "z") 'ignore)
  )

(setq w32-apps-modifier 'hyper)
(global-set-key (kbd ";") 'c-visual-mode)
(global-set-key (kbd "H-,") 'backward-up-list)
(global-set-key (kbd "H--") 'c-insert-arrow-1)
(global-set-key (kbd "H-.") 'up-list)
(global-set-key (kbd "H-<backspace>") 'c-kill-buffer-other-window)
(global-set-key (kbd "H-<down>") 'enlarge-window)
(global-set-key (kbd "H-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "H-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "H-<up>") 'shrink-window)
(global-set-key (kbd "H-=") 'c-insert-arrow-2)
(global-set-key (kbd "H-SPC") 'C-g)
(global-set-key (kbd "H-\\") 'cua-rectangle-mark-mode)
(global-set-key (kbd "H-h") 'c-marker-recall-mark)
(global-set-key (kbd "H-i") 'symbol-overlay-put)
(global-set-key (kbd "H-j") 'c-switch-to-prev-buffer)
(global-set-key (kbd "H-k") 'kill-this-buffer)
(global-set-key (kbd "H-l") 'c-switch-to-next-buffer)
(global-set-key (kbd "H-m") 'c-delete-pair)
(global-set-key (kbd "H-n") 'hippie-expand)
(global-set-key (kbd "H-o") 'symbol-overlay-switch-forward)
(global-set-key (kbd "H-p") 'kmacro-view-macro)
(global-set-key (kbd "H-s") 'c-cycle-search-whitespace-regexp)
(global-set-key (kbd "H-u") 'symbol-overlay-switch-backward)
(global-set-key (kbd "H-y") 'c-marker-exchange-mark)

(with-eval-after-load 'auto-complete
  (let ((map ac-completing-map))
    (define-key map (kbd ",") 'ac-previous)
    (define-key map (kbd ".") 'ac-next)
    (define-key map (kbd "M-g <tab>") 'ac-expand)
    (define-key map (kbd "M-g TAB") 'ac-expand)
    ))

(with-eval-after-load 'bs
  (let ((map bs-mode-map))
    (define-key map (kbd "-") 'bs-set-current-buffer-to-show-never)
    (define-key map (kbd "=") 'bs-set-current-buffer-to-show-always)
    (define-key map (kbd "[") 'bs-up)
    (define-key map (kbd "]") 'bs-down)
    (define-key map (kbd "i") 'bs-select)
    (define-key map (kbd "o") 'bs-down)
    (define-key map (kbd "r") 'bs-select-other-window)
    (define-key map (kbd "u") 'bs-up)
    (define-key map (kbd "w") 'bs-toggle-readonly)
    (define-key map (kbd "%") nil)
    (define-key map (kbd "+") nil)
    (define-key map (kbd "C") nil)
    (define-key map (kbd "M") nil)
    (define-key map (kbd "S") nil)
    (define-key map (kbd "b") nil)
    (define-key map (kbd "f") nil)
    (define-key map (kbd "k") nil)
    (define-key map (kbd "n") nil)
    (define-key map (kbd "p") nil)
    (define-key map (kbd "t") nil)
    (define-key map (kbd "~") nil)
    ))

(with-eval-after-load 'cua-rect
  (let ((map cua--rectangle-keymap))
    (define-key map (kbd "<left>") 'cua-move-rectangle-left)
    (define-key map (kbd "<return>") 'c-cua-sequence-rectangle)
    (define-key map (kbd "<right>") 'cua-move-rectangle-right)
    (define-key map (kbd "M-g TAB") 'cua-rotate-rectangle)
    ))

(with-eval-after-load 'ess-mode
  (let ((map ess-mode-map))
    (define-key map (kbd "C-c C-c") 'ess-eval-buffer)
    (define-key map (kbd "C-c C-h") 'ess-eval-region)
    (define-key map (kbd "C-c C-y") 'ess-eval-line)
    (define-key map (kbd "_") nil)
    ))

(with-eval-after-load 'ess-r-post-run
  (let ((map ess-r-post-run-map))
    (define-key map (kbd "_") nil)
    ))

(with-eval-after-load 'haskell-mode
  (let ((map haskell-mode-map))
    (define-key map (kbd "C-c C-c") 'c-haskell-load-module)
    (define-key map (kbd "C-c C-z") 'switch-to-haskell)
    )
  (let ((map haskell-indentation-mode-map))
    (define-key map (kbd ",") nil)
    (define-key map (kbd ";") nil)
    ))

(with-eval-after-load 'magit-mode
  (let ((map magit-mode-map))
    (define-key map (kbd "4") 'recenter-top-bottom)
    (define-key map (kbd "[") 'magit-section-backward)
    (define-key map (kbd "]") 'magit-section-forward)
    (define-key map (kbd "n") nil)
    (define-key map (kbd "p") nil)
    ))

(with-eval-after-load 'org
  (let ((map org-mode-map))
    (define-key map (kbd "C-c RET") 'org-open-at-point)
    (define-key map (kbd "C-c d") 'org-toggle-link-display)
    (define-key map (kbd "C-c e") 'org-edit-special)
    (define-key map (kbd "C-c s") 'org-sort)
    (define-key map (kbd "C-c t") 'org-table-toggle-coordinate-overlays)
    ))

(with-eval-after-load 'package
  (let ((map package-menu-mode-map))
    (define-key map (kbd "[") 'previous-line)
    (define-key map (kbd "]") 'next-line)
    (define-key map (kbd "n") nil)
    (define-key map (kbd "p") nil)
    ))

(with-eval-after-load 'python
  (let ((map python-mode-map))
    (define-key map (kbd "C-c C-h") 'python-shell-send-region)
    (define-key map (kbd "C-c C-y") 'c-python-shell-send-line)
    (define-key map (kbd "C-c r") 'run-python)
    ))

(with-eval-after-load 'racket-mode
  (let ((map racket-mode-map))
    (define-key map (kbd "C-c C-c") 'c-racket-send-buffer)
    (define-key map (kbd "C-c C-y") 'racket-send-last-sexp)
    ))

(with-eval-after-load 'with-editor
  (let ((map with-editor-mode-map))
    (define-key map (kbd "C-c k") 'with-editor-cancel)
    ))

(define-minor-mode visual-mode
  :init-value nil
  :keymap (make-sparse-keymap)
  (setq cursor-type (if visual-mode 'box 'bar)))

(defmacro m-ctrl-key (func &optional key)
  (let ((pfx (substring (symbol-name func) -1)))
    `(progn
       (defun ,func ()
	 (interactive)
	 (let* ((k (read-key-sequence nil))
		(ks (concat "C-" ,pfx " " (when (string= ,pfx k) "C-") k))
		(cmd (key-binding (kbd ks))))
	   (when (commandp cmd) (call-interactively cmd))))
       (define-key visual-mode-map (kbd (or ,key ,pfx)) ',func))))
(m-ctrl-key c-ctrl-c)
(m-ctrl-key c-ctrl-h)
(m-ctrl-key c-ctrl-x)

(defmacro m-key-to-command (func &optional before after)
  (let ((ks (symbol-name func)))
    (and (> (length ks) 3) (string= (substring ks 3 4) "+")
	 (setq ks (concat (substring ks 0 3) " " (substring ks 4))))
    `(defun ,func ()
       (interactive)
       (let ((cmd (key-binding (kbd ,ks))))
	 ,before
	 (when (commandp cmd) (call-interactively cmd))
	 ,after))))
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
(m-key-to-command C-c+C-z)
(m-key-to-command C-g)
(m-key-to-command C-k)
(m-key-to-command C-s)
(m-key-to-command C-y)
(m-key-to-command DEL)
(m-key-to-command M-h)
(m-key-to-command RET)

(defmacro m-map-key (key obj)
  `(let* ((ks (cadr ',key)) (mk (kbd (concat "M-g " ks))))
     (define-key key-translation-map
       ,key (if (symbolp ,obj) (progn (global-set-key mk ,obj) mk) ,obj))))
(m-map-key (kbd "<f10>") 'toggle-truncate-lines)
(m-map-key (kbd "<f12>") 'c-toggle-frame)
(m-map-key (kbd "<f1>") (kbd "SPC"))
(m-map-key (kbd "<f5>") (kbd "C-x C-s"))
(m-map-key (kbd "<f8>") 'c-visual-mode-turn)
(m-map-key (kbd "<f9>") 'linum-mode)
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
(m-map-key (kbd "M-[") 'c-toggle-page)
(m-map-key (kbd "M-\"") nil)
(m-map-key (kbd "M-]") 'c-page-down)
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
(m-map-key (kbd "M-p") 'c-kmacro-edit-macro)
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

(global-set-key (kbd ";") 'c-visual-mode)
(global-set-key (kbd "C-c C-c") 'eval-buffer)
(global-set-key (kbd "C-c g") 'C-g)
(global-set-key (kbd "C-c h") 'eval-region)
(global-set-key (kbd "C-c i") 'c-sort-lines-or-paragraphs)
(global-set-key (kbd "C-c m") 'c-pt-set-mark)
(global-set-key (kbd "C-c n") 'c-pt-exchange-mark)
(global-set-key (kbd "C-c p") 'c-kmacro-start-macro)
(global-set-key (kbd "C-c y") 'eval-last-sexp)
(global-set-key (kbd "C-c z") 'C-c+C-z)
(global-set-key (kbd "C-h g") 'keyboard-quit)
(global-set-key (kbd "C-x ,") 'c-vl-update-folder)
(global-set-key (kbd "C-x .") 'c-vl-update)
(global-set-key (kbd "C-x 4") 'winner-undo)
(global-set-key (kbd "C-x 8") 'beginning-of-buffer)
(global-set-key (kbd "C-x 9") 'end-of-buffer)
(global-set-key (kbd "C-x C-x") 'c-copy-buffer)
(global-set-key (kbd "C-x DEL") 'nil)
(global-set-key (kbd "C-x c") 'save-buffers-kill-terminal)
(global-set-key (kbd "C-x d") 'c-dired)
(global-set-key (kbd "C-x e") 'eval-last-sexp)
(global-set-key (kbd "C-x f") 'find-file)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x k") 'c-revert-buffer)
(global-set-key (kbd "C-x l") 'c-clear-shell)
(global-set-key (kbd "C-x m") 'c-reload-current-mode)
(global-set-key (kbd "C-x o") 'c-open-current-folder)
(global-set-key (kbd "C-x q") 'read-only-mode)
(global-set-key (kbd "C-x r") 'c-rename-file-and-buffer)
(global-set-key (kbd "C-x s") 'save-buffer)
(global-set-key (kbd "C-x t") 'c-switch-to-scratch)
(global-set-key (kbd "C-x w") 'write-file)
(global-set-key (kbd "C-x z") 'suspend-frame)

(setq repeat-message-function 'ignore)
(define-key visual-mode-map (kbd ",") 'C-M-b)
(define-key visual-mode-map (kbd ".") 'C-M-f)
(define-key visual-mode-map (kbd "0") 'C-<down>)
(define-key visual-mode-map (kbd "1") 'delete-indentation)
(define-key visual-mode-map (kbd "2") 'c-move-backward-line)
(define-key visual-mode-map (kbd "3") 'c-move-forward-line)
(define-key visual-mode-map (kbd "4") 'recenter-top-bottom)
(define-key visual-mode-map (kbd "5") 'M-h)
(define-key visual-mode-map (kbd "6") 'c-indent-paragraph)
(define-key visual-mode-map (kbd "7") 'C-<up>)
(define-key visual-mode-map (kbd "8") '<up>)
(define-key visual-mode-map (kbd "9") '<down>)
(define-key visual-mode-map (kbd ";") 'self-insert-command)
(define-key visual-mode-map (kbd "a") 'C-k)
(define-key visual-mode-map (kbd "b") 'bs-show)
(define-key visual-mode-map (kbd "d") 'c-kill-region)
(define-key visual-mode-map (kbd "e") 'C-y)
(define-key visual-mode-map (kbd "f") 'c-set-or-exchange-mark)
(define-key visual-mode-map (kbd "g") 'C-g)
(define-key visual-mode-map (kbd "i") 'c-visual-mode)
(define-key visual-mode-map (kbd "j") '<left>)
(define-key visual-mode-map (kbd "k") 'DEL)
(define-key visual-mode-map (kbd "l") '<right>)
(define-key visual-mode-map (kbd "m") 'RET)
(define-key visual-mode-map (kbd "n") 'hippie-expand)
(define-key visual-mode-map (kbd "o") 'C-<right>)
(define-key visual-mode-map (kbd "p") 'c-kmacro-end-or-call-macro)
(define-key visual-mode-map (kbd "q") 'c-query-replace)
(define-key visual-mode-map (kbd "r") 'other-window)
(define-key visual-mode-map (kbd "s") 'C-s)
(define-key visual-mode-map (kbd "t") 'c-toggle-comment)
(define-key visual-mode-map (kbd "u") 'C-<left>)
(define-key visual-mode-map (kbd "v") 'split-line)
(define-key visual-mode-map (kbd "w") 'c-kill-ring-save)
(define-key visual-mode-map (kbd "y") 'repeat)
(define-key visual-mode-map (kbd "z") 'C-/)

(setq w32-apps-modifier 'hyper)
(global-set-key (kbd "H-,") 'backward-up-list)
(global-set-key (kbd "H-.") 'up-list)
(global-set-key (kbd "H-<down>") 'enlarge-window)
(global-set-key (kbd "H-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "H-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "H-<up>") 'shrink-window)
(global-set-key (kbd "H-SPC") 'C-g)
(global-set-key (kbd "H-\\") 'c-hs-remove-all)
(global-set-key (kbd "H-h") 'c-pt-recall-mark)
(global-set-key (kbd "H-i") 'c-hs-higlight)
(global-set-key (kbd "H-j") 'c-switch-to-prev-buffer)
(global-set-key (kbd "H-k") 'kill-this-buffer)
(global-set-key (kbd "H-l") 'c-switch-to-next-buffer)
(global-set-key (kbd "H-m") 'c-delete-pair)
(global-set-key (kbd "H-n") 'hippie-expand)
(global-set-key (kbd "H-o") 'c-hs-jump-next)
(global-set-key (kbd "H-p") 'c-cua-rectangle-mark-mode)
(global-set-key (kbd "H-s") 'c-cycle-search-whitespace-regexp)
(global-set-key (kbd "H-u") 'c-hs-jump-prev)
(global-set-key (kbd "H-y") 'c-hs-jump-to-definition)

;; cua
(require 'cua-rect)
(define-key cua--rectangle-keymap (kbd "<left>") 'cua-move-rectangle-left)
(define-key cua--rectangle-keymap (kbd "<return>") 'c-cua-sequence-rectangle)
(define-key cua--rectangle-keymap (kbd "<right>") 'cua-move-rectangle-right)
(define-key cua--rectangle-keymap (kbd "<tab>") 'cua-rotate-rectangle)

;; edmacro
(define-key edmacro-mode-map (kbd "M-g M-p") 'kill-this-buffer)

;; isearch
(define-key isearch-mode-map (kbd "H-SPC") 'c-isearch-done)
(define-key isearch-mode-map (kbd "H-i") 'c-isearch-yank)
(define-key isearch-mode-map (kbd "H-k") 'isearch-query-replace)
(define-key isearch-mode-map (kbd "H-o") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "H-u") 'isearch-repeat-backward)

;; query-replace
(define-key query-replace-map (kbd "4") 'recenter)
(define-key query-replace-map (kbd "h") 'automatic)
(define-key query-replace-map (kbd "r") 'backup)

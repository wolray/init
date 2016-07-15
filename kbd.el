(global-set-key (kbd "C-c C-c") 'eval-buffer)
(global-set-key (kbd "C-r") 'other-window)
(my-map-key 'avy-goto-char (kbd "C-n"))
(my-map-key 'avy-goto-char-2 (kbd "M-n"))
(my-map-key 'bs-show (kbd "C-b"))
(my-map-key 'comment-kill (kbd "M-'"))
(my-map-key 'delete-pair (kbd "C-d"))
(my-map-key 'delete-trailing-whitespace (kbd "C-S-<backspace>"))
(my-map-key 'eval-last-sexp (kbd "C-y"))
(my-map-key 'eval-last-sexp (kbd "M-y"))
(my-map-key 'isearch-forward-regexp (kbd "M-s"))
(my-map-key 'linum-mode (kbd "<f9>"))
(my-map-key 'magit-status (kbd "C-x g"))
(my-map-key 'my-backward-kill-line (kbd "M-DEL"))
(my-map-key 'my-capitalize-word (kbd "C-S-u"))
(my-map-key 'my-copy-buffer (kbd "C-x C-x"))
(my-map-key 'my-cycle-paren-shapes (kbd "M-i"))
(my-map-key 'my-downcase-word (kbd "C-S-i"))
(my-map-key 'my-kill-buffer (kbd "C-1"))
(my-map-key 'my-kill-region (kbd "C-w"))
(my-map-key 'my-kill-ring-save (kbd "M-w"))
(my-map-key 'my-move-beginning-of-line (kbd "C-8"))
(my-map-key 'my-move-beginning-of-line-reverse (kbd "C-c C-8"))
(my-map-key 'my-move-end-of-line (kbd "C-9"))
(my-map-key 'my-move-end-of-line-reverse (kbd "C-c C-9"))
(my-map-key 'my-page-down (kbd "M-p"))
(my-map-key 'my-page-up (kbd "M-]"))
(my-map-key 'my-paragraph-set (kbd "<f12>"))
(my-map-key 'my-sort-lines (kbd "C-4"))
(my-map-key 'my-sort-paragraphs (kbd "C-x 4"))
(my-map-key 'my-switch-to-scratch (kbd "C-x s"))
(my-map-key 'my-toggle-comment (kbd "C-t"))
(my-map-key 'my-toggle-frame-alpha (kbd "M-2"))
(my-map-key 'my-toggle-page-range (kbd "M-["))
(my-map-key 'my-toggle-search-whitespace-regexp (kbd "M-1"))
(my-map-key 'my-transpose-lines-down (kbd "C-*"))
(my-map-key 'my-transpose-lines-up (kbd "C-("))
(my-map-key 'my-transpose-paragraphs-down (kbd "M-*"))
(my-map-key 'my-transpose-paragraphs-up (kbd "M-("))
(my-map-key 'my-upcase-word (kbd "C-S-o"))
(my-map-key 'revert-buffer (kbd "C-x DEL"))
(my-map-key 'shrink-window (kbd "C-M-<up>"))
(my-map-key 'toggle-truncate-lines (kbd "<f10>"))
(my-map-key (kbd "<down>") (kbd "C-M-j"))
(my-map-key (kbd "<down>") (kbd "M-j"))
(my-map-key (kbd "<left>") (kbd "C-j"))
(my-map-key (kbd "<right>") (kbd "C-l"))
(my-map-key (kbd "<up>") (kbd "C-M-l"))
(my-map-key (kbd "<up>") (kbd "M-l"))
(my-map-key (kbd "C-/") (kbd "C-,"))
(my-map-key (kbd "C-/") (kbd "C-z"))
(my-map-key (kbd "C-/") (kbd "M-,"))
(my-map-key (kbd "C-/") (kbd "M-z"))
(my-map-key (kbd "C-<left>") (kbd "C-u"))
(my-map-key (kbd "C-<right>") (kbd "C-o"))
(my-map-key (kbd "C-@") (kbd "C-M-f"))
(my-map-key (kbd "C-@") (kbd "C-f"))
(my-map-key (kbd "C-@") (kbd "M-f"))
(my-map-key (kbd "C-M-%") (kbd "C-M-q"))
(my-map-key (kbd "C-M-b") (kbd "C-M-u"))
(my-map-key (kbd "C-M-b") (kbd "M-u"))
(my-map-key (kbd "C-M-f") (kbd "C-M-o"))
(my-map-key (kbd "C-M-f") (kbd "M-o"))
(my-map-key (kbd "C-M-i") (kbd "M-."))
(my-map-key (kbd "C-M-o") (kbd "C-v"))
(my-map-key (kbd "C-M-o") (kbd "M-v"))
(my-map-key (kbd "C-c <left>") (kbd "C-x 9"))
(my-map-key (kbd "C-c C-b") (kbd "C-c C-b"))
(my-map-key (kbd "C-c C-d") (kbd "C-c C-d"))
(my-map-key (kbd "C-c C-e") (kbd "C-c C-e"))
(my-map-key (kbd "C-c C-f") (kbd "C-c C-f"))
(my-map-key (kbd "C-c C-r") (kbd "C-c C-r"))
(my-map-key (kbd "C-c C-t") (kbd "C-c C-t"))
(my-map-key (kbd "C-c C-v") (kbd "C-c C-v"))
(my-map-key (kbd "C-c C-w") (kbd "C-c C-w"))
(my-map-key (kbd "C-c C-y") (kbd "C-c C-y"))
(my-map-key (kbd "C-c C-z") (kbd "C-c C-z"))
(my-map-key (kbd "C-g") (kbd "M-g"))
(my-map-key (kbd "C-k") (kbd "C-a"))
(my-map-key (kbd "C-l") (kbd "C-M-k"))
(my-map-key (kbd "C-l") (kbd "M-k"))
(my-map-key (kbd "C-u") (kbd "C-`"))
(my-map-key (kbd "C-x 2") (kbd "C-x p"))
(my-map-key (kbd "C-x <left>") (kbd "C-2"))
(my-map-key (kbd "C-x <right>") (kbd "C-3"))
(my-map-key (kbd "C-x C-0") (kbd "C-x C-t"))
(my-map-key (kbd "C-x C-f") (kbd "C-x C-f"))
(my-map-key (kbd "C-x C-i") (kbd "C-x C-i"))
(my-map-key (kbd "C-x C-o") (kbd "C-M-\\"))
(my-map-key (kbd "C-x C-o") (kbd "C-x C-o"))
(my-map-key (kbd "C-x C-q") (kbd "C-x C-q"))
(my-map-key (kbd "C-x C-r") (kbd "C-x C-r"))
(my-map-key (kbd "C-x C-s") (kbd "<f5>"))
(my-map-key (kbd "C-x C-u") (kbd "C-x C-u"))
(my-map-key (kbd "C-x C-w") (kbd "C-x C-w"))
(my-map-key (kbd "C-x C-z") (kbd "C-x C-z"))
(my-map-key (kbd "C-x ^") (kbd "C-M-<down>"))
(my-map-key (kbd "C-x h") (kbd "C-x C-h"))
(my-map-key (kbd "C-x o") (kbd "M-r"))
(my-map-key (kbd "C-x {") (kbd "C-M-<left>"))
(my-map-key (kbd "C-x }") (kbd "C-M-<right>"))
(my-map-key (kbd "C-y") (kbd "C-e"))
(my-map-key (kbd "C-y") (kbd "M-e"))
(my-map-key (kbd "DEL") (kbd "C-k"))
(my-map-key (kbd "M-%") (kbd "C-q"))
(my-map-key (kbd "M-/") (kbd "C-."))
(my-map-key (kbd "M-<") (kbd "M--"))
(my-map-key (kbd "M->") (kbd "M-="))
(my-map-key (kbd "M-^") (kbd "C-\\"))
(my-map-key (kbd "M-g M-(") (kbd "C-M-("))
(my-map-key (kbd "M-g M-*") (kbd "C-M-*"))
(my-map-key (kbd "M-g M-i") (kbd "C-M-i"))
(my-map-key (kbd "M-g M-n") (kbd "C-M-n"))
(my-map-key (kbd "M-g M-y") (kbd "C-M-y"))
(my-map-key (kbd "M-h") (kbd "C-M-h"))
(my-map-key (kbd "M-{") (kbd "C-M-9"))
(my-map-key (kbd "M-{") (kbd "M-9"))
(my-map-key (kbd "M-}") (kbd "C-M-8"))
(my-map-key (kbd "M-}") (kbd "M-8"))
(my-map-key (kbd "RET") (kbd "M-m"))
(my-map-key nil (kbd "C-"))
(my-map-key nil (kbd "C-'"))
(my-map-key nil (kbd "C--"))
(my-map-key nil (kbd "C-;"))
(my-map-key nil (kbd "C-<backspace>"))
(my-map-key nil (kbd "C-<tab>"))
(my-map-key nil (kbd "C-="))
(my-map-key nil (kbd "C-M--"))
(my-map-key nil (kbd "C-M-/"))
(my-map-key nil (kbd "C-M-;"))
(my-map-key nil (kbd "C-M-<backspace>"))
(my-map-key nil (kbd "C-M-="))
(my-map-key nil (kbd "C-M-["))
(my-map-key nil (kbd "C-M-]"))
(my-map-key nil (kbd "C-M-a"))
(my-map-key nil (kbd "C-M-b"))
(my-map-key nil (kbd "C-M-c"))
(my-map-key nil (kbd "C-M-d"))
(my-map-key nil (kbd "C-M-e"))
(my-map-key nil (kbd "C-M-p"))
(my-map-key nil (kbd "C-M-r"))
(my-map-key nil (kbd "C-M-s"))
(my-map-key nil (kbd "C-M-t"))
(my-map-key nil (kbd "C-M-w"))
(my-map-key nil (kbd "C-M-x"))
(my-map-key nil (kbd "C-S-<return>"))
(my-map-key nil (kbd "C-S-j"))
(my-map-key nil (kbd "C-S-k"))
(my-map-key nil (kbd "C-S-l"))
(my-map-key nil (kbd "C-S-p"))
(my-map-key nil (kbd "C-SPC"))
(my-map-key nil (kbd "C-]"))
(my-map-key nil (kbd "C-p"))
(my-map-key nil (kbd "C-x C--"))
(my-map-key nil (kbd "C-x C-0"))
(my-map-key nil (kbd "C-x C-="))
(my-map-key nil (kbd "C-x C-\\"))
(my-map-key nil (kbd "C-x C-]"))
(my-map-key nil (kbd "C-x C-a"))
(my-map-key nil (kbd "C-x C-b"))
(my-map-key nil (kbd "C-x C-d"))
(my-map-key nil (kbd "C-x C-e"))
(my-map-key nil (kbd "C-x C-p"))
(my-map-key nil (kbd "C-x C-v"))
(my-map-key nil (kbd "C-x \\"))
(my-map-key nil (kbd "C-x a"))
(my-map-key nil (kbd "C-x b"))
(my-map-key nil (kbd "C-x k"))
(my-map-key nil (kbd "C-x o"))
(my-map-key nil (kbd "C-x q"))
(my-map-key nil (kbd "C-x t"))
(my-map-key nil (kbd "C-x u"))
(my-map-key nil (kbd "C-{"))
(my-map-key nil (kbd "C-|"))
(my-map-key nil (kbd "C-}"))
(my-map-key nil (kbd "M-/"))
(my-map-key nil (kbd "M-\""))
(my-map-key nil (kbd "M-a"))
(my-map-key nil (kbd "M-b"))
(my-map-key nil (kbd "M-c"))
(my-map-key nil (kbd "M-d"))
(my-map-key nil (kbd "M-q"))

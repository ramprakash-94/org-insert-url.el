(require 'org)
(defun extract-text-in-tag (url start-tag end-tag)
  (interactive "MURL: ")
  (switch-to-buffer "*temp-bookmark*")
  (insert-buffer (url-retrieve-synchronously url))
  (search-forward start-tag nil t)
  (setq title-start (point))
  (search-forward end-tag nil t)
  (backward-char 2)
  (setq title-end (point))
  (setq extracted-title (buffer-substring title-start title-end))
  (kill-buffer "*temp-bookmark*"))

(defun extract-title-tag-from-kill ()
  (extract-text-in-tag (current-kill 0) "<title>" "</"))

(defun org-insert-url(&optional url)
  "Prompt user to enter a file name, with completion and history support."
  (interactive)
  (if (not url)
  (setq url (read-string "Enter URL: ")))
  (extract-text-in-tag url "<title>" "</")
  (org-insert-heading-respect-content)
  (insert "[[" url "][" extracted-title "]]") 
  (open-line 1))

(defun org-insert-url-from-kill()
  (interactive)
  (org-insert-url (current-kill 0)))


;; (global-set-key (kbd "M-b") 'org-insert-url-from-kill)



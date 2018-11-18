;;; org-insert-url.el --- A lightweight package to insert URLs as bookmarks in org
     
;; Copyright (C) 2018 Ram Prakash Arivu Chelvan

;; Author: Ram Prakash Arivu Chelvan <ramprakash.94@gmail.com>
;; Version: 0.1
;; Package-Requires: ((org "9.0"))
;; Keywords: url, bookmark, org
;; URL: https://github.com/ramprakash-94/org-insert-url.el

;;; Commentary:

;; org-insert-url.el is a lightweight package created to help you insert
;; external URLs into your org document with the webpage title.  The package
;; extracts the title from the webpage and inserts it into your org document
;; with a hyperlink to the URL.

;;; Code:
(require 'org)

;; Extracts the text between tag given the url, start-tag and end-tag
(defun org-insert-url-extract-text-in-tag (url start-tag end-tag)
  "Create a temporary buffer and fetches the HTML content of the webpage.
Argument URL URL of the webpage.
Argument START-TAG Starting tag.  Example: <title>.
Argument END-TAG Example: </>."
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

;; This function takes a URL as an optional argument if passed
;; If not, it takes it from user
(defun org-insert-url(&optional url)
  "Insert the extracted text into buffer.
Optional argument URL ."
  (interactive)
  (unless url
    (setq url (read-string "Enter URL: ")))
  (org-insert-url-extract-text-in-tag url "<title>" "</") ; Extracts title
  (org-insert-heading-respect-content) ; Inserts a heading/subheading
  (insert "[[" url "][" extracted-title "]]") ; Inserts the URL as a hyperlink
  (open-line 1))

;; This function inserts URL using the latest item from clipboard
(defun org-insert-url-from-kill()
  "Call ‘org-insert-url’ with the URL from kill."
  (interactive)
  (org-insert-url (current-kill 0)))


;; The hotkey that I use for this:
;; (global-set-key (kbd "M-b") 'org-insert-url-from-kill)

(provide 'org-insert-url)

;;; org-insert-url.el ends here

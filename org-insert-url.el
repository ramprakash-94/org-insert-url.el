;;; org-insert-url.el --- A lightweight package to insert URLs as bookmarks in org
     
;; Copyright (C) 2018 Ram Prakash Arivu Chelvan 

;; Author: Ram Prakash Arivu Chelvan <ramprakash.94@gmail.com>
;; Version: 0.1
;; Package-Requires: ((org "9.0"))
;; Keywords: url, bookmark, org
;; URL: https://github.com/ramprakash-94/org-insert-url.el

;;; Commentary:

;; org-insert-url.el is a lightweight package created to help you insert
;; external URLs into your org document with the webpage title. The package 
;; extracts the title from the webpage and inserts it into your org document 
;; with a hyperlink to the URL.

;; It also offers a function to directly take the URL from your clipboard
;; and insert it as new bullet in your org document.

;; Full documentation is available as an Info manual.

;;; Code:
(require 'org)

;; Extracts the text between tag given the url, start-tag and end-tag
(defun extract-text-in-tag (url start-tag end-tag)
  (interactive "MURL: ")
  ;; Creates a temporary buffer and fetches the HTML content of the webpage
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

;; This function takes a URL as an optional argument if passed
;; If not, it takes it from user
(defun org-insert-url(&optional url)
  (interactive)
  (unless url
    (setq url (read-string "Enter URL: ")))
  (extract-text-in-tag url "<title>" "</") ; Extracts title
  (org-insert-heading-respect-content) ; Inserts a heading/subheading
  (insert "[[" url "][" extracted-title "]]") ; Inserts the URL as a hyperlink
  (open-line 1))

;; This function inserts URL using the latest item from clipboard
(defun org-insert-url-from-kill()
  (interactive)
  (org-insert-url (current-kill 0)))


;; The hotkey that I use for this:
;; (global-set-key (kbd "M-b") 'org-insert-url-from-kill)

(provide 'org-insert-url)

;;; org-insert-url.el ends here

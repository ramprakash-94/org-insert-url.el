(defvar fb-url "https://www.googleapis.com/freebase/v1/search")

(defun fbquery (type str)
 (let ((url-request-method "GET"))
      (url-retrieve (str)
      (lambda (status) (switch-to-buffer (current-buffer))))))

(fbquery fb-url)

(require 'request)
(request
 "https://jsonplaceholder.typicode.com/todos/1"
 :parser 'json-read
 :success (progn
  (switch-to-buffer-other-window "*test*")
  (erase-buffer)
  (insert 'request-response-data)
  (other-window 1)))

(request-response-header (request "https://jsonplaceholder.typicode.com/todos/1"
					:parser 'json-read
					:sync t) "meta")
(defun my-view-source (url)
  (interactive "MURL: ")
  (switch-to-buffer (url-retrieve url (lambda (_)))))

(setq bookmark-url "http://www.google.com")
(defun my-view-source (url)
  (interactive "MURL: ")
  (switch-to-buffer (url-retrieve-synchronously bookmark-url)))

(defun extract-text-in-tag (url tag)
  (interactive "MURL: ")
  (switch-to-buffer "*temp-bookmark*")
  (insert-buffer (url-retrieve-synchronously bookmark-url))
  (search-forward tag nil t)
  (setq title-start (point))
  (search-forward "</" nil t)
  (backward-char 2)
  (setq title-end (point))
  (copy-region-as-kill title-start title-end )
  (setq extracted-text (gui-get-selection)))

(extract-text-in-tag "http://www.google.com" "<title>")
 

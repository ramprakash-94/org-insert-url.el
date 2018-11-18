# org-insert-url.el

org-insert-url.el is a lightweight package created to help you insert
external URLs into your org document with the webpage title. The package 
extracts the title from the webpage and inserts it into your org document 
with a hyperlink to the URL.

It also offers a function to directly take the URL from your clipboard
and insert it as a new bullet in your org document.

## Configuration

* org-insert-url allows the user to enter the URL into the minibuffer. 
* org-insert-url-from-kill takes the uses the last item from clipboard as URL and inserts it.

Both functions can be mapped to custom keybindings.

```lisp
(global-set-key (kbd <some-key>) 'org-insert-url)
(global-set-key (kbd <some-key>) 'org-insert-url-from-kill)
```

See [Screenshots](#Screenshots)
## Screenshots
![Copy URL](https://raw.githubusercontent.com/ramprakash-94/org-insert-url.el/master/screenshots/1.png)
![Command](https://raw.githubusercontent.com/ramprakash-94/org-insert-url.el/master/screenshots/2.png)
![Result](https://raw.githubusercontent.com/ramprakash-94/org-insert-url.el/master/screenshots/3.png)



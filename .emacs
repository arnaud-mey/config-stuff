;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups
(setq auto-save-default nil)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(require 'package) ;;
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

 (when (require 'so-long nil :noerror)
   (so-long-enable))

(require 'auto-complete-config)
(ac-config-default)

(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'auto-mode-alist '("\\.sls\\'" . salt-mode))
(require 'yaml-mode)
(require 'puppet-mode)
(setq kill-ring-max 1000)
 '(package-selected-packages
   (quote
    (find-file-in-project all-the-icons neotree jedi terraform-mode mmm-mode salt-mode puppet-mode)))
(global-flycheck-mode)
(require 'all-the-icons)
(require 'neotree)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (gorepl-mode go-mode terraform-mode kubernetes magit diff-hl treemacs-evil treemacs which-key yaml-mode so-long puppet-mode neotree jedi find-file-in-project all-the-icons))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun neotree-project-dir ()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (ffip-project-root))
        (file-name (buffer-file-name)))
    (if project-dir
        (progn
          (neotree-dir project-dir)
          (neotree-find file-name))
      (message "Could not find git project root."))))

(global-set-key [f8] 'neotree-project-dir)
;; Show matching parens
(setq show-paren-delay 0)
(show-paren-mode 1)

(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)

(global-linum-mode t)

(global-set-key (kbd "C-<next>") #'other-window)
(global-set-key (kbd "C-<prior>") 'previous-multiframe-window)

(use-package diff-hl
            :init
            (add-hook 'prog-mode-hook #'diff-hl-mode)
            (add-hook 'org-mode-hook #'diff-hl-mode)
            (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
            (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
            :config
            (setq diff-hl-fringe-bmp-function 'diff-hl-fringe-bmp-from-type)
            (setq diff-hl-margin-side 'left)
            (global-diff-hl-mode)
	    (diff-hl-flydiff-mode 1))

(add-to-list 'default-frame-alist '(fullscreen . maximized))

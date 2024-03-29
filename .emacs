;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; Align with spaces only
(defadvice align-regexp (around align-regexp-with-spaces)
  "Never use tabs for alignment."
  (let ((indent-tabs-mode nil))
    ad-do-it))
(ad-activate 'align-regexp)

(windmove-default-keybindings)

(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs-saves/" t)))
(setq create-lockfiles nil)
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

(add-to-list 'ac-modes 'terraform-mode)
(require 'auto-complete)
(global-auto-complete-mode t)

(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)


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
;;(require 'neotree)
;;(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(go markdown-mode rego-mode dumb-jump undo-tree projectile gorepl-mode go-mode terraform-mode kubernetes magit diff-hl treemacs-evil treemacs which-key yaml-mode so-long puppet-mode neotree jedi find-file-in-project all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;   (defun neotree-project-dir ()
;;     "Open NeoTree using the git root."
;;     (interactive)
;;     (let ((project-dir (projectile-project-root))
;;           (file-name (buffer-file-name)))
;;       (neotree-toggle)
;;       (if project-dir
;;           (if (neo-global--window-exists-p)
;;               (progn
;;                 (neotree-dir project-dir)
;;                 (neotree-find file-name)))
;;         (message "Could not find git project root."))))

;; (global-set-key [f8] 'neotree-project-dir)

;; (setq projectile-switch-project-action 'neotree-projectile-action)

(use-package terraform-mode
  :ensure t
  :custom
  (terraform-mode t)
)


(use-package treemacs
  :ensure t
  :defer t
  :bind
  ([f7] . treemacs)
  :custom
  (treemacs-collapse-dirs                   3)
  (treemacs-deferred-git-apply-delay        0.5)
  (treemacs-file-follow-delay               0.2)
  (treemacs-hide-dot-git-directory          t)
  (treemacs-indentation                     2)
  (treemacs-indentation-string              " ")
  (treemacs-missing-project-action          'ask)
  (treemacs-no-png-images                   t)
	;; If true: keep only current project expanded and all others closed.
  (treemacs-project-follow-cleanup nil)
  (treemacs-directory-name-transformer    #'identity)
  (treemacs-display-in-side-window        t)
  (treemacs-eldoc-display                 t)
  (treemacs-file-event-delay              5000)
  ;(treemacs-file-extension-regex          treemacs-last-period-regex-value)
  (treemacs-file-follow-delay             0.2)
  (treemacs-file-name-transformer         #'identity)
  (treemacs-follow-after-init             t)
  (treemacs-git-command-pipe              "")
  (treemacs-goto-tag-strategy             'refetch-index)
  (treemacs-indentation                   2)
  (treemacs-indentation-string            " ")
  (treemacs-is-never-other-window         nil)
  (treemacs-max-git-entries               5000)
  (treemacs-missing-project-action        'ask)
  (treemacs-no-png-images                 nil)
  (treemacs-no-delete-other-windows       t)
  (treemacs-project-follow-cleanup        nil)
  (treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory))
  (treemacs-position                      'left)
  (treemacs-read-string-input             'from-minibuffer)
  (treemacs-recenter-distance             0.1)
  (treemacs-recenter-after-file-follow    nil)
  (treemacs-recenter-after-tag-follow     nil)
  (treemacs-recenter-after-project-jump   'always)
  (treemacs-recenter-after-project-expand 'on-distance)
  (treemacs-show-cursor                   t)
  (treemacs-show-hidden-files             t)
  (treemacs-silent-filewatch              nil)
  (treemacs-silent-refresh                nil)
  (treemacs-sorting                       'alphabetic-asc)
  (treemacs-space-between-root-nodes      t)
  (treemacs-tag-follow-cleanup            t)
  (treemacs-tag-follow-delay              1.5)
  (treemacs-user-mode-line-format         nil)
  (treemacs-width                         45)
(treemacs-follow-mode t)
(treemacs-filewatch-mode t)
(treemacs-fringe-indicator-mode 'always)
(treemacs-git-mode 'deferred)

  )


(use-package treemacs-icons-dired
  :ensure t
  :hook (dired-mode . treemacs-icons-dired-mode)
)

(use-package treemacs-projectile
  :ensure t
  :after (treemacs projectile)
)

(use-package treemacs-magit
  :ensure t
  :after (treemacs magit)
)

(use-package treemacs-all-the-icons
  :ensure t
  :after treemacs
)
(provide 'treemacs-rcp)

(add-hook 'emacs-startup-hook 'treemacs)

;;(treemacs-load-theme 'Default)
;;; Commentary:
;;

;; (setq projectile-switch-project-action 'neotree-projectile-action)

;; Show matching parens




(defun add-or-switch-project-dwim (dir)
  "Let elisp do a few chores & set my hands free!"
  (interactive (list (read-directory-name "Add to known projects: ")))
  (projectile-add-known-project dir)
  (find-file dir)
  (treemacs-add-and-display-current-project))


(defun treemacs--force-git-update-current-file ()
  (-let [file (treemacs-canonical-path buffer-file-name)]
    (treemacs-run-in-every-buffer
     (when (treemacs-is-path file :in-workspace)
       (treemacs-update-single-file-git-state file)))))

(with-eval-after-load 'treemacs
  (defun treemacs--force-refresh ()
    "Forcely refreshes all the projects"
    (treemacs-run-in-every-buffer
       (treemacs-save-position
        (dolist (project (treemacs-workspace->projects workspace))
          (treemacs-project->refresh! project)))))
  (add-hook 'after-save-hook 'treemacs--force-refresh))




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


(projectile-mode +1)
;; Recommended keymap prefix on Windows/Linux
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq-default neo-show-hidden-files t)
(setq neo-window-width 60)

(setq mac-option-key-is-meta t)
(setq mac-right-option-modifier nil)
(global-undo-tree-mode)
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))

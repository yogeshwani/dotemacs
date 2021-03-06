;;start
(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(setenv "PYTHONPATH" "/usr/bin/python/")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (manoj-dark))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;Emacs configurations
(windmove-default-keybindings 'meta)

; Stop creating backup~ files
(setq make-backup-files nil)

; Stop creating #autosave# files
(setq auto-save-default nil)

; Show column in status bar
(setq column-number-mode 1)

;; Disable Emacs toolbar
(tool-bar-mode -1)

;;C Mode confiuration

;;C comment auto wraping setting
;Reference URl
;http://stackoverflow.com/questions/11969442/comment-mode-in-emacs
(setq fill-column 76)
(setq comment-auto-fill-only-comments t)
(auto-fill-mode t)

;;Indentation
(setq c-default-style "linux"
      c-basic-offset 4)

;;No TABS only spaces for indentation
(setq-default indent-tabs-mode nil)

;;Set the tab width = 4
(setq tab-width 4)

;;Elpy configuration
(elpy-enable)

(setq elpy-rpc-backend "jedi")

;;Set the elpy rpc python command to python3
(setq elpy-rpc-python-command "python3")

;;helm
(require 'helm)
(require 'helm-config)
;;helm useful keybindings
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)
;;get original UI for helm-semantic-or-imenu to display tags in c mode
;;taken from https://github.com/emacs-helm/helm/issues/1128
(with-eval-after-load 'helm-semantic
      (push '(c-mode . semantic-format-tag-summarize) helm-semantic-display-style)
      (push '(c++-mode . semantic-format-tag-summarize) helm-semantic-display-style))
(helm-mode 1)

;;;helm projectile configuration
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;;ggtags configuration
(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-prefix-key "\C-cg"
 helm-gtags-suggested-key-mapping t
 )

(require 'helm-gtags)
;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)

;;Cscope
;(add-to-list 'load-path "/xcscope.el")
(require 'xcscope)
(cscope-setup)
(setq cscope-relative-paths t)

;;Whitespace configuration
(require 'whitespace)
(global-whitespace-mode t)
(setq whitespace-global-modes '(c-mode c++-mode python-mode))
(setq whitespace-style '(face tabs lines-tail trailing))


;;Auto-complete configuration
; start auto-complete with emacs
(require 'auto-complete)
; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)

;;Yasnippet configuration
; start yasnippet with emacs
(require 'yasnippet)
(yas-global-mode 1)
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"~/repos/DIR/")
)

; now let's call this function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

;;Idit configuration 
; Fix iedit bug in Mac
(define-key global-map (kbd "C-c ;") 'iedit-mode)


;;CEDET confguration
;; This i built in so no need to install this package
; turn on Semantic
(semantic-mode 1)
; let's define a function which adds semantic as a suggestion backend to auto complete
; and hook this function to c-mode-common-hook
(defun my:add-semantic-to-autocomplete() 
  (add-to-list 'ac-sources 'ac-source-semantic)
)
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)


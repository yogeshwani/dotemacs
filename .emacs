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

;;;elpy configuration
(elpy-enable)
;(setq elpy-rpc-backend "rope")

;;helm
(require 'helm)
(require 'helm-config)
(helm-mode 1)

;;;helm projectile configuration
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;;helm useful keybindings
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)

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
  (add-to-list 'achead:include-directories '"~/repos/scsc-fw-maxwell-dev/")
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


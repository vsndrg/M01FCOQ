
;; ************************************************************
;;
;; GENERAL EMACS SETTINGS
;;
;; ************************************************************


;; =========================
;; Set default window size
;; =========================

(setq initial-frame-alist
      '((width . 180)     ; Width (in symbols)
        (height . 60)     ; Height (in strings)
        (left . 300)      ; Left corner position (in pixels)
        (top . 300)))     ; Top corner position (in pixels)

(setq default-frame-alist
      '((width . 180)     ; Width (in symbols)
        (height . 60)     ; Height (in strings)
        (left . 300)      ; Left corner position (in pixels)
        (top . 300)))     ; Top corner position (in pixels)


;; ====================================
;; Make Emacs window up when starting
;; ====================================

(add-hook 'window-setup-hook
          (lambda ()
            (raise-frame)
            (select-frame-set-input-focus (selected-frame))))

;; For creating new frames
(add-hook 'after-make-frame-functions
          (lambda (frame)
            (with-selected-frame frame
              (raise-frame)
              (select-frame-set-input-focus frame))))




;; ************************************************************
;;
;; EMACS EDITOR SETTINGS
;;
;; ************************************************************


;; ===========================
;; Set delete selection mode
;; ===========================

(delete-selection-mode 1) ;; Deletes selected text when you start typing

;; ==================
;; Set custom theme
;; ==================

(load-theme 'tango-dark t)

;; =====================
;; Disable sound alert
;; =====================

(setq ring-bell-function #'ignore)


;; =================
;; Set cursor mode
;; =================

(setq-default cursor-type 'bar)


;; ===============
;; Set scrolling
;; ===============

;; Scroll buffer up by one line, point stays on same screen line
(defun scroll-up-one-line ()
  "Scroll buffer upward by one line, keeping point position."
  (interactive)
  (scroll-up-command 1))

;; Scroll buffer down by one line, point stays on same screen line
(defun scroll-down-one-line ()
  "Scroll buffer downward by one line, keeping point position."
  (interactive)
  (scroll-down-command 1))

;; Bind to C-↓ / C-↑
(global-set-key (kbd "s-<down>") 'scroll-up-one-line)
(global-set-key (kbd "s-<up>")   'scroll-down-one-line)


;; =====================
;; Enable line numbers
;; =====================

;; Emacs 26+ built-in
(global-display-line-numbers-mode 1)


;;========================
;; Highlight cursor line
;;========================

(global-hl-line-mode 1)  ;; turn on hl-line-mode globally

;; After hl-line is loaded, adjust its face for a dark background
(with-eval-after-load 'hl-line
  (set-face-attribute 'hl-line nil
                      :background "#454745"  ;; dark-grey highlight
                      :foreground nil        ;; keep text color unchanged
                      :inherit nil))


;; ================================================
;; Highlight current line number in the margin
;; ================================================

;; Make sure line numbers are on
(global-display-line-numbers-mode 1)

(with-eval-after-load 'display-line-numbers
  ;; Use the same bg as hl-line for the current line number
  (set-face-attribute 'line-number-current-line nil
                      :background "#2f3436"   ;; match your hl-line bg
                      :foreground nil         ;; keep text color
                      :inherit 'hl-line))     ;; inherit any other hl-line settings


;; ============================
;; Customize the selection color
;; ============================

;; Set custom region (highlighted) color
(set-face-attribute 'region nil
                    :background "#3e5675"  ;; Background color for selection
                    :foreground nil) ;; Foreground color for selection text




;; ************************************************************
;;
;; PACKAGES SETUP
;;
;; ************************************************************


;; ====================
;; Coq packages setup
;; ====================

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(package-initialize)




;; ************************************************************
;;
;; COQ MODE SETTINGS
;;
;; ************************************************************


;; ==========================
;; Custom shortcuts for Coq
;; ==========================

(add-hook 'coq-mode-hook
  (lambda ()
    ;; unset the old binding, then set yours
    (local-unset-key (kbd "M-<down>"))
    (local-set-key   (kbd "M-<down>")  #'proof-assert-next-command-interactive)
    (local-set-key   (kbd "M-<up>")    #'proof-undo-last-successful-command)
    (local-set-key   (kbd "M-<right>") #'proof-goto-point)
    (local-set-key   (kbd "M-<left>")  #'proof-undo-and-retry)))


;; =========================================
;; Disable automatic Proof-General preview
;; =========================================

(with-eval-after-load 'proof-site
  (setq proof-splash-enable nil)        ;; Do not show Splash-screen when loading Proof-General
  (setq proof-auto-raise-buffers nil)   ;; Do not automatically up goal/response buffers
  (setq proof-three-window-enable nil)) ;; Disable three-window mode (leave script only)


;; =============
;; Column view
;; =============

(with-eval-after-load 'proof-site
  (setq proof-three-window-enable t)
  (setq proof-three-window-mode-policy 'hybrid)
  (add-hook 'coq-mode-hook #'proof-layout-windows))

;; ==================================
;; Highlight ordinary spaces in Coq
;; ==================================

(require 'whitespace)

;; Show spaces as centered dots
(setq whitespace-display-mappings
      '((space-mark ?\  [?\u00B7] [?.])))

;; Only highlight spaces (not tabs, newlines, etc.)
(setq whitespace-style '(face spaces space-mark))

;; Enable whitespace-mode in Coq buffers
(add-hook 'coq-mode-hook #'whitespace-mode)

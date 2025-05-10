;; ==================
;; Smooth scrolling
;; ==================

(setq scroll-step 1)                      ; Скроллить по 1 линии за раз
(setq scroll-conservatively 100)          ; Не прыгать при приближении к краю
(setq scroll-margin 5)                    ; Начать скроллинг за 5 строк до края
(setq auto-window-vscroll t)              ; Плавный пиксельный скроллинг
(setq scroll-up-aggressively 0.01)        ; "Агрессивность" скролла вверх
(setq scroll-down-aggressively 0.01)      ; "Агрессивность" скролла вниз

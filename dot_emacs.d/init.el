;;; init.el --- Emacs設定ファイル

;; package
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")))

(package-initialize)

;; use-packageの自動インストール
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;; 基本設定

;; 起動時のメッセージを非表示
(setq inhibit-startup-message t)

;; スクラッチバッファの初期メッセージを空に
(setq initial-scratch-message "")

;; ツールバーとメニューバーを非表示
(tool-bar-mode -1)
(menu-bar-mode -1)

;; スクロールバーを非表示
(scroll-bar-mode -1)

;; 行番号を表示
(global-display-line-numbers-mode 1)

;; 対応する括弧をハイライト
(show-paren-mode 1)

;; 現在行をハイライト
(global-hl-line-mode 1)
(set-face-underline 'hl-line nil)

;; 列番号を表示
(column-number-mode 1)

;; ビープ音を無効化
(setq ring-bell-function 'ignore)

;; バックアップファイルを作成しない
(setq make-backup-files nil)

;; 自動保存ファイルを作成しない
(setq auto-save-default nil)

;; ロックファイルを作成しない
(setq create-lockfiles nil)

;; 最近使ったファイルを記録
(recentf-mode 1)
(setq recentf-max-saved-items 100)

;; 自動リロード
(global-auto-revert-mode 1)

;; yes/no を y/n に短縮
(defalias 'yes-or-no-p 'y-or-n-p)

;; 空白文字を可視化
(setq-default show-trailing-whitespace t)

;; インデントにタブを使わない
(setq-default indent-tabs-mode nil)

;; タブ幅を4に設定
(setq-default tab-width 4)

;;; エンコーディング設定

;; UTF-8を優先
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;;; キーバインド設定

;; Ctrl-h をファイル削除にバインド
(global-set-key (kbd "C-h") 'delete-backward-char)

;; ミニバッファでもC-hを文字削除に設定
(define-key minibuffer-local-map (kbd "C-h") 'delete-backward-char)
(define-key minibuffer-local-ns-map (kbd "C-h") 'delete-backward-char)
(define-key minibuffer-local-completion-map (kbd "C-h") 'delete-backward-char)
(define-key minibuffer-local-must-match-map (kbd "C-h") 'delete-backward-char)

;; C-x C-b でバッファリストを ibuffer で開く
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; C-x k でカレントバッファを即座に削除
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; ウィンドウ移動を簡単に
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)

;;; テーマ設定

;; 内蔵テーマを使用
(load-theme 'wombat t)

;;; 便利な関数

;; 現在のバッファをリロード
(defun reload-buffer ()
  "現在のバッファをリロードします。"
  (interactive)
  (revert-buffer t t))

(global-set-key (kbd "C-c r") 'reload-buffer)

;; 設定ファイルを素早く開く
(defun open-init-file ()
  "init.elを開きます。"
  (interactive)
  (find-file user-init-file))

(global-set-key (kbd "C-c i") 'open-init-file)

;;; モード固有の設定

;; テキストモードでの自動改行
(add-hook 'text-mode-hook 'auto-fill-mode)

;; プログラミングモードでの共通設定
(add-hook 'prog-mode-hook
          (lambda ()
            (setq show-trailing-whitespace t)
            (electric-pair-mode 1)))

;;; 自動インストールされるパッケージ

;; which-key: キーバインドのヘルプを表示
(use-package which-key
  :config
  (which-key-mode))

;; magit: Gitクライアント
(use-package magit
  :bind ("C-x g" . magit-status))

;; company: 自動補完
(use-package company
  :config
  (global-company-mode)
  (setq company-idle-delay 0.3)
  (setq company-minimum-prefix-length 2))

;; vertico: 垂直型補完UI
(use-package vertico
  :config
  (vertico-mode)
  ;; 最大表示候補数を設定
  (setq vertico-count 20)
  ;; 最初の候補を選択状態にする
  (setq vertico-preselect 'directory))

;; orderless: 柔軟な検索パターン
(use-package orderless
  :config
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion))))
  ;; 日本語でも使いやすいように設定
  (setq orderless-matching-styles
        '(orderless-literal orderless-regexp orderless-flex)))

;; marginalia: 補完候補の詳細情報表示
(use-package marginalia
  :config
  (marginalia-mode)
  ;; 日本語環境でも適切に表示されるように設定
  (setq marginalia-max-relative-age 0)
  (setq marginalia-align 'right))

;; consult: 追加コマンド
(use-package consult
  :bind (("C-x b" . consult-buffer)
         ("C-x C-r" . consult-recent-file)
         ("C-s" . consult-line)
         ("M-g g" . consult-goto-line)
         ("M-g M-g" . consult-goto-line)
         ("M-y" . consult-yank-pop)
         ("C-c h" . consult-history)
         ("C-c m" . consult-mode-command)
         ("C-c k" . consult-kmacro)
         ("C-x M-:" . consult-complex-command)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x 5 b" . consult-buffer-other-frame)
         ("C-x r b" . consult-bookmark)
         ("C-x p b" . consult-project-buffer)
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)
         ("C-M-#" . consult-register)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)
         ("M-g o" . consult-outline)
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)
         ("M-s e" . consult-isearch-history)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         :map minibuffer-local-map
         ("M-s" . consult-history)
         ("M-r" . consult-history))
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)
  (advice-add #'register-preview :override #'consult-register-window)
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :config
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   :preview-key '(:debounce 0.4 any))
  (setq consult-narrow-key "<"))

;; embark: 選択項目に対するアクション
(use-package embark
  :bind
  (("C-." . embark-act)
   ("C-;" . embark-dwim)
   ("C-c e" . embark-bindings))
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; embark-consult: embarkとconsultの統合
(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; typescript-mode
(use-package typescript-mode
  :mode ("\\.ts\\'" "\\.tsx\\'")
  :config
  (setq typescript-indent-level 4))

;; web-mode
(use-package web-mode
  :mode ("\\.vue\\'" "\\.html\\'")
  :config
  (setq typescript-indent-level 4))

;; astro-mode
(define-derived-mode astro-mode web-mode "astro")
(setq auto-mode-alist
      (append '((".*\\.astro\\'" . astro-mode))
              auto-mode-alist))

;; eglot: Language Server Protocol client
(use-package eglot
  :hook ((typescript-mode . eglot-ensure)
         (js-mode . eglot-ensure)
         (astro-mode . eglot-ensure))
  :config
  ;; TypeScript用の設定
  (add-to-list 'eglot-server-programs
               '((typescript-mode js-mode) . ("typescript-language-server" "--stdio")))

  ;; ASTRO
  (add-to-list 'eglot-server-programs
               '(astro-mode . ("astro-ls" "--stdio"
                               :initializationOptions
                               (:typescript (:tsdk "./node_modules/typescript/lib")))))

  ;; 保存時に自動フォーマット
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (add-hook 'before-save-hook #'eglot-format-buffer -10 t))))

;;; カスタム設定

;; customize経由の設定を別ファイルに分離
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;;; 最終設定

;; ガベージコレクションの閾値を元に戻す
(setq gc-cons-threshold (* 2 1000 1000))

(provide 'init)

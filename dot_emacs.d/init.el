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

;; helm: 検索・選択インターフェース
(use-package helm
  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x b" . helm-buffers-list)
         ("C-x C-r" . helm-recentf))
  :config
  (helm-mode 1))

;;; カスタム設定

;; customize経由の設定を別ファイルに分離
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;;; 最終設定

;; ガベージコレクションの閾値を元に戻す
(setq gc-cons-threshold (* 2 1000 1000))

(provide 'init)

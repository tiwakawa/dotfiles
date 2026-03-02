#!/bin/bash
# macOS システム設定スクリプト
# 実行: bash macos/defaults.sh

set -e

echo "macOS defaults を設定します..."

# ------------------------------
# Finder
# ------------------------------
# 隠しファイルを表示する
defaults write com.apple.finder AppleShowAllFiles -bool true

# 拡張子を常に表示する
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# パスバーを表示する
defaults write com.apple.finder ShowPathbar -bool true

# ステータスバーを表示する
defaults write com.apple.finder ShowStatusBar -bool true

# デフォルトの検索スコープをカレントフォルダにする
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# フォルダを常に先頭に表示する
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# ------------------------------
# Dock
# ------------------------------
# Dock を自動的に隠す
defaults write com.apple.dock autohide -bool true

# Dock のサイズ
defaults write com.apple.dock tilesize -int 48

# 最近使ったアプリを Dock に表示しない
defaults write com.apple.dock show-recents -bool false

# ------------------------------
# キーボード
# ------------------------------
# キーリピートを速く
defaults write NSGlobalDomain KeyRepeat -int 2

# キーリピート開始までの遅延を短く
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# ------------------------------
# スクリーンショット
# ------------------------------
# スクリーンショットの保存先をデスクトップに設定
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# スクリーンショットに影をつけない
defaults write com.apple.screencapture disable-shadow -bool true

# ------------------------------
# トラックパッド
# ------------------------------
# タップでクリックを有効にする
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# ------------------------------
# VSCode
# ------------------------------
# キーリピートを有効にする（長押しで文字選択メニューが出ないようにする）
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

# ------------------------------
# 反映のため再起動が必要なプロセスを再起動
# ------------------------------
for app in "Finder" "Dock"; do
  killall "${app}" &>/dev/null || true
done

echo "完了。一部の設定はログアウト/再起動後に反映されます。"

#!/bin/bash
# DevContainer 専用 dotfiles セットアップ
# macOS 向けの setup.sh は使わず、必要なシンボリックリンクだけ作成する

set -euo pipefail

DOTFILES_DIR="/root/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "ERROR: $DOTFILES_DIR が見つかりません。マウント設定を確認してください。" >&2
  exit 1
fi

# $HOME/.config が存在しない場合は作成
mkdir -p "$HOME/.config"

# シンボリックリンクを強制作成（既存ファイル/リンクがあっても上書き）
ln -sf "$DOTFILES_DIR/zsh/.zshrc"            "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"
ln -sf "$DOTFILES_DIR/git/.gitconfig"         "$HOME/.gitconfig"

echo "dotfiles を適用しました:"
echo "  ~/.zshrc            -> $DOTFILES_DIR/zsh/.zshrc"
echo "  ~/.config/starship.toml -> $DOTFILES_DIR/starship/starship.toml"
echo "  ~/.gitconfig        -> $DOTFILES_DIR/git/.gitconfig"

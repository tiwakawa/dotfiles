#!/bin/bash
# DevContainer 専用 dotfiles セットアップ
# macOS 向けの setup.sh は使わず、必要なシンボリックリンクだけ作成する

set -euo pipefail

DOTFILES_DIR="/root/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "ERROR: $DOTFILES_DIR が見つかりません。マウント設定を確認してください。" >&2
  exit 1
fi

# curl がなければインストール
if ! command -v curl &>/dev/null; then
  echo "curl をインストールしています..."
  if command -v apt-get &>/dev/null; then
    apt-get update -qq && apt-get install -y -qq curl
  elif command -v dnf &>/dev/null; then
    dnf install -y -q curl
  elif command -v yum &>/dev/null; then
    yum install -y -q curl
  else
    echo "ERROR: パッケージマネージャーが見つかりません。curl を手動でインストールしてください。" >&2
    exit 1
  fi
fi

# git がなければインストール
if ! command -v git &>/dev/null; then
  echo "git をインストールしています..."
  if command -v apt-get &>/dev/null; then
    apt-get update -qq && apt-get install -y -qq git
  elif command -v dnf &>/dev/null; then
    dnf install -y -q git
  elif command -v yum &>/dev/null; then
    yum install -y -q git
  else
    echo "ERROR: パッケージマネージャーが見つかりません。git を手動でインストールしてください。" >&2
    exit 1
  fi
fi

# zsh がなければインストール
if ! command -v zsh &>/dev/null; then
  echo "zsh をインストールしています..."
  if command -v apt-get &>/dev/null; then
    apt-get update -qq && apt-get install -y -qq zsh
  elif command -v dnf &>/dev/null; then
    dnf install -y -q zsh
  elif command -v yum &>/dev/null; then
    yum install -y -q zsh
  else
    echo "ERROR: パッケージマネージャーが見つかりません。zsh を手動でインストールしてください。" >&2
    exit 1
  fi
fi

# starship がなければインストール
if ! command -v starship &>/dev/null; then
  echo "starship をインストールしています..."
  curl -fsSL https://starship.rs/install.sh | sh -s -- --yes
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

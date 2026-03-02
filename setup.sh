#!/bin/bash
# dotfiles セットアップスクリプト
# 実行: bash setup.sh

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# カラー出力
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

info()    { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
error()   { echo -e "${RED}[ERROR]${NC} $1"; }

# 既存ファイルをバックアップしてシンボリックリンクを作成する関数
# usage: link <dotfiles内のパス> <リンク先のパス>
link() {
  local src="$1"
  local dest="$2"
  local dest_dir
  dest_dir="$(dirname "$dest")"

  # リンク先ディレクトリが存在しない場合は作成
  if [ ! -d "$dest_dir" ]; then
    mkdir -p "$dest_dir"
    info "ディレクトリを作成しました: $dest_dir"
  fi

  # 既存ファイル/リンクのバックアップ
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    local backup="${dest}.bak.$(date +%Y%m%d%H%M%S)"
    warn "既存ファイルをバックアップします: $dest -> $backup"
    mv "$dest" "$backup"
  elif [ -L "$dest" ]; then
    # すでにシンボリックリンクの場合は削除
    rm "$dest"
  fi

  ln -s "$src" "$dest"
  info "リンクを作成しました: $dest -> $src"
}

# ------------------------------
# シンボリックリンクの作成
# ------------------------------
echo ""
echo "========================================="
echo " dotfiles セットアップ"
echo "========================================="
echo ""

info "シンボリックリンクを作成します..."

link "$DOTFILES_DIR/zsh/.zshrc"              "$HOME/.zshrc"
link "$DOTFILES_DIR/git/.gitconfig"           "$HOME/.gitconfig"
link "$DOTFILES_DIR/starship/starship.toml"   "$HOME/.config/starship.toml"
link "$DOTFILES_DIR/ssh/config"               "$HOME/.ssh/config"
link "$DOTFILES_DIR/vscode/settings.json"     "$HOME/Library/Application Support/Code/User/settings.json"
link "$DOTFILES_DIR/vscode/keybindings.json"  "$HOME/Library/Application Support/Code/User/keybindings.json"

# SSH config のパーミッションを設定（セキュリティ要件）
chmod 700 "$HOME/.ssh"
chmod 600 "$HOME/.ssh/config"
info "SSH config のパーミッションを設定しました (700/600)"

# ------------------------------
# VSCode 拡張機能のインストール
# ------------------------------
echo ""
info "VSCode 拡張機能をインストールします..."

if command -v code &>/dev/null; then
  while IFS= read -r extension; do
    # 空行・コメント行をスキップ
    [[ -z "$extension" || "$extension" == \#* ]] && continue
    if code --install-extension "$extension" --force &>/dev/null; then
      info "インストール済み: $extension"
    else
      warn "インストール失敗: $extension"
    fi
  done < "$DOTFILES_DIR/vscode/extensions.txt"
else
  warn "'code' コマンドが見つかりません。VSCode 拡張機能のインストールをスキップします。"
  warn "VSCode の「コマンドパレット」から「Shell Command: Install 'code' command in PATH」を実行してください。"
fi

# ------------------------------
# macOS defaults（任意）
# ------------------------------
echo ""
read -rp "macOS のシステム設定を適用しますか？ (y/N): " apply_macos
if [[ "$apply_macos" =~ ^[Yy]$ ]]; then
  bash "$DOTFILES_DIR/macos/defaults.sh"
else
  info "macOS 設定をスキップしました。後から bash macos/defaults.sh で実行できます。"
fi

# ------------------------------
# 完了
# ------------------------------
echo ""
echo "========================================="
info "セットアップ完了！"
echo "========================================="
echo ""
echo "次のステップ:"
echo "  1. ターミナルを再起動して .zshrc を反映する"
echo "  2. 必要に応じて ~/.ssh/config にホスト設定を追加する"
echo "  3. macOS 設定を変更したい場合: bash macos/defaults.sh"
echo ""

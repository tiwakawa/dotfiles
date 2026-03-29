#!/bin/bash
# dotfiles セットアップスクリプト
# 実行: bash setup.sh

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname)"

# カラー出力
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

info()    { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
error()   { echo -e "${RED}[ERROR]${NC} $1"; }

# ------------------------------
# パッケージインストール
# ------------------------------
if [[ "$OS" == "Darwin" ]]; then
  # macOS: Homebrew
  if ! command -v brew &>/dev/null; then
    info "Homebrew をインストールします..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Apple Silicon の場合はパスを追加
    if [ -f /opt/homebrew/bin/brew ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  else
    info "Homebrew はインストール済みです。"
  fi

  echo ""
  info "Brewfile からパッケージをインストールします..."
  brew bundle --file="$DOTFILES_DIR/Brewfile"

else
  # Linux: apt + starship
  info "Linux 環境を検出しました。"

  # root かどうかで sudo を使うか判断
  if [[ "$(id -u)" == "0" ]]; then
    APT="apt-get"
  else
    APT="sudo apt-get"
  fi

  # zsh のインストール
  if ! command -v zsh &>/dev/null; then
    info "zsh をインストールします..."
    $APT update -qq && $APT install -y zsh
  else
    info "zsh はインストール済みです。"
  fi

  # starship のインストール
  if ! command -v starship &>/dev/null; then
    info "starship をインストールします..."
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
  else
    info "starship はインストール済みです。"
  fi
fi

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
link "$DOTFILES_DIR/claude/CLAUDE.md"         "$HOME/.claude/CLAUDE.md"

# SSH config のパーミッションを設定（セキュリティ要件）
chmod 700 "$HOME/.ssh"
chmod 600 "$HOME/.ssh/config"
info "SSH config のパーミッションを設定しました (700/600)"

# VSCode settings（OS によってパスが異なる）
if [[ "$OS" == "Darwin" ]]; then
  link "$DOTFILES_DIR/vscode/settings.json"     "$HOME/Library/Application Support/Code/User/settings.json"
  link "$DOTFILES_DIR/vscode/keybindings.json"  "$HOME/Library/Application Support/Code/User/keybindings.json"
else
  link "$DOTFILES_DIR/vscode/settings.json"     "$HOME/.config/Code/User/settings.json"
  link "$DOTFILES_DIR/vscode/keybindings.json"  "$HOME/.config/Code/User/keybindings.json"
fi

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
fi

# ------------------------------
# macOS defaults（macOS のみ・任意）
# ------------------------------
if [[ "$OS" == "Darwin" ]]; then
  echo ""
  if [ -t 0 ]; then
    read -rp "macOS のシステム設定を適用しますか？ (y/N): " apply_macos
  else
    apply_macos="N"
  fi
  if [[ "$apply_macos" =~ ^[Yy]$ ]]; then
    bash "$DOTFILES_DIR/macos/defaults.sh"
  else
    info "macOS 設定をスキップしました。後から bash macos/defaults.sh で実行できます。"
  fi
else
  info "Linux 環境のため macOS 設定をスキップします。"
fi

# ------------------------------
# 完了
# ------------------------------
echo ""
echo "========================================="
info "セットアップ完了！"
echo "========================================="
echo ""
if [[ "$OS" == "Darwin" ]]; then
  echo "次のステップ:"
  echo "  1. ターミナルを再起動して .zshrc を反映する"
  echo "  2. 必要に応じて ~/.ssh/config にホスト設定を追加する"
  echo "  3. macOS 設定を変更したい場合: bash macos/defaults.sh"
  echo "  4. パッケージを追加する場合は Brewfile を編集して brew bundle を実行する"
else
  echo "次のステップ:"
  echo "  1. zsh を起動して .zshrc を反映する（exec zsh）"
  echo "  2. 必要に応じて ~/.ssh/config にホスト設定を追加する"
fi
echo ""

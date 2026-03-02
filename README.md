# dotfiles

tiwakawa の macOS 環境設定ファイル一式。

## ディレクトリ構成

```
dotfiles/
├── setup.sh              # セットアップスクリプト（シンボリックリンク作成）
├── Brewfile              # Homebrew パッケージ定義
├── git/
│   └── .gitconfig        # Git 設定
├── macos/
│   └── defaults.sh       # macOS システム設定（defaults write）
├── ssh/
│   └── config            # SSH 設定（秘密鍵は含まない）
├── starship/
│   └── starship.toml     # Starship プロンプト設定
├── vscode/
│   ├── extensions.txt    # VSCode 拡張機能リスト
│   ├── keybindings.json  # VSCode キーバインド
│   └── settings.json     # VSCode 設定
└── zsh/
    └── .zshrc            # Zsh 設定
```

## セットアップ

```bash
git clone https://github.com/tiwakawa/dotfiles.git ~/workspace/projects/dotfiles
cd ~/workspace/projects/dotfiles
bash setup.sh
```

setup.sh が行うこと：

1. 各設定ファイルへのシンボリックリンクを作成（既存ファイルは `.bak.YYYYMMDDHHMMSS` にバックアップ）
2. `brew bundle` で Brewfile に定義したパッケージを一括インストール
3. VSCode 拡張機能を `extensions.txt` からインストール
4. macOS システム設定の適用（任意・確認あり）

## シンボリックリンク対応表

| dotfiles 内パス | リンク先 |
|---|---|
| `zsh/.zshrc` | `~/.zshrc` |
| `git/.gitconfig` | `~/.gitconfig` |
| `starship/starship.toml` | `~/.config/starship.toml` |
| `ssh/config` | `~/.ssh/config` |
| `vscode/settings.json` | `~/Library/Application Support/Code/User/settings.json` |
| `vscode/keybindings.json` | `~/Library/Application Support/Code/User/keybindings.json` |

## Brewfile

[Homebrew Bundle](https://github.com/Homebrew/homebrew-bundle) を使ってパッケージを一括管理。

| 種別 | パッケージ | 説明 |
|---|---|---|
| brew | `git` | バージョン管理 |
| brew | `starship` | シェルプロンプト |
| cask | `claude-code` | Claude Code CLI |
| cask | `docker-desktop` | Docker Desktop |
| cask | `iterm2` | ターミナル |
| cask | `visual-studio-code` | エディタ |
| vscode | `ms-vscode-remote.remote-containers` | Dev Containers |
| vscode | `vscodevim.vim` | Vim キーバインド |

単独で実行する場合：

```bash
brew bundle
```

Brewfile を現在の環境から生成・更新する場合：

```bash
brew bundle dump --force
```

## 注意事項

- `~/.ssh/` 配下の秘密鍵（`id_*`, `*.pem` 等）はこのリポジトリに含めない
- `ssh/config` には秘密鍵のパスを記載するが、鍵ファイル自体は別途管理する
- macOS 設定は `bash macos/defaults.sh` で単独実行も可能

## VSCode 拡張機能の更新

```bash
code --list-extensions > vscode/extensions.txt
```

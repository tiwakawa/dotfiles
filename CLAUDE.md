# dotfiles

macOS 環境設定一式。詳細は README.md を参照。

## 作業時の注意

- Brewfile を編集したら `brew bundle` を実行して反映する
- `claude/`, `git/`, `zsh/` などのファイルは `~/` 配下にシンボリックリンクされており、編集は即時反映される（対応表は README.md）
- `setup.sh` は既存ファイルをバックアップに退避する破壊的な動作のため、明示的な指示がない限り実行しない

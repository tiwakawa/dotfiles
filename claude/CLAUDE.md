# コミュニケーション
- 回答は日本語で行う
- 簡潔に要点を伝える（冗長な説明は不要）

# CLAUDE.md の改善
- 同一会話内で同じ指示・好みが繰り返された場合、会話の区切りで「CLAUDE.mdに追加しますか？」と提案する
- 新しいプロジェクトで作業する際、CLAUDE.mdがなければ作成を提案する

# 作業スタイル
- ファイルを変更する前に必ず読んで内容を把握してから提案・修正する
- 大きな変更や破壊的な操作の前はユーザーに確認を取る
- コミットは変更の単位（目的）ごとに分ける
- コミットメッセージは `type: 説明` の形式（例: `fix:`, `feat:`, `chore:`）

# 開発方針

## 環境構成
- パッケージ管理はBrewfileで一元管理（`brew install` は直接使わない）
- 全プロジェクトをDev Containerで管理する
- Dev ContainerにはdotfilesをBind Mountして適用する（zsh・starship等）
- Macをクリーンに保つ（anyenv・rbenv等はMacに直接入れない）
- Claude CodeはMac側のターミナル（iTerm2）から実行する（Dev Containerの中では使わない）

## Dev Container vs ローカルの判断
- 基本はDev Container
- 以下の場合はローカルで前進する
  - Docker禁止等の制約がある場合
  - 半日〜1日でコンテナ起動できない場合

## Dev Containerの設計方針
- zsh・starship・デフォルトシェル変更はDockerfileで行う
- コンテナ起動直後からdotfilesが反映されるよう `/etc/zsh/zshrc` でBind Mount経由でsource
- `.gitconfig` はシンボリックリンクではなくコピー（VSCodeのcredential helper汚染を防ぐため）
- `postCreateCommand` には依存インストール（bundle install・npm install等）のみ記載する

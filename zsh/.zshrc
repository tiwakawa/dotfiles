# ------------------------------
# General Settings
# ------------------------------
export EDITOR=vim        # デフォルトエディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定

setopt no_beep           # ビープ音を鳴らさない
setopt auto_cd           # ディレクトリ名だけでcdする
setopt auto_pushd        # cdの履歴をスタックに積む（cd -[Tab]で戻れる）
setopt correct           # コマンドのスペルミスを指摘する
setopt magic_equal_subst # = 以降も補完する（--prefix=/usr など）
setopt notify            # バックグラウンドジョブの完了を即時通知する

### Completion ###
autoload -U compinit; compinit                        # 補完機能を有効にする
setopt auto_list                                       # 補完候補を一覧表示する
setopt auto_menu                                       # Tabキー連打で補完候補を順に表示する
setopt list_packed                                     # 補完候補を詰めて表示する
setopt list_types                                      # 補完候補にファイル種別を表示する
bindkey "^[[Z" reverse-menu-complete                   # Shift+Tabで補完候補を逆順に辿る
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'   # 補完時に大文字小文字を区別しない

### History ###
HISTFILE=~/.zsh_history   # ヒストリの保存先
HISTSIZE=10000            # メモリ上のヒストリ件数
SAVEHIST=10000            # ファイルに保存するヒストリ件数
setopt extended_history   # ヒストリに実行時刻も記録する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt share_history      # 複数ターミナル間でヒストリを共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end  # Ctrl+Pで前方ヒストリ検索
bindkey "^N" history-beginning-search-forward-end   # Ctrl+Nで後方ヒストリ検索

# ------------------------------
# Look And Feel
# ------------------------------
### Ls Color ###
export LSCOLORS=Exfxcxdxbxegedabagacad  # lsコマンドの色設定（macOS用）
export CLICOLOR=true                     # lsコマンドに自動で色をつける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}  # 補完候補に色をつける

### Starship ###
eval "$(starship init zsh)"  # プロンプトをstarshipに委譲する

# ------------------------------
# SSH Agent
# ------------------------------
# キーチェーンからSSH鍵を自動読み込みする
ssh-add --apple-load-keychain 2>/dev/null

# ------------------------------
# Aliases
# ------------------------------
alias v=vim                                          # vimを短縮
alias gr='cd $(git rev-parse --show-toplevel)'       # gitリポジトリのルートに移動
alias gitlog='git log --oneline --graph --all | less -R'  # グラフ付きgitログを表示

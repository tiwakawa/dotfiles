" ------------------------------
" Bundle Settings
" ------------------------------
set nocompatible " viとの互換性OFF
filetype off     " ファイル形式の検出を無効にする

" Vundleを初期化
set rtp+=~/.vim/vundle.git/
call vundle#rc()

" from github repos
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'gmarik/vundle'
Bundle 'kchmck/vim-coffee-script'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/unite.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'vim-scripts/Railscasts-Theme-GUIand256color'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
Bundle 'vim-scripts/surround.vim'

" from vim-scripts repos
Bundle 'git-commit'

" from non github repos


" ------------------------------
" General Settings
" ------------------------------
filetype plugin on            " ファイルタイププラグインを有効にする
filetype indent on            " ファイル形式別インデントを有効にする
set expandtab                 " Tabをスペースに置き換える
set tabstop=2                 " Tabが対応する空白数
set shiftwidth=2              " 自動インデントの各段階における空白数
set autoindent                " 新しい行の開始時にインデントを現在と同じにする
set nobackup                  " バックアップを取らない
set wrap                      " 画面端で折り返す
set hidden                    " 変種中のファイルを保存しないで他ファイルを表示できるようにする
set history=100               " コマンド・検索パターンを履歴に残す
set nrformats=alpha,octal,hex " <C-A>,<C-X>で加減算を可能にする


" ------------------------------
" Look And Feel Settings
" ------------------------------
set number             " 行番号を表示
set ruler              " ルーラーを表示
set title              " タイトルを表示
set t_Co=256           " 色数指定(256)
syntax on              " 強調表示ON
colorscheme railscasts " カラースキーマを設定
set ambiwidth=double   " ☆などの記号を正しく表示する
set cmdheight=1        " コマンドラインに使われるスクリーン上の行数
set showcmd            " コマンドをステータスライン(右側)に表示
set wildmenu           " 補完候補を表示
set laststatus=2       " ステータスラインを表示(常にステータスラインを表示)
" ステータスの表示内容を設定
" 左側：カレントファイル (カレントディレクトリ)
" 右側：[修正フラグ][読み込み専用フラグ][ファイルタイプ][プレビューウィンドウフラグ]
"       [エンコーディング][ファイルフォーマット][カーソルの行数, カーソルの列数]
set statusline=%{expand('%:p:t')}\ %<\(%{expand('%:p:h')}\)%=\ %m%r%y%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}[%3l,%3c]


" ------------------------------
" Search Settings
" ------------------------------
set incsearch  " インクリメンタルサーチを行う
set hlsearch   " 検索結果をハイライトする
set ignorecase " 大文字・小文字を区別しない
set smartcase  " 大文字で検索した場合、大文字・小文字を区別して検索する


" ------------------------------
" Encoding Settings
" ------------------------------
set termencoding=utf-8 " 端末の出力に使用されるエンコーディング(グローバル)
set encoding=utf-8     " Vim内部で使用するエンコーディング(グローバル)
set fileencoding=utf-8 " ファイルのエンコーディング(バッファローカル)
set fileencodings=iso-2022-jp,euc-jp,cp932,utf-8 " Vimが表示できるエンコーディングリスト(グローバル)


" ------------------------------
" neocomplcache Settings
" ------------------------------
let g:neocomplcache_enable_at_startup = 1            " 起動時に有効にする
let g:neocomplcache_enable_smart_case = 1            " smartcaseを有効にする
let g:neocomplcache_enable_camel_case_completion = 1 " camel caseを有効にする
let g:neocomplcache_enable_underbar_completion = 1   " _区切りの補完を有効にする
let g:neocomplcache_min_syntax_length = 3            " シンタックスをキャッシュするときの最小文字長を3に設定する

" <C-K> にマッピング
" imap <C-K> <Plug>(neocomplcache_snippets_expand)
" smap <C-K> <Plug>(neocomplcache_snippets_expand)

" Tabキーでオムニ補完できるようにする
" 順方向に移動
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" 逆方向に移動
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"


" ------------------------------
" KeyBind Settings
" ------------------------------
" 括弧やクォート入力後に自動で左側に移動する
inoremap {} {}<Left>
inoremap [] []<Left>
inoremap () ()<Left>
inoremap "" ""<Left>
inoremap '' ''<Left>
inoremap <> <><Left>


" ------------------------------
" Ruby Settings
" ------------------------------
autocmd BufNewFile,BufRead *.erb set nowrap tabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.rb  set nowrap tabstop=2 shiftwidth=2

"Rubyのオムニ補完を設定(ft-ruby-omni)
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1


" ------------------------------
" PHP Settings
" ------------------------------
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType php set tabstop=4
autocmd FileType php set shiftwidth=4
autocmd FileType php set softtabstop=4


" ------------------------------
" Javascript Settings
" ------------------------------
autocmd FileType javascript set tabstop=2
autocmd FileType javascript set shiftwidth=2
autocmd FileType javascript set softtabstop=2


" ------------------------------
" HTML and CSS Settings
" ------------------------------
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css  set omnifunc=csscomplete#CompleteCSS



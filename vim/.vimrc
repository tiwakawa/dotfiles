" --------------------------------
" Defaults
" --------------------------------
" macOS system vim sets skip_defaults_vim=1, so load defaults.vim explicitly
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" --------------------------------
" Syntax / Filetype
" --------------------------------
syntax on
filetype plugin indent on

" --------------------------------
" Display
" --------------------------------
set number           " 行番号
set list             " 不可視文字を表示
set listchars=tab:>>,trail:-
set ambiwidth=double " ☆等の記号幅を正しく扱う（日本語環境）

" --------------------------------
" Indent
" --------------------------------
set expandtab        " Tab → 半角スペース
set tabstop=2
set shiftwidth=2

" --------------------------------
" Search
" --------------------------------
set ignorecase
set smartcase        " 大文字を含む検索は区別する

" --------------------------------
" Editing
" --------------------------------
set hidden           " 未保存バッファを背後に置ける

" --------------------------------
" Encoding
" --------------------------------
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932

" --------------------------------
" Keymaps
" --------------------------------
" ESC2回で検索ハイライト解除
nnoremap <Esc><Esc> :nohlsearch<CR>

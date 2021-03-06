" crontabのための設定
set backupskip=/tmp/*,/private/tmp/*
" backup ファイルを作成しない
set nobackup

set encoding=utf-8
scriptencoding utf-8
" 保存時の文字コード
set fileencoding=utf-8
" 読み込み時の文字コードの自動判別
set fileencodings=utf-8,euc-jp,cp932,ucs-boms
" 改行コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac
" □や○文字が崩れる問題を解決"
set ambiwidth=double

set number
set backspace=indent,eol,start
" クリップボードにコピーする
set clipboard=unnamed,autoselect

" タブ入力を複数の空白入力に置き換える
set expandtab
" 画面上でタブ文字が占める幅
set tabstop=4
" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=4
" 改行時に前の行のインデントを継続する
set autoindent
" 改行時に前の行の構文をチェックし次の行のインデントを増減する
set smartindent
" smartindentで増減する幅"
set shiftwidth=4

" インクリメンタルサーチ. １文字入力毎に検索を行う
set incsearch
" 検索パターンに大文字小文字を区別しない
set ignorecase
" 検索パターンに大文字を含んでいたら大文字小文字を区別する
set smartcase
" 検索結果をハイライト"
set hlsearch

" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-

" カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set whichwrap=b,s,h,l,<,>,[,],~

" カーソルラインをハイライト"
set cursorline

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" tagsジャンプの時に複数ある時は一覧表示
"nnoremap <C-]> g<C-]>
nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-k> :split<CR> :exe("tjump ".expand('<cword>'))<CR>

" 括弧の対応関係を一瞬表示する
set showmatch
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する "

" コマンドモードの補完
set wildmenu
" 保存するコマンド履歴の数  "
set history=5000


" Dein
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " plugins
  let g:rc_dir    = expand('~/.vim/settings')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " load settings
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif


set background=dark
"色を付ける
syntax on
"colorscheme molokai
let g:molokai_original = 1


"==============プラグイン関係の設定==============


let g:airline_theme = 'molokai'
"====================gitgutter====================
"変更箇所のハイライト
let g:gitgutter_highlight_lines = 0

"====================junegunn/vim-easy-align====================
"enterで整形設定に行くようにする
vmap <Enter> <Plug>(EasyAlign)

"====================neocomplcache====================
" ~Disable AutoComplPop. neocomplcashe~
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
"~neocomplecas~


" neosnippet
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" ~ファイルタイプ毎 & gitリポジトリ毎にtagsの読み込みpathを変える~
function! ReadTags(type)
    try
        execute "set tags=".$HOME."/dotfiles/tags_files/".
              \ system("cd " . expand('%:p:h') . "; basename `git rev-parse --show-toplevel` | tr -d '\n'").
              \ "/" . a:type . "_tags"
    catch
        execute "set tags=./tags/" . a:type . "_tags;"
    endtry
endfunction

augroup TagsAutoCmd
    autocmd!
    autocmd BufEnter * :call ReadTags(&filetype)
augroup END


" osyo-manga/vim-anzu
" mapping
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
" clear status
nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
" statusline
set statusline=%{anzu#search_status()}



" indentLine
let g:indentLine_char = '¦' "use ¦, ┆ or │
" haya14busa/vim-operator-flashy
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$


" EmmetHmtl
let g:user_emmet_leader_key='<C-t>'


" markdown
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

" previm
nnoremap <silent> <C-p> :PrevimOpen<CR> " Ctrl-pでプレビュー
" 自動で折りたたまないようにする
let g:vim_markdown_folding_disabled=1
let g:previm_enable_realtime = 1

" LaTeX
let g:Tex_AutoFolding = 0

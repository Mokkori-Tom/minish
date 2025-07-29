" === 基本文字コード設定 ===
set encoding=utf-8
scriptencoding utf-8

" === dein本体 + TOMLロード ===
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim ' . s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  let g:rc_dir = expand('~/.vim/rc')
  call dein#load_toml(g:rc_dir . '/dein.toml',      {'lazy': 0})
  call dein#load_toml(g:rc_dir . '/dein_lazy.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" === 基本エディタ設定 ===
filetype plugin indent on
syntax enable
colorscheme molokai
set t_Co=256

" --- 表示系 ---
set number
set relativenumber
set cursorline

" --- インデント/タブ ---
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set backspace=indent,eol,start

" --- 編集/検索 ---
set clipboard=unnamed
set showmatch
set wildmenu
set ignorecase
set smartcase
set incsearch
set hlsearch
set laststatus=2
set updatetime=300
set completeopt=menuone,noinsert,noselect

" == gf ==
set path+=**
" pathにネットワークパスを追加
" set path+=//server/share/**
" 定番：netrw（Vim内蔵リモートファイラ）
" e scp://user@host//path/to/file.txt
" Markdownリンクのgf強化
" au FileType markdown setlocal isfname+=@-@ " []()内でもgfでOK
" カーソル下URLをx-www-browserで開く
" nnoremap <leader>gu :!xdg-open <cfile><CR>
" ワイルドカードの除去（誤爆防止なら）
" set path-=/usr/include
" デフォルト拡張子も追加（gf, :findで有効）
" set suffixesadd+=.md,.txt,.py,.go

" === vimwiki 設定 ===
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': 'md'}]

" === Leader/ツール/FZF/LSP キー設定 ===
let mapleader = " "

" --- FZF/検索 ---
nnoremap <leader>f :Files<CR>
nnoremap <leader>r :Rg<CR>
let g:fzf_vim = {}
let g:fzf_vim.preview_window = []

" --- ツリー/ターミナル ---
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>t :terminal<CR>

" --- LSPジャンプ ---
nnoremap <leader>d :LspDefinition<CR>
nnoremap <leader>y :LspTypeDefinition<CR>
nnoremap <leader>i :LspImplementation<CR>
nnoremap <leader>R :LspReferences<CR>

" --- vimwiki Index ---
nnoremap <leader>w :VimwikiIndex<CR>

" === UltiSnips キーバインド ===
let g:UltiSnipsExpandTrigger       = "<C-j>"
let g:UltiSnipsJumpForwardTrigger  = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"

" === asyncomplete 補完統合 ===
let g:asyncomplete_auto_popup        = 1  " 入力中自動補完
let g:asyncomplete_auto_completeopt  = 1  " completeopt自動設定
let g:asyncomplete_buffer_enable     = 1  " バッファ補完
let g:asyncomplete_lsp_enable        = 1  " LSP補完
let g:asyncomplete_file_enable       = 1  " ファイル名補完
let g:asyncomplete_tags_enable       = 1  " tags補完

" --- 補完候補ウィンドウ操作（美バインド） ---
inoremap <expr> <Tab>     pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab>   pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>      pumvisible() ? asyncomplete#close_popup() : "\<CR>"
inoremap <expr> <C-n>     pumvisible() ? "\<C-n>" : "\<C-n>"
inoremap <expr> <C-p>     pumvisible() ? "\<C-p>" : "\<C-p>"
inoremap <C-Space>        <Plug>(asyncomplete_force_refresh)

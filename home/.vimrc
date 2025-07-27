"=== 基本文字コード設定 ===
set encoding=utf-8
scriptencoding utf-8

"=== dein本体 + TOMLロード ===
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

filetype plugin indent on

colorscheme molokai

syntax enable
set t_Co=256

set number
set cursorline
set expandtab
set tabstop=4
set shiftwidth=4
set number
set relativenumber
set cursorline
set clipboard=unnamed
set showmatch
set wildmenu
set ignorecase
set smartcase
set incsearch
set hlsearch
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set backspace=indent,eol,start
set laststatus=2
set updatetime=300
syntax enable
filetype plugin indent on

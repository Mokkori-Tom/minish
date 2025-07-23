" ========== プラグイン管理 ==========
call plug#begin(expand('~/.vim/plugged'))
Plug 'tpope/vim-fugitive'
Plug '907th/vim-auto-save'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vimwiki/vimwiki'
" LSPと補完
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'

call plug#end()

" ========== 基本設定 ==========
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

" ========== Leaderキー ==========
let mapleader = " "
nnoremap <leader>f :Files<CR>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>t :terminal<CR>

" ========== 文字コード設定 ==========
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp
set fileencoding=utf-8
if has('win32') || has('win64')
    set fileencodings=ucs-bom,utf-8,cp932
    set termencoding=utf-8
endif

" ========== vim-auto-save ==========
let g:auto_save = 1
let g:auto_save_events = ["InsertLeave", "TextChanged"]
let g:auto_save_silent = 1

" ========== fzf ==========
if executable('rg')
    set grepprg=rg\ --vimgrep\ --smart-case
    set grepformat=%f:%l:%c:%m
endif
let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'

" ========== asyncomplete 設定（ファイル補完の明示登録） ==========
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
            \ 'name': 'file',
            \ 'allowlist': ['*'],
            \ 'priority': 10,
            \ 'completor': function('asyncomplete#sources#file#completor')
            \ }))

let g:asyncomplete_auto_popup = 1
let g:asyncomplete_min_chars = 1

" ========== UltiSnips & Tabキーの補完候補選択マッピング ==========
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" ========== UltiSnipsのスニペットディレクトリ設定 ==========
let g:UltiSnipsSnippetDirectories=["UltiSnips"]

" ========== vim-lsp（LSP機能のショートカット） ==========
nnoremap <leader>d :LspDefinition<CR>
nnoremap <leader>y :LspTypeDefinition<CR>
nnoremap <leader>i :LspImplementation<CR>
nnoremap <leader>R :LspReferences<CR>

" ========== LSP: 保存時に自動フォーマット ==========
autocmd BufWritePre *.js,*.ts,*.py,*.go LspDocumentFormatSync

" ========== 保存時に全体整形＆行末空白削除 ==========
" autocmd BufWritePre * :silent! normal! gg=G=
autocmd BufWritePre * :%s/\s\+$//e

" ========== vim-lsp-settingsで自動LSPサーバ設定 ==========
let g:lsp_settings = {
            \ 'pylsp-all': {},
            \ 'gopls': {},
            \ 'tsserver': {},
            \ }

" ========== パス補完のキーバインド ==========
" <C-x><C-f>で明示的にファイルパス補完も可能

let g:vimwiki_list = [{'path': '~/mywiki/',
                      \ 'syntax': 'markdown', 'ext': 'md'}]

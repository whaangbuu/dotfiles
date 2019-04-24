" Load runtime path
set runtimepath^=~/.vim runtimepath+=~/.vim/after runtimepath+=/usr/local/opt/fzf
let &packpath = &runtimepath

" Neovim General settings
syntax on

if has("autocmd")
    filetype plugin indent on
    "           │     │    └──── Enable file type detection.
    "           │     └───────── Enable loading of indent file.
    "           └─────────────── Enable loading of plugin files.
endif

filetype on
" Make Vim more useful
set nocompatible

set tabstop=2                  " ┐
set softtabstop=2              " │ Set global <TAB> settings.
set shiftwidth=2							 " │
set expandtab                  " ┘
set smartindent
set autoindent

set visualbell                 " ┐
set noerrorbells               " │ Disable beeping and window flashing
set t_vb=                      " ┘ https://vim.wikia.com/wiki/Disable_beeping

set smartcase                  " Override `ignorecase` option
                               " if the search pattern contains
                               " uppercase characters.

set report=0                   " Report the number of lines changed.
set ruler                      " Show cursor position<Paste>

set nostartofline              " Kept the cursor on the same column.

set hlsearch                   " Enable search highlighting.
set ignorecase                 " Ignore case in search patterns.

set incsearch                  " Highlight search pattern
                               " as it is being typed.

set listchars=tab:»·             " ┐
set listchars+=trail:·           " │ Use custom symbols to
" set listchars+=eol:↴           " │ represent invisible characters.
" set listchars+=nbsp:_          " ┘

" disable showmode, since we are using lightline
set noshowmode

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" Enhance command-line completion
set wildmenu

" Allow cursor keys in insert mode
" set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start

" Optimize for fast terminal connections
set ttyfast

" Use <Space> to search
map <space> /

" Add the g flag to search/replace by default
set gdefault

" tabline enable
set hidden

" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" Set wildmode
set wildmode=list:longest,full

" Don’t add empty newlines at the end of files
set binary
set noeol

" Set line numbers
set number

set backupdir=~/.vim/backups   " Set directory for backup files.
set directory=~/.vim/swaps     " Set directory for .swp files.

" Prevent arrow keys on normal mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" move up/down consider wrapped lines
nnoremap j gj
nnoremap k gk

nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

" End General settings


" ---------------------------------------------------------

" Language specific settings

" Go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
let g:go_snippet_engine = "neosnippet"

" Ale
let g:ale_linters = {
\   'go': ['gofmt', 'golint', 'go vet'],
\}

let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" silver_searcher
let g:ackprg = 'ag --nogroup --nocolor --column'

" End language specific settings


" ----------------------------------------------------------------------
" | Helper Functions                                                   |
" ----------------------------------------------------------------------
function! StripTrailingWhitespaces()

    " Save last search and cursor position.

    let searchHistory = @/
    let cursorLine = line(".")
    let cursorColumn = col(".")

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    " Strip trailing whitespaces.

    %s/\s\+$//e

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    " Restore previous search history and cursor position.

    let @/ = searchHistory
    call cursor(cursorLine, cursorColumn)


endfunction

function! ToggleRelativeLineNumbers()

    if ( &relativenumber == 1 )
        set number
    else
        set relativenumber
    endif

endfunction

" End Helper Functions
" ----------------------------------------------------------------------

" Shortcuts/Map Leader
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" Change mapleader
let mapleader=","
" NERDTree
nmap <leader>t :NERDTreeToggle<cr>
" Clear highlight search
map <leader>c :nohlsearch<cr>
" Close current buffer
map <leader>w :bd<cr>
" [,* ] Search and replace the word under the cursor.
nmap <leader>* :%s/\<<C-r><C-w>\>//<Left>
" [,ss] Strip trailing whitespace.
nmap <leader>ss :call StripTrailingWhitespaces()<CR>
" [,cc] Toggle code comments.
" https://github.com/tomtom/tcomment_vim
map <leader>cc :TComment<CR>

" [,w] Close current buffer
map <leader>w :bdelete<CR>

"----------------------------------------------
" Splits
"----------------------------------------------
" Create horizontal splits below the current window
set splitbelow
set splitright

" Creating splits
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>h :split<cr>

" Closing splits
nnoremap <leader>q :close<cr>
" End Splits

" Make `Tab` autocomplete.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Prevent `Enter` to create new line when selecting from omni-completion
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"

" Keep a menu item always highlighted
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

"----------------------------------------------
" Plugin: 'junegunn/fzf.vim'
"----------------------------------------------
nnoremap <c-p> :FZF<cr>


" End Map leader



" Load `vim-plug`
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'connorholyday/vim-snazzy'

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tomtom/tcomment_vim'
Plug 'junegunn/vim-easy-align'
Plug 'editorconfig/editorconfig-vim'
Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale'
Plug 'maximbaz/lightline-ale'
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/syntastic'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'ap/vim-buftabline'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ggreer/the_silver_searcher'
Plug 'zivyangll/git-blame.vim'
" End installation of plugins

" Initialize plugin system
call plug#end()



" Status line for `lightline`
" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

let g:lightline = {}

let g:lightline.colorscheme = 'landscape'

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }

let g:lightline.active = { 'right': [[ 'fileformat', 'fileencoding', 'percent', 'filetype', 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]],
			\										 'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'filename', 'modified']]
			\	}

let g:lightline.component_function = {
      \     'gitbranch': 'fugitive#head',
      \ }
" End status line

" Enable deoplete on startup
let g:deoplete#enable_at_startup = 1

"----------------------------------------------
" Plugin: 'ctrlpvim/ctrlp.vim'
"----------------------------------------------
" Note: We are not using CtrlP much in this configuration. But vim-go depend on
" it to run GoDecls(Dir).

" Disable the CtrlP mapping, since we want to use FZF instead for <c-p>.
let g:ctrlp_map = ''

"----------------------------------------------
" Plugin: Ag
"----------------------------------------------
" Open Ag
nnoremap <leader>a :Ag<space>

" Mappings
au FileType go nmap <leader>gt :GoDeclsDir<cr>
au FileType go nmap <leader>gd <Plug>(go-def)
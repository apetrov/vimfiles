source ~/.vim/autoload/pathogen.vim
syntax on
filetype indent on
filetype plugin on
set t_Co=256  "necessary for TMUX
set grepprg=ack " faster grep, for :grep command

""Intent
"set smartindent
set autoindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set nowrap

set autowrite
set shell=/bin/bash "zsh cause multiple issues, it's easier to use bash
"set shell=/bin/zsh
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set pastetoggle=<F2>

" Avoid vim backup files
set wildignore=*.swp,*.bak,*.pyc,*.class
set nobackup
set noswapfile

" Avoid nag beeps
set visualbell
set noerrorbells

" Avoid 'Please press enter'
set shortmess=aAWTsI
set cmdheight=2

" share clipboard with OSX
set clipboard=unnamed

"Make things faster
set notimeout
set ttimeout
set ttimeoutlen=100

colorscheme zenburn
"colorscheme railscasts

execute pathogen#infect()

source ~/.vim/scripts/functions.vim
source ~/.vim/scripts/autocmd.vim
let g:ackprg = 'ag --nogroup --column'

" As I use only narrow screen displays screen realestate is very valuable
au WinEnter * :setlocal number
au WinLeave * :setlocal nonumber

source ~/.vim/scripts/mappings.vim
source ~/.vim/scripts/tmux.vim

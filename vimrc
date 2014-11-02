let g:closetag_html_style=1
source ~/.vim/autoload/pathogen.vim
syntax on
filetype indent on
filetype plugin on
set t_Co=256  "necessary for TMUX
set grepprg=ack " faster grep, for :grep command
let g:agprg='/usr/local/bin/ag --column'

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
set laststatus=2

" Avoid vim backup files
set wildignore=*.swp,*.bak,*.pyc,*.class
set nobackup
set noswapfile
set autoread

set history=1000

set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=vendor/gems/*,vendor/cache/*,.bundle/*,.sass-cache/*
set wildignore+=*.swp,*~,._*

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
source ~/.vim/scripts/status.vim
source ~/.vim/scripts/tmux.vim
set tags=.git/tags;

set splitbelow
set splitright
set winwidth=84

" set winheight=40
" set winminheight=5

nmap <Leader>h :noh<cr>


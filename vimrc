set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Bundle 'gmarik/vundle'
Bundle 'tmhedberg/matchit'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-endwise.git'
Bundle 'tpope/vim-abolish.git'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-commentary.git'
Bundle 'shinzui/vim-idleFingers'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'rking/ag.vim'
Bundle 'rizzatti/funcoo.vim'

" Textobj
Bundle 'jgdavey/vim-blockle'
Bundle 'kana/vim-textobj-user.git'
Bundle 'kana/vim-textobj-entire.git'
Bundle 'kana/vim-textobj-indent.git'
Bundle 'kana/vim-textobj-syntax.git'
Bundle 'kana/vim-textobj-line.git'
Bundle 'nelstrom/vim-textobj-rubyblock'

" Ruby
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake.git'
Bundle 'tpope/vim-bundler'
Bundle 'thoughtbot/vim-rspec'
Bundle 'Shougo/vimproc.vim'
Bundle 'alvan/vim-closetag'

"Clojure
Bundle 'tpope/vim-leiningen'
Bundle 'tpope/vim-projectionist'
Bundle 'tpope/vim-fireplace'
"Bundle 'larsyencken/vim-drake-syntax'
Bundle 'guns/vim-clojure-static'

call vundle#end()
filetype plugin indent on



let g:closetag_html_style=1
syntax on
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
command! Path :echo join(split(&path, ","), "\n")

let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](cookbook|log|DS_Store|\.bundle|\.git|target|public|tmp|vendor)'
\}

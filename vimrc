if filereadable(expand("~/.vim/vimrc.bundles"))
  source ~/.vim/vimrc.bundles
endif

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

" Avoid vim backup files
set nobackup
set noswapfile
set autoread

set history=1000
set showcmd
set visualbell
set noerrorbells

" Works for both OSX and linux
set clipboard=unnamed

"Make things faster
set notimeout
set ttimeout
set ttimeoutlen=100

set tags=.git/tags;
set splitbelow
set splitright
set winwidth=84

set t_Co=256  "necessary for TMUX

set wildignore=*.swp,*.bak,*.pyc,*.class
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=vendor/gems/*,vendor/cache/*,.bundle/*,.sass-cache/*,.git/*,cookbooks/*
set wildignore+=log/*,target/*,.DS_Store/*,bin/*
set wildignore+=*~,._*

let g:closetag_html_style=1
let g:html_indent_tags = 'li\|p'

if has("autocmd")
  autocmd BufRead,BufNewFile Gemfile set filetype=ruby
  autocmd BufRead,BufNewFile Gemfile.lock set filetype=ruby
  autocmd BufRead,BufNewFile Rakefile set filetype=ruby
  autocmd BufRead,BufNewFile Capfile, set filetype=ruby
  autocmd BufRead,BufNewFile config.ru, set filetype=ruby
  autocmd BufRead,BufNewFile config, set filetype=ruby
  autocmd BufRead,BufNewFile Guardfile, set filetype=ruby
	autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
  " not necessary
  autocmd BufRead,BufNewFile *.rb, set makeprg=ruby\ %
  " not sure how to make ruby and rspce at the same time. this solution breaks
  " ruby syntax and snippets but make rspec working
  " autocmd BufRead,BufNewFile *_spec.rb, set filetype=ruby-rspec

  " Trim ending whitespaces
  " autocmd FileWritePre    * StripWhitespace
  " autocmd FileAppendPre   * StripWhitespace
  " autocmd FilterWritePre  * StripWhitespace
  " autocmd BufWritePre     * StripWhitespace

  " As I use only narrow screen displays screen realestate is very valuable
  au WinEnter * :setlocal number
  au WinLeave * :setlocal nonumber

  au WinEnter * :set winfixheight
  au WinEnter * :wincmd =

  au FileType sql execute 'setlocal dict+=~/.vim/word/sql.txt'
end

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

if filereadable(expand("~/.vim/vimrc.status"))
  source ~/.vim/vimrc.status
endif

if filereadable(expand("~/.vim/vimrc.local"))
  source ~/.vim/vimrc.local
endif

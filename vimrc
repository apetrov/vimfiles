source ~/.vim/autoload/pathogen.vim
syntax on
filetype plugin on

set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set relativenumber
set nowrap
" switch between panes with Ctrl+h|j|k|l combo
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" indent like in Textmate
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

execute pathogen#infect()

colorscheme slate
set shell=/bin/zsh\ -i
set clipboard=unnamed

if has("autocmd")
  autocmd BufRead,BufNewFile Gemfile set filetype=ruby
  autocmd BufRead,BufNewFile Gemfile.lock set filetype=ruby
  autocmd BufRead,BufNewFile Rakefile set filetype=ruby
  autocmd BufRead,BufNewFile Capfile, set filetype=ruby
  autocmd BufRead,BufNewFile config.ru, set filetype=ruby
  autocmd BufRead,BufNewFile config, set filetype=ruby
  autocmd BufRead,BufNewFile Guardfile, set filetype=ruby
end

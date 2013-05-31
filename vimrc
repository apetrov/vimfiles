source ~/.vim/autoload/pathogen.vim
syntax on
filetype plugin on

set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
"set runtimepath^=~/.vim/bundle/rails.vim
"set runtimepath^=~/.vim/bundle/ctrlp.vim
"set runtimepath^=~/.vim/bundle/surround.vim
"set runtimepath^=~/.vim/bundle/ruby.vim
"set runtimepath^=~/.vim/bundle/gist.vim
"set runtimepath^=~/.vim/bundle/figitive.vim
"set runtimepath^=~/.vim/bundle/unimpaired.vim
"set runtimepath^=~/.vim/bundle/blockle.vim
"set runtimepath^=~/.vim/bundle/snipmate.vim
set nu
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

let g:gist_clip_command = 'pbcopy'
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


"if has("autocmd")
"  " Enable filetype detection
"  filetype plugin indent on
" 
"  " Restore cursor position
"  autocmd BufReadPost *
"    \ if line("'\"") > 1 && line("'\"") <= line("$") |
"    \   exe "normal! g`\"" |
"    \ endif
"endif
"if &t_Co > 2 || has("gui_running")
"  " Enable syntax highlighting
"  syntax on
"endif


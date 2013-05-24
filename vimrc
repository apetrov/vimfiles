syntax on
set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set runtimepath^=~/.vim/bundle/rails.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim
set runtimepath^=~/.vim/bundle/surround.vim
set runtimepath^=~/.vim/bundle/ruby.vim
set runtimepath^=~/.vim/bundle/gist.vim
set nu
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
let g:gist_clip_command = 'pbcopy'
colorscheme slate
set shell=/bin/zsh\ -i
set clipboard=unnamedplus

if has("autocmd")
  autocmd BufRead,BufNewFile Gemfile set filetype=ruby
  autocmd BufRead,BufNewFile Gemfile.lock set filetype=ruby
  autocmd BufRead,BufNewFile Rakefile set filetype=ruby
  autocmd BufRead,BufNewFile Capfile, set filetype=ruby
  autocmd BufRead,BufNewFile config.ru, set filetype=ruby
  autocmd BufRead,BufNewFile config, set filetype=ruby
  autocmd BufRead,BufNewFile Guardfile, set filetype=ruby
end

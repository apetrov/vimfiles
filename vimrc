source ~/.vim/autoload/pathogen.vim
syntax on
filetype plugin on
set ttimeout
set ttimeoutlen=250
set notimeout

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
colorscheme railscasts
set shell=/bin/zsh\ -i
set clipboard=unnamed
set visualbell
set noerrorbells 
set cmdheight=2
set shortmess=aAWTsI
execute pathogen#infect()

if has("autocmd")
  autocmd BufRead,BufNewFile Gemfile set filetype=ruby
  autocmd BufRead,BufNewFile Gemfile.lock set filetype=ruby
  autocmd BufRead,BufNewFile Rakefile set filetype=ruby
  autocmd BufRead,BufNewFile Capfile, set filetype=ruby
  autocmd BufRead,BufNewFile config.ru, set filetype=ruby
  autocmd BufRead,BufNewFile config, set filetype=ruby
  autocmd BufRead,BufNewFile Guardfile, set filetype=ruby
end

function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>
nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>
vnoremap . :norm.<CR>
set pastetoggle=<F2>
nnoremap j gj
nnoremap k gk


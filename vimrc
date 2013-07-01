source ~/.vim/autoload/pathogen.vim
syntax on
filetype plugin on

set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set nu
set autowrite
set nowrap
set shell=/bin/bash
set clipboard=unnamed
set visualbell
set noerrorbells 
set cmdheight=2
set shortmess=aAWTsI
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set wildignore=*.swp,*.bak,*.pyc,*.class
set nobackup
set noswapfile
set pastetoggle=<F2>


set notimeout
set ttimeout
set ttimeoutlen=100

colorscheme railscasts
"set shell=/bin/zsh\ -i

execute pathogen#infect()

if has("autocmd")
  autocmd BufRead,BufNewFile Gemfile set filetype=ruby
  autocmd BufRead,BufNewFile Gemfile.lock set filetype=ruby
  autocmd BufRead,BufNewFile Rakefile set filetype=ruby
  autocmd BufRead,BufNewFile Capfile, set filetype=ruby
  autocmd BufRead,BufNewFile config.ru, set filetype=ruby
  autocmd BufRead,BufNewFile config, set filetype=ruby
  autocmd BufRead,BufNewFile Guardfile, set filetype=ruby
  " not sure how to make ruby and rspce at the same time. this solution breaks
  " ruby syntax and snippets but make rspec working
  "autocmd BufRead,BufNewFile *_spec.rb, set filetype=ruby-rspec
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
nnoremap j gj
nnoremap k gk
nnoremap gO ^O  

" switch between panes with Ctrl+h|j|k|l combo
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map gk :bp!<cr>
map gl :bn!<cr>
inoremap <Up>      <NOP>
inoremap <Down>    <NOP>
inoremap <Left>    <NOP>
inoremap <Right>   <NOP>
noremap <Up>       <NOP>
noremap <Down>     <NOP>
noremap <Left>     <NOP>
noremap <Right>    <NOP>
nnoremap } }zz
nnoremap { {zz
nnoremap Q <nop>
nnoremap Y y$


call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>r :<C-u>Unite -start-insert file_rec/async:!<CR>
nnoremap <leader>m :<C-u>Unite -start-insert file_mru<CR>
nnoremap <silent> <leader>f :<C-u>Unite buffer file_mru bookmark<CR>

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

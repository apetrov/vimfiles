source ~/.vim/autoload/pathogen.vim
syntax on
filetype plugin on
set t_Co=256

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
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

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
  " autocmd BufRead,BufNewFile *_spec.rb, set filetype=ruby-rspec
  autocmd FileWritePre    * :call TrimWhiteSpace()
  autocmd FileAppendPre   * :call TrimWhiteSpace()
  autocmd FilterWritePre  * :call TrimWhiteSpace()
  autocmd BufWritePre     * :call TrimWhiteSpace()
end

function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>
" Transpose words
nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>

" Use dot command in visual mode
vnoremap . :norm.<CR>

" jump up and start text
nnoremap gO ^O

" switch between panes with Ctrl+h|j|k|l combo
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Hardmode
inoremap <Up>      <NOP>
inoremap <Down>    <NOP>
inoremap <Left>    <NOP>
inoremap <Right>   <NOP>

" [a and ]a to move between arguments
nmap ]a :next!<CR>
nmap [a :Next!<CR>
" quickfix list helpers
nmap <left> :cprev!<CR>
nmap <right> :cnext!<CR>
nmap <up> :cpfile!<CR>
nmap <down> :cnfile!<CR>
nmap [q :cprev!<CR>
nmap ]q :cnext!<CR>
nmap [Q :cfirst!<CR>
nmap ]Q :clast!<CR>
nmap Q <Nop>


" Smooth scrolling. keep cursor in center
nnoremap j gj
nnoremap k gk
"map } ]m
"map { [m
map Y y$

" Iterate buffers
map gk :bp!<cr>
map gl :bn!<cr>
let g:ackprg = 'ag --nogroup --column'
" Unite
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>R :<C-u>Unite file<CR>
nnoremap <C-p> :<C-u>Unite -start-insert file_rec/async<CR>
nnoremap <silent> <leader>m :<C-u>Unite -start-insert file_mru<CR>
nnoremap <silent> <leader>f :<C-u>Unite buffer file_mru bookmark<CR>

" RSpec
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
nmap <silent> <leader>d <Plug>DashSearch

map <D-S-]> gt
map <D-S-[> gT
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>

" Column scroll-binding on <leader>sb
noremap <silent> <leader>sb :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

au WinEnter * :setlocal number
au WinLeave * :setlocal nonumber

" Automatically resize vertical splits.
au WinEnter * :set winfixheight
au WinEnter * :wincmd =
set mouse=a
if exists('$TMUX')
  set ttymouse=xterm2
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif


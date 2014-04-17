nnoremap <C-n> :call NumberToggle()<cr>
" Transpose words

" Use dot command in visual mode
vnoremap . :norm.<CR>

" switch between panes with Ctrl+h|j|k|l combo
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <C-_> <C-w>_

" [a and ]a to move between arguments
nmap ]a :next!<CR>
nmap [a :Next!<CR>
nmap <left> :bp!<CR>
nmap <right> :bn!<CR>
" quickfix list helpers

nmap <up> :cpfile!<CR>
nmap <down> :cnfile!<CR>

nnoremap <C-]> <C-]>zz
nnoremap ]m ]mzz

" Smooth scrolling. keep cursor in center
nnoremap j gj
nnoremap k gk
map Y y$
" Evaluate current line
nnoremap Q A=<ESC>0yt=A<C-r>=<C-r>"<CR><ESC>

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
map <Leader>f :A<CR>
map <Leader>w :w<CR>
map <Leader>F :AV<CR>
map <leader>r :!ruby %<cr>
map <leader>W :Gwrite<CR>:Gcommit<CR>i
map <leader>q :wq<CR>
map <leader>p :Git pull<CR>
map <leader>P :Git push<CR>

iab itb helloworld

" Column scroll-binding on <leader>sb
noremap <silent> <leader>sb :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

" comment uncomment
if !has("gui")
  " set custom cursor -- vertical bar in insert mode (iTerm2)
  " from http://www.iterm2.com/#/section/documentation/escape_codes
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

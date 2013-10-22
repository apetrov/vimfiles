
nnoremap <C-n> :call NumberToggle()<cr>
" Transpose words
nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>

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
nmap [q :cprev!<CR>
nmap ]q :cnext!<CR>
nmap [Q :cfirst!<CR>
nmap ]Q :clast!<CR>
nmap Q <Nop>

nnoremap <C-]> <C-]>zz
nnoremap ]m ]mzz

" Smooth scrolling. keep cursor in center
nnoremap j gj
nnoremap k gk
map Y y$

" RSpec, doesn't work as of today.
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
nmap <silent> <leader>d <Plug>DashSearch
map <leader>r :!ruby %<cr>

" Column scroll-binding on <leader>sb
noremap <silent> <leader>sb :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

" comment uncomment
noremap   <buffer> K      :s,^\(\s*\)[^# \t]\@=,\1#,e<CR>:nohls<CR>zvj
noremap   <buffer> <C-K>  :s,^\(\s*\)#\s\@!,\1,e<CR>:nohls<CR>zvj
if !has("gui")
  " set custom cursor -- vertical bar in insert mode (iTerm2)
  " from http://www.iterm2.com/#/section/documentation/escape_codes
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Load sequence
"
" vimrc
" vimrc.bundles
"   vimrc.bundles.local
" vimrc.status
" vimrc.local

if &compatible
  set nocompatible
end
filetype off

" fzf
set rtp+=~/.fzf

if filereadable(expand("~/.vim/vimrc.bundles"))
  source ~/.vim/vimrc.bundles
endif

filetype plugin indent on
syntax on

if filereadable(expand("~/.vim/vimrc.status"))
  source ~/.vim/vimrc.status
endif

if filereadable(expand("~/.vim/vimrc.local"))
  source ~/.vim/vimrc.local
endif

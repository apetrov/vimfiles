if &compatible
  set nocompatible
end
filetype off

" fzf
set rtp+=~/.fzf

function! SourceIfExists(file)
  if filereadable(expand(a:file))
    execute 'source' expand(a:file)
  endif
endfunction

" implicit call SourceIfExists('~/.vim/vimrc.bundles.local')
call SourceIfExists('~/.vim/vimrc.status')
call SourceIfExists('~/.vim/vimrc.local')

filetype plugin indent on
syntax on


function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc




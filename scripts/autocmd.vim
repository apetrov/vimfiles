function! SetRspecCommand()
  if filereadable(getcwd(). "/Gemfile")
    "let g:rspec_command = "!echo bundle exec rspec {spec} && bundle exec rspec {spec}"
    let g:rspec_command = 'call Send_to_Tmux("bundle exec rspec {spec}\n")'
  else
    "let g:rspec_command = "!echo bundle exec rspec {spec} && bundle exec rspec {spec}"
    let g:rspec_command = 'call Send_to_Tmux("rspec {pec}n")rspec spec/models/account_spec.rb:24

  endif
endfunction

if has("autocmd")
  autocmd BufRead,BufNewFile Gemfile set filetype=ruby
  autocmd BufRead,BufNewFile Gemfile.lock set filetype=ruby
  autocmd BufRead,BufNewFile Rakefile set filetype=ruby
  autocmd BufRead,BufNewFile Capfile, set filetype=ruby
  autocmd BufRead,BufNewFile config.ru, set filetype=ruby
  autocmd BufRead,BufNewFile config, set filetype=ruby
  autocmd BufRead,BufNewFile Guardfile, set filetype=ruby
  autocmd FileType ruby :call SetRspecCommand()
  " not necessary
  " autocmd BufRead,BufNewFile *.rb, set makeprg=ruby\ %
  " not sure how to make ruby and rspce at the same time. this solution breaks
  " ruby syntax and snippets but make rspec working
  " autocmd BufRead,BufNewFile *_spec.rb, set filetype=ruby-rspec


  " Trim ending whitespaces
  autocmd FileWritePre    * :call TrimWhiteSpace()
  autocmd FileAppendPre   * :call TrimWhiteSpace()
  autocmd FilterWritePre  * :call TrimWhiteSpace()
  autocmd BufWritePre     * :call TrimWhiteSpace()

  autocmd FileType clojure map <leader>e :Eval<CR>

  au FileType sql execute 'setlocal dict+=~/.vim/word/sql.txt'
end




Alexander's VIM configuration
=============================

## Instalation

Prerequisites: ruby, rake, git

1. Move your existing configuration somewhere else:  
   `mv ~/.vim* ~/.gvim* my_backup`

2. Clone this repo locally:
   `git clone https://github.com/apetrov/vimfiles`

3. Go into local repo and run "rake"
   `cd ~/projects/vimfiles && rake`

4. It will install .vimrc & .vim symlinks that point to files inside local directory 

5. Keep updated: `git submodule foreach git pull origin master`

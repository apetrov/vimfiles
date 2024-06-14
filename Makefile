.DEFAULT_GOAL := all

VIM_PATH=$(shell pwd)
PLUG_URL=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
BUNDLE_FILE=$(HOME)/.vim/vimrc.bundles


all: clean link plug/get plug/install
	echo "done"
.PHONY: all

clean: plug/rm
	rm -rf ~/.vim
.PHONY: clean

link:
	ln -s $(VIM_PATH) ~/.vim
.PHONY: link

plug/get:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs $(PLUG_URL)
.PHONY: PLUG_URL

plug/rm:
	rm -rf ~/.vim/autoload/plug.vim plugged || true
.PHONY: plug/rm

plug/install:
	vim -E -s -u "$(BUNDLE_FILE)" +PlugInstall +qall
.PHONY: plug/install


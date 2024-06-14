.DEFAULT_GOAL := all

clean: plug/rm
	rm -rf ~/.vim
PHONY: clean

submodules:
	git submodule update --init --recursive

bundles:
	vim -E -s -u "$(HOME)/.vim/vimrc.bundles" +BundleInstall +qall

link:
	ln -s $$(pwd) ~/.vim

PLUG_URL=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
plug/get:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs $(PLUG_URL)
.PHONY: PLUG_URL


plug/rm:
	rm -rf ~/.vim/autoload/plug.vim || true
PHONY: plug/rm


plug/install:
	vim -E -s -u "$(HOME)/.vim/vimrc.bundles" +PlugInstall +qall



all: submodules clean link bundles  
	echo "done"

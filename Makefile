clean:
				rm -rf ~/.vim

submodules:
				git submodule update --init --recursive

bundles:
				vim -E -s -u "$(HOME)/.vim/vimrc.bundles" +BundleInstall +qall

install: submodules bundles clean
				ln -s $$(pwd) ~/.vim

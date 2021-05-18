clean:
	rm -rf ~/.vim

submodules:
	git submodule update --init --recursive

bundles:
	vim -E -s -u "$(HOME)/.vim/vimrc.bundles" +BundleInstall +qall

link:
	ln -s $$(pwd) ~/.vim

all: submodules clean link bundles  
	echo "done"

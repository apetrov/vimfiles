.DEFAULT_GOAL := all/vim

VIMFILES_PATH=$(shell pwd)
VIM_PATH=$(HOME)/.vim
NVIM_PATH=$(HOME)/.config/nvim
PLUG_URL=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
BUNDLE_FILE=$(VIM_PATH)/vimrc.bundles

# vim specific
VIM?=vim

ifeq ($(VIM),vim)
				AUTOLOAD_PATH=$(VIMFILES_PATH)/autoload
				PLUG_PATH=$(VIMFILES_PATH)/plugged
else
				AUTOLOAD_PATH=$(HOME)/.local/share/nvim/site/autoload
				PLUG_PATH=$(HOME)/.local/share/nvim/plugged
endif

PLUG=$(AUTOLOAD_PATH)/plug.vim

all: clean link plug/get plug/install
	echo "done"
.PHONY: all

all/vim: all
	echo done

all/nvim:
	#mkdir -p $(PACKER_PATH)
	VIM=nvim make all || true
	mkdir -p $(NVIM_PATH)
	ln -s $(VIM_PATH)/init.lua $(NVIM_PATH)/init.lua

PACKER_PATH=$(HOME)/.local/share/nvim/site/pack/packer/start/packer.nvim

clean:
	rm -rf $(PLUG) $(PLUG_PATH) $(AUTOLOAD_PATH) $(NVIM_PATH)/init.lua  $(PACKER_PATH) || true
.PHONY: clean

link:
	@if [ ! -L $(VIM_PATH) ]; then \
		ln -s $(VIMFILES_PATH) $(VIM_PATH) ; \
	fi
.PHONY: link

plug/get:
	curl -fLo $(PLUG) --create-dirs $(PLUG_URL)

plug/install:
	$(VIM) -E -s -u "$(BUNDLE_FILE)" +PlugInstall +qall

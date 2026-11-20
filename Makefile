.DEFAULT_GOAL := all

NVIM_PATH := $(if $(XDG_CONFIG_HOME),$(XDG_CONFIG_HOME),$(HOME)/.config)/$(or $(NVIM_APPNAME),nvim)

.PHONY: all all/nvim
all all/nvim:
	mkdir -p "$(NVIM_PATH)"
	@for entry in init.lua lua; do \
		target="$(NVIM_PATH)/$$entry"; \
		if [ -L "$$target" ] && [ "$$target" -ef "$(CURDIR)/$$entry" ]; then \
			continue; \
		fi; \
		if [ -e "$$target" ] || [ -L "$$target" ]; then \
			echo "Existing Neovim config path: $$target" >&2; \
			exit 1; \
		fi; \
	done
	@for entry in init.lua lua; do \
		source="$(CURDIR)/$$entry"; \
		target="$(NVIM_PATH)/$$entry"; \
		if [ -L "$$target" ] && [ "$$target" -ef "$$source" ]; then \
			if [ "$$(readlink "$$target")" != "$$source" ]; then \
				ln -sfn "$$source" "$$target" || exit 1; \
			fi; \
		else \
			ln -s "$$source" "$(NVIM_PATH)/" || exit 1; \
		fi; \
	done

PYTHON=python3.11
jupyter:
	$(PYTHON) -m venv .env
	. .env/bin/activate && pip install jupyter jupynium

JUPYNIUM_PORT=18898
jupynium/server:
		jupynium --nvim_listen_addr localhost:$(JUPYNIUM_PORT) 

jupynium/nvim:
		nvim --listen localhost:$(JUPYNIUM_PORT)   notebook.ju.py +JupyniumStartSync
		# JupyniumStartSync

Alexander's VIM configuration
=============================

### Install

```
git clone https://github.com/apetrov/vimfiles
cd  vimfiles && make all
```
### Loading order

* init.lua (in neovim, not in use otherwise)
*  vimrc
*  vimrc.bundles
*  vimrc.bundles.local
*  vimrc.status
*  vimrc.local

### Copilot (Neovim)

Copilot stays unloaded in each Neovim instance until you run `:CopilotStart`.
Loading the plugin alone does not start its server.

* `:CopilotStart` — start Copilot in this instance; suggestions appear as you type.
* `:Copilot auth` — sign in on first use, after starting Copilot.
* `:Copilot disable` — stop Copilot in this instance.
* In insert mode, `Ctrl-j` accepts a suggestion, `Alt-]` / `Alt-[` cycle suggestions,
  and `Ctrl-]` dismisses one.

Activation is not saved: new Neovim instances always start with Copilot unloaded.

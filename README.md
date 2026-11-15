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

### CodeCompanion with Codex (Neovim)

Requires Neovim 0.12+, Node.js/npm (`npx`), and a ChatGPT account with Codex access.
Lazy installs CodeCompanion on the next Neovim startup.

* `:CodeCompanionChat` — open a chat using Codex.
* `Space a c` — toggle the chat (also works with a visual selection).

The Codex ACP adapter runs through `npx --yes @agentclientprotocol/codex-acp`;
the first chat downloads it and may ask you to sign in with ChatGPT.
Codex is configured for chat; inline prompts require a separate HTTP adapter.

### Copilot (Neovim)

Copilot stays unloaded in each Neovim instance until you run `:CopilotStart`.
Loading the plugin alone does not start its server.

* `:CopilotStart` — start Copilot in this instance; suggestions appear as you type.
* `:Copilot auth` — sign in on first use, after starting Copilot.
* `:Copilot disable` — stop Copilot in this instance.
* In insert mode, `Ctrl-j` accepts a suggestion, `Alt-]` / `Alt-[` cycle suggestions,
  and `Ctrl-]` dismisses one.

Activation is not saved: new Neovim instances always start with Copilot unloaded.

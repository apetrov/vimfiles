Alexander's Neovim configuration
=============================

### Install

```
git clone https://github.com/apetrov/vimfiles
cd  vimfiles && make all
```
The installer links `init.lua` and `lua/` into your Neovim config directory
(`~/.config/nvim` by default). Open `nvim` to let Lazy install the plugins.
Space is the leader key. Editor settings and mappings live in
`lua/config/editor.lua`, and the statusline lives in `lua/config/statusline.lua`.

`:GChanges` opens the files reported by your `git files` alias in quickfix.

### Search with ripgrep

Requires `rg` on your PATH (`brew install ripgrep` on macOS).

* `:grep pattern` — search the current directory into quickfix.
* `:grep "multiple words" path/` — search a specific directory.
* `:copen` / `:cclose` — open / close quickfix.
* `]q` / `[q` — jump to the next / previous result.

Searches respect ignore files and use smart case: lowercase patterns ignore case;
patterns containing uppercase letters match case.

### Tree-sitter (Neovim)

Python, Ruby, and Go use Tree-sitter syntax highlighting. Requires Neovim 0.12+,
a C compiler, and Tree-sitter CLI 0.26.1+ (`brew install tree-sitter-cli` on macOS).
Lazy installs the plugin and all three parsers on startup. After the first parser
installation completes, reopen the file to enable highlighting.

* `:TSUpdate` — update installed parsers (also runs when the plugin updates).
* `:Inspect` — show the highlight groups under the cursor.
* `:InspectTree` — view the syntax tree for the current file.

Tree-sitter text objects work in Python, Ruby, and Go, in visual mode and with
operators such as `d`, `c`, and `y`:

| Text objects | Around (`a`) / inside (`i`) |
| --- | --- |
| `af` / `if` | Function or method / its body |
| `ac` / `ic` | Class / its body |
| `aa` / `ia` | Argument or parameter with separator / without separator |

In Go, `ac` / `ic` target structs and interfaces.

For example, `vaf` selects a method, `cif` changes its body, and `daa` deletes
an argument. Functions and classes use linewise selection. These buffer-local
mappings take precedence over the older Python text objects. Ruby's `ar` / `ir`
block text objects remain available.

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

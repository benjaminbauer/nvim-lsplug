A minimal LSP server manager for [Neovim](https://neovim.io), inspired by [vim-plug](https://github.com/junegunn/vim-plug), humbly standing on the shoulders of [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer/)
## Motivation
I strive to be able to setup a new machine purely by scripts and config. To that end, I manage all of my configurations in git. The awesome [vim-plug](https://github.com/junegunn/vim-plug) does that job for my nvim plugins. And while [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer/) does save me the headache of manually installing and updating LSP servers, it does not allow me out of the box to manage the LSP serves I want installed as convenient as vim-plug for plugins.
# Requirements
1. a working installation of [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer/)
2. all the requirments of [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer/)
# Installation
## [vim-plug](https://github.com/junegunn/vim-plug)
```vim
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'benjaminbauer/nvim-lsplug'
```
# Usage
## Configuration
```lua
-- somewhere in your init.lua or in a lua block in your init.vim
local lsplug = require("nvim-lsplug")

-- valid servers: https://github.com/williamboman/nvim-lsp-installer/#available-lsps
lsplug.add("sumneko_lua")
lsplug.add("vimls")
lsplug.add(..)
```
## Commands
| Command                             | Description                                                        |
| ----------------------------------- | ------------------------------------------------------------------ |
| `Lspluginstall` | Install all configured LSP servers                                                    |
| `Lsplugclean`  | Uninstall all manually installed LSP servers                                          |
# Status
This is a scratch-your-own-itch plugin and a working alpha at best. It is literally the first time I am writing _anything_ in [Lua](https://www.lua.org) and also my first try of writing a vim plugin. I do not know if I will maintain this. If you are reading this, see the merit of this plugin and are more proficient in Lua, please feel free to reach out.

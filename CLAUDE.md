# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles repository containing configurations for Neovim, Zsh, and Tmux. Designed for development in C/C++, Python, JavaScript/TypeScript, and Go.

## Sync Commands

```bash
# Sync all configurations to home directory
./sync-all.sh

# Sync individual configs
./nvim/sync.sh    # rsync to ~/.config/nvim/ (destructive, uses --delete)
./zsh/sync.sh     # cp to ~/.zshrc
./tmux/sync.sh    # cp to ~/.tmux.conf
```

Note: Zsh changes require terminal restart or `source ~/.zshrc`.

**After making Neovim config changes**, always sync and clear caches:
```bash
./nvim/sync.sh
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```

## Neovim Architecture

**Entry point:** `nvim/init.lua` loads modules in order:
1. `core.options` → `core.keymaps` → `core.autocmds`
2. `plugins` (lazy.nvim bootstrap + plugin specs)
3. `lsp` → `lsp.servers`

**Plugin organization (`lua/plugins/`):**
- Each file returns a lazy.nvim plugin spec (table or list of tables)
- `plugins/init.lua` imports all other plugin files via `{ import = "plugins.xxx" }`

**LSP setup (`lua/lsp/`):**
- `init.lua`: Capabilities, on_attach keymaps, diagnostic config
- `servers.lua`: Individual server configs (clangd, pyright, ts_ls, gopls) using `vim.lsp.config`

**Configured LSP servers:**
- `clangd` - C/C++ (with clang-tidy, background indexing)
- `pyright` - Python
- `ts_ls` - JavaScript/TypeScript
- `gopls` - Go

**Key bindings (Space as leader):**
- `<leader>ff/fg/fb` - Telescope find files/grep/buffers
- `<leader>e` - Toggle nvim-tree
- `gd/gr/gi` - Go to definition/references/implementation
- `<leader>rn/ca` - Rename/code action
- `F5/F10/F11/F12` - DAP debugging

## Zsh Configuration

- Oh My Zsh with agnoster theme
- Auto-launches tmux (attaches to "main" session)
- Uses: nvm, bun, uv (Python), fzf, fd, lsd
- `fdd` function: fuzzy directory navigation with fzf+fd

## Dependencies

Neovim 0.9+, Zsh, Tmux, ripgrep, fd, fzf, lsd, Node.js (via nvm), language-specific tools (Go, Python, etc.)

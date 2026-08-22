# CLAUDE.md

This file provides guidance to AI assistants working with code in this repository.

## Repository Overview

Personal dotfiles repository containing modern, IDE-grade configurations for Neovim, Zsh, and Tmux. Designed for full-stack and systems development in Python, JavaScript/TypeScript, Go, Rust, C, and C++.

## Sync Commands

```bash
# Sync all configurations to home directory
./sync-all.sh

# Sync individual configs
./nvim/sync.sh    # rsync to ~/.config/nvim/ (destructive, uses --delete)
./zsh/sync.sh     # cp to ~/.zshrc
./tmux/sync.sh    # cp to ~/.tmux.conf
```

**After making Neovim config changes**, sync and clear caches if needed:
```bash
./nvim/sync.sh
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
```

## Neovim Architecture

**Entry point:** `nvim/init.lua` sets up:
1. Environment PATH (macOS Homebrew, Cargo, Go, NVM/Node)
2. Leader key (`vim.g.mapleader = " "`)
3. Core settings: `core.options` → `core.keymaps` → `core.autocmds`
4. Lazy plugin manager: `plugins.init`

**Plugin organization (`lua/plugins/`):**
- `colorscheme.lua`: Kanagawa Dragon & Catppuccin
- `ui.lua`: Lualine, nvim-web-devicons, bufferline, which-key v3, indent-blankline, nvim-tree
- `navigation.lua`: Telescope (fzf-native), Harpoon 2, Flash.nvim
- `treesitter.lua`: Parsers for all supported languages, textobjects, autotags
- `lsp.lua`: Mason, Mason-lspconfig, Mason-tool-installer, nvim-lspconfig, conform.nvim, nvim-lint
- `completion.lua`: nvim-cmp, luasnip, friendly-snippets, lspkind, autopairs
- `debugging.lua`: nvim-dap, nvim-dap-ui, nvim-dap-virtual-text, mason-nvim-dap, launch.json reader
- `tasks.lua`: overseer.nvim task runner with `.vscode/tasks.json` support
- `git.lua`: Neogit (Magit clone), diffview.nvim, gitsigns.nvim
- `terminal.lua`: toggleterm.nvim (float, splits, code runner) + vim-tmux-navigator
- `testing.lua`: neotest with python, golang, rust, and jest/vitest adapters
- `editing.lua`: nvim-surround, Comment.nvim, todo-comments, trouble.nvim v3, aerial.nvim

## Core Keybindings Overview

- `<leader>ff/fg/fb/fr`: Telescope find files/grep/buffers/recent
- `<leader>a` / `<leader>h` / `<leader>1..4`: Harpoon 2 pin & jump
- `gd` / `gr` / `gi` / `gy` / `K`: LSP navigation & hover docs
- `<leader>cr` / `<leader>ca` / `<leader>cf`: Rename / Code Action / Format
- `F5` / `F10` / `F11` / `F12` / `<leader>db`: IntelliJ-grade DAP debugging
- `<leader>gg` / `<leader>gs`: Neogit interactive git client
- `<leader>gd` / `<leader>gh`: Diffview side-by-side diff & file history
- `<leader>or` / `<leader>ot`: Overseer task runner & task panel
- `<leader>tr`: Terminal smart code runner for active file
- `<leader>tn` / `<leader>ts` / `<leader>tD`: Neotest test runner & test debugger
- `Ctrl+h/j/k/l`: Unified navigation across Neovim splits & Tmux panes

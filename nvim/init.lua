-- Neovim Configuration Entry Point

-- Set leader key before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core configuration
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Load plugins (includes lazy.nvim bootstrap)
require("plugins")

-- Load LSP configuration
require("lsp")
require("lsp.servers")

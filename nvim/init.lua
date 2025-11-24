-- ============================================================================
-- COMPLETE NEOVIM CONFIGURATION
-- Save this entire file as ~/.config/nvim/init.lua
-- ============================================================================

-- Set leader key before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- BOOTSTRAP LAZY.NVIM PLUGIN MANAGER
-- ============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- LOAD MODULES
-- ============================================================================
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- ============================================================================
-- PLUGIN SETUP
-- ============================================================================
require("lazy").setup(require("plugins.init"))

-- ============================================================================
-- LSP SETUP
-- ============================================================================
require("lsp")
-- ============================================================================
-- Neovim Master Configuration Entry Point
-- ============================================================================

-- Fix PATH environment for GUI/LaunchServices, nvm, cargo, Homebrew, and Go
local path_additions = {
  "/opt/homebrew/bin",
  "/opt/homebrew/sbin",
  "/usr/local/bin",
  vim.fn.expand("$HOME/.cargo/bin"),
  vim.fn.expand("$HOME/go/bin"),
  vim.fn.expand("$HOME/.local/bin"),
}

-- Add nvm-managed node/npm to PATH if available
local nvm_dir = vim.fn.expand("$HOME/.nvm")
if vim.fn.isdirectory(nvm_dir) == 1 then
  local node_version_file = io.open(nvm_dir .. "/alias/default", "r")
  if node_version_file then
    local alias = node_version_file:read("*l"):gsub("%s+", "")
    node_version_file:close()
    if not alias:match("^v%d") then
      local lts_file = io.open(nvm_dir .. "/alias/lts/" .. alias, "r")
      if lts_file then
        alias = lts_file:read("*l"):gsub("%s+", "")
        lts_file:close()
      else
        local versions = vim.fn.glob(nvm_dir .. "/versions/node/v*", false, true)
        table.sort(versions)
        alias = versions[#versions] and vim.fn.fnamemodify(versions[#versions], ":t") or nil
      end
    end
    if alias then
      local node_bin = nvm_dir .. "/versions/node/" .. alias .. "/bin"
      if vim.fn.isdirectory(node_bin) == 1 then
        table.insert(path_additions, 1, node_bin)
      end
    end
  end
end

for _, path in ipairs(path_additions) do
  if vim.fn.isdirectory(path) == 1 and not vim.env.PATH:find(path, 1, true) then
    vim.env.PATH = path .. ":" .. vim.env.PATH
  end
end

-- Leader keys MUST be set before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable netrw in favor of modern file explorers (nvim-tree / neo-tree / oil)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Load core settings
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Bootstrap & load lazy.nvim plugin ecosystem
require("plugins")

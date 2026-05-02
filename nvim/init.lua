-- Neovim Configuration Entry Point

-- Ensure nvm-managed node/npm is on PATH (nvm only initializes in interactive shells)
local nvm_dir = vim.fn.expand("$HOME/.nvm")
local node_version_file = io.open(nvm_dir .. "/alias/default", "r")
if node_version_file then
  local alias = node_version_file:read("*l"):gsub("%s+", "")
  node_version_file:close()
  -- alias may be a version like "v22.9.0" or a named alias like "node" — resolve named aliases
  if not alias:match("^v%d") then
    local lts_file = io.open(nvm_dir .. "/alias/lts/" .. alias, "r")
    if lts_file then
      alias = lts_file:read("*l"):gsub("%s+", "")
      lts_file:close()
    else
      -- "node" alias → pick the latest installed version
      local versions = vim.fn.glob(nvm_dir .. "/versions/node/v*", false, true)
      table.sort(versions)
      alias = versions[#versions] and vim.fn.fnamemodify(versions[#versions], ":t") or nil
    end
  end
  if alias then
    local node_bin = nvm_dir .. "/versions/node/" .. alias .. "/bin"
    if vim.fn.isdirectory(node_bin) == 1 then
      vim.env.PATH = node_bin .. ":" .. vim.env.PATH
    end
  end
end

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

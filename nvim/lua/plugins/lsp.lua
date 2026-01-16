-- LSP plugin configuration
return {
  -- LSP config
  { "neovim/nvim-lspconfig" },

  -- Mason package manager
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- Mason LSP config bridge
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",      -- C/C++
          "pyright",     -- Python
          "ts_ls",       -- TypeScript/JavaScript
          "gopls",       -- Go
        },
        automatic_installation = true,
      })
    end,
  },
}

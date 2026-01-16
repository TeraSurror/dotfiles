-- Treesitter syntax highlighting configuration
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    require("nvim-treesitter").setup({
      ensure_install = { "c", "cpp", "python", "javascript", "typescript", "go", "lua", "vim", "vimdoc" },
    })

    -- Enable treesitter-based highlighting
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}

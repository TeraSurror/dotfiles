-- ============================================================================
-- Editing Ergonomics, Diagnostics & Code Outline (Surround, Comment, Trouble, Aerial)
-- ============================================================================

return {
  -- Surround Text Objects (ysiw", cs"', ds")
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- Commenting (gcc, gbc, visual gc)
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- TODO / FIXME / HACK Highlighter & Searcher
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev TODO Comment" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Search TODOs (Workspace)" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Trouble TODOs" },
    },
    opts = {},
  },

  -- Code Diagnostics & Symbols Explorer (Trouble v3)
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Workspace)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols Outline (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / References" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
    },
    opts = {
      modes = {
        diagnostics = {
          auto_close = false,
        },
      },
    },
  },

  -- Code Structure Outline (Aerial.nvim - IntelliJ Structure Tool Window equivalent)
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>co", "<cmd>AerialToggle!<CR>", desc = "Code Structure Outline" },
      { "{", "<cmd>AerialPrev<CR>", desc = "Previous Symbol" },
      { "}", "<cmd>AerialNext<CR>", desc = "Next Symbol" },
    },
    opts = {
      on_attach = function(bufnr)
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
      layout = {
        max_width = { 40, 0.25 },
        width = 32,
        default_direction = "right",
      },
      show_guides = true,
      filter_kind = false,
    },
  },
}

-- ============================================================================
-- Terminal Integration & Seamless Tmux Navigator
-- ============================================================================

return {
  -- Seamless Tmux & Neovim Split Navigation
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Window/Pane Left" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Window/Pane Down" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Window/Pane Up" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Window/Pane Right" },
    },
  },

  -- Floating & Split Terminal Manager (ToggleTerm)
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm<CR>", desc = "Toggle Terminal" },
      { "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", desc = "Terminal: Floating Window" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Terminal: Floating Window" },
      { "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<CR>", desc = "Terminal: Bottom Split" },
      { "<leader>tv", "<cmd>ToggleTerm size=60 direction=vertical<CR>", desc = "Terminal: Right Split" },
      {
        "<leader>tr",
        function()
          local ft = vim.bo.filetype
          local file = vim.fn.expand("%:p")
          local filename = vim.fn.expand("%:t")
          local filenoext = vim.fn.expand("%:r")

          local cmd = ""
          if ft == "python" then
            cmd = "python3 " .. file
          elseif ft == "javascript" then
            cmd = "node " .. file
          elseif ft == "typescript" then
            cmd = "npx tsx " .. file .. " || npx ts-node " .. file
          elseif ft == "go" then
            cmd = "go run " .. file
          elseif ft == "rust" then
            if vim.fn.filereadable("Cargo.toml") == 1 then
              cmd = "cargo run"
            else
              cmd = "rustc " .. file .. " -o /tmp/rust_bin && /tmp/rust_bin"
            end
          elseif ft == "c" then
            cmd = "clang " .. file .. " -o /tmp/c_bin && /tmp/c_bin"
          elseif ft == "cpp" then
            cmd = "clang++ -std=c++20 " .. file .. " -o /tmp/cpp_bin && /tmp/cpp_bin"
          elseif ft == "sh" or ft == "bash" or ft == "zsh" then
            cmd = "bash " .. file
          else
            vim.notify("No runner configured for filetype: " .. ft, vim.log.levels.WARN)
            return
          end

          require("toggleterm").exec(cmd, 1, 15, nil, "horizontal", "Run: " .. filename)
        end,
        desc = "Terminal: Run Current File",
      },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = false,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = false,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      function _G.set_terminal_keymaps()
        local map = vim.keymap.set
        local buf = 0
        map("t", "<Esc><Esc>", [[<C-\><C-n>]], { buffer = buf, desc = "Normal Mode in Terminal" })
        map("t", "<C-x>", [[<C-\><C-n>]], { buffer = buf, desc = "Exit Terminal Mode" })
        map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { buffer = buf, desc = "Move Left" })
        map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { buffer = buf, desc = "Move Down" })
        map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { buffer = buf, desc = "Move Up" })
        map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { buffer = buf, desc = "Move Right" })
      end

      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*",
        callback = function()
          _G.set_terminal_keymaps()
        end,
      })
    end,
  },
}

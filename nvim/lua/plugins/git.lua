-- ============================================================================
-- Complete Git Suite (Neogit, Diffview, Gitsigns)
-- ============================================================================

return {
  -- Interactive Full Git Client (Neogit - Magit clone)
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit: Open Git Status" },
      { "<leader>gs", "<cmd>Neogit<CR>", desc = "Neogit: Open Git Status" },
      { "<leader>gc", "<cmd>Neogit commit<CR>", desc = "Neogit: Commit" },
      { "<leader>gp", "<cmd>Neogit push<CR>", desc = "Neogit: Push" },
      { "<leader>gP", "<cmd>Neogit pull<CR>", desc = "Neogit: Pull" },
      { "<leader>gb", "<cmd>Neogit branch<CR>", desc = "Neogit: Branch Manager" },
      { "<leader>gl", "<cmd>Neogit log<CR>", desc = "Neogit: Commit Log" },
    },
    opts = {
      kind = "tab",
      integrations = {
        diffview = true,
        telescope = true,
      },
      signs = {
        section = { "", "" },
        item = { "", "" },
        hunk = { "", "" },
      },
    },
  },

  -- Visual Diff & Merge Conflict Resolver (Diffview.nvim)
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diffview: Open Git Diff" },
      { "<leader>gD", "<cmd>DiffviewClose<CR>", desc = "Diffview: Close Git Diff" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Diffview: Current File History" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<CR>", desc = "Diffview: Branch Git History" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = {
          layout = "diff2_horizontal",
        },
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true,
        },
      },
    },
  },

  -- Gutter Signs, Hunk Staging & Line Blame (Gitsigns)
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = " " },
        topdelete = { text = "▔" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Hunk navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Next Git Hunk" })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Prev Git Hunk" })

        -- Hunk Actions
        map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Git: Stage Hunk" })
        map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Git: Reset Hunk" })
        map("n", "<leader>hS", gs.stage_buffer, { desc = "Git: Stage Entire Buffer" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Git: Undo Stage Hunk" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "Git: Reset Buffer" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Git: Preview Hunk Diff" })
        map("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end, { desc = "Git: Blame Line Detail" })
        map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle Inline Git Blame" })
        map("n", "<leader>hd", gs.diffthis, { desc = "Git: Diff Hunk vs Index" })

        -- Text object for hunks (ih / ah)
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Git Hunk" })
      end,
    },
  },
}

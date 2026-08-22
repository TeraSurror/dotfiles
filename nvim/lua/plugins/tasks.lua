-- ============================================================================
-- Task Runner & Run Configurations (overseer.nvim / .vscode/tasks.json)
-- ============================================================================

return {
  {
    "stevearc/overseer.nvim",
    cmd = {
      "OverseerOpen",
      "OverseerClose",
      "OverseerToggle",
      "OverseerRun",
      "OverseerRunCmd",
      "OverseerBuild",
      "OverseerQuickAction",
      "OverseerTaskAction",
      "OverseerClearCache",
    },
    keys = {
      { "<leader>or", "<cmd>OverseerRun<CR>", desc = "Overseer: Run Task" },
      { "<leader>ot", "<cmd>OverseerToggle<CR>", desc = "Overseer: Toggle Task Panel" },
      { "<leader>ol", "<cmd>OverseerQuickAction restart<CR>", desc = "Overseer: Restart Last Task" },
      { "<leader>oa", "<cmd>OverseerTaskAction<CR>", desc = "Overseer: Task Action" },
      { "<leader>oc", "<cmd>OverseerClearCache<CR>", desc = "Overseer: Clear Cache" },
      { "<leader>ob", "<cmd>OverseerBuild<CR>", desc = "Overseer: Run Build Task" },
    },
    opts = {
      strategy = {
        "toggleterm",
        use_shell = true,
        direction = "horizontal",
        auto_scroll = true,
      },
      templates = { "builtin", "vscode" },
      task_list = {
        direction = "bottom",
        min_height = 10,
        max_height = 20,
        default_detail = 1,
        bindings = {
          ["?"] = "ShowHelp",
          ["g?"] = "ShowHelp",
          ["<CR>"] = "RunAction",
          ["<C-e>"] = "Edit",
          ["o"] = "Open",
          ["<C-v>"] = "OpenVsplit",
          ["<C-s>"] = "OpenSplit",
          ["<C-f>"] = "OpenFloat",
          ["p"] = "TogglePreview",
          ["<C-l>"] = "IncreaseDetail",
          ["<C-h>"] = "DecreaseDetail",
          ["L"] = "IncreaseAllDetail",
          ["H"] = "DecreaseAllDetail",
          ["["] = "DecreaseWidth",
          ["]"] = "IncreaseWidth",
          ["{"] = "PrevTask",
          ["}"] = "NextTask",
          ["<C-k>"] = "ScrollOutputUp",
          ["<C-j>"] = "ScrollOutputDown",
          ["q"] = "Close",
        },
      },
    },
  },
}

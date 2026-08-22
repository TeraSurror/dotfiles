-- ============================================================================
-- Debug Adapter Protocol (DAP) - IntelliJ/VSCode-grade Visual Debugger
-- ============================================================================

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "jay-babu/mason-nvim-dap.nvim",
      "leoluz/nvim-dap-go",
      "mfussenegger/nvim-dap-python",
    },
    keys = {
      -- Standard IntelliJ / VSCode Keybindings
      { "<F5>", function() require("dap").continue() end, desc = "Debug: Start / Continue" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
      -- Leader Keybindings
      { "<leader>dc", function() require("dap").continue() end, desc = "Debug: Continue / Start" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Debug: Step Over" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Debug: Step Into" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Debug: Step Out" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
      {
        "<leader>dB",
        function()
          vim.ui.input({ prompt = "Breakpoint Condition: " }, function(condition)
            if condition and #condition > 0 then
              require("dap").set_breakpoint(condition)
            end
          end)
        end,
        desc = "Debug: Conditional Breakpoint",
      },
      {
        "<leader>lp",
        function()
          vim.ui.input({ prompt = "Log Point Message: " }, function(msg)
            if msg and #msg > 0 then
              require("dap").set_breakpoint(nil, nil, msg)
            end
          end)
        end,
        desc = "Debug: Set Log Point",
      },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Debug: Toggle UI Panels" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Debug: Toggle REPL" },
      { "<leader>dx", function() require("dap").terminate() end, desc = "Debug: Terminate Session" },
      {
        "<leader>dl",
        function()
          if vim.fn.filereadable(".vscode/launch.json") == 1 then
            require("dap.ext.vscode").load_launchjs(nil, {
              codelldb = { "c", "cpp", "rust" },
              debugpy = { "python" },
              delve = { "go" },
              ["pwa-node"] = { "javascript", "typescript" },
              node = { "javascript", "typescript" },
            })
            vim.notify("Loaded .vscode/launch.json configurations 🚀", vim.log.levels.INFO)
          else
            vim.notify("No .vscode/launch.json found in current directory", vim.log.levels.WARN)
          end
        end,
        desc = "Debug: Load .vscode/launch.json",
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Mason-nvim-dap setup
      require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb", "debugpy", "delve", "js-debug-adapter" },
        automatic_installation = true,
        handlers = {},
      })

      -- Inline Virtual Text
      require("nvim-dap-virtual-text").setup({
        commented = true,
        highlight_changed_variables = true,
        show_stop_reason = true,
      })

      -- DAP UI layout configuration
      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.35 },
              { id = "breakpoints", size = 0.20 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.20 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.6 },
              { id = "console", size = 0.4 },
            },
            size = 10,
            position = "bottom",
          },
        },
      })

      -- Auto open/close DAP UI on debug lifecycle
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Breakpoint / Program Counter signs & styling
      vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e55561", bold = true })
      vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#e2b86b", bold = true })
      vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#4fa6ed", bold = true })
      vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379", bold = true })

      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "Visual", numhl = "DapStopped" })

      -- 1. Go Debugging (nvim-dap-go)
      require("dap-go").setup()

      -- 2. Python Debugging (nvim-dap-python)
      local python_path = vim.fn.exepath("python3") or "python3"
      require("dap-python").setup(python_path)

      -- 3. C / C++ / Rust (codelldb adapter)
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.c = {
        {
          name = "Launch C/C++ Executable",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }
      dap.configurations.cpp = dap.configurations.c
      dap.configurations.rust = {
        {
          name = "Debug Rust Binary",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
          initCommands = function()
            local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))
            local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
            local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"
            local commands = {}
            local file = io.open(commands_file, "r")
            if file then
              for line in file:lines() do
                table.insert(commands, line)
              end
              file:close()
            end
            table.insert(commands, script_import)
            return commands
          end,
        },
      }

      -- 4. JavaScript / TypeScript (Node & Chrome)
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "js-debug-adapter",
          args = { "${port}" },
        },
      }

      dap.configurations.javascript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Current File (Node.js)",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to Process",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
      dap.configurations.typescript = dap.configurations.javascript
      dap.configurations.javascriptreact = dap.configurations.javascript
      dap.configurations.typescriptreact = dap.configurations.javascript

      -- Automatically load .vscode/launch.json if present on workspace root
      if vim.fn.filereadable(".vscode/launch.json") == 1 then
        pcall(require("dap.ext.vscode").load_launchjs, nil, {
          codelldb = { "c", "cpp", "rust" },
          debugpy = { "python" },
          delve = { "go" },
          ["pwa-node"] = { "javascript", "typescript" },
          node = { "javascript", "typescript" },
        })
      end
    end,
  },
}

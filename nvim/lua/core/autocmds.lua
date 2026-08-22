-- ============================================================================
-- Core Neovim Autocommands
-- ============================================================================

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local general_group = augroup("GeneralSettings", { clear = true })
local filetype_group = augroup("FileTypeCustomSettings", { clear = true })

-- 1. Highlight yanked text briefly
autocmd("TextYankPost", {
  group = general_group,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 180 })
  end,
  desc = "Highlight text on yank",
})

-- 2. Restore cursor to last known position when opening a file
autocmd("BufReadPost", {
  group = general_group,
  callback = function(args)
    local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) <= vim.fn.line("$")
    local not_commit = vim.b[args.buf].filetype ~= "gitcommit"
    if valid_line and not_commit then
      pcall(vim.cmd, [[normal! g`"]])
    end
  end,
  desc = "Restore last cursor position",
})

-- 3. Auto resize splits if window/terminal is resized
autocmd("VimResized", {
  group = general_group,
  command = "tabdo wincmd =",
  desc = "Equalize splits on window resize",
})

-- 4. Close auxiliary windows with 'q'
autocmd("FileType", {
  group = general_group,
  pattern = {
    "qf",
    "help",
    "man",
    "lspinfo",
    "checkhealth",
    "dap-float",
    "notify",
    "trouble",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
  desc = "Close helper windows with q",
})

-- 5. Terminal buffer enhancements
autocmd("TermOpen", {
  group = general_group,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
  desc = "Configure terminal buffer appearance",
})

-- 6. Trim trailing whitespace on save (exclude git commits and diffs)
autocmd("BufWritePre", {
  group = general_group,
  pattern = "*",
  callback = function()
    local ft = vim.bo.filetype
    if ft ~= "gitcommit" and ft ~= "diff" and ft ~= "markdown" then
      local curpos = vim.api.nvim_win_get_cursor(0)
      vim.cmd([[silent! %s/\s\+$//e]])
      pcall(vim.api.nvim_win_set_cursor, 0, curpos)
    end
  end,
  desc = "Remove trailing whitespace on save",
})

-- 7. Language-specific indentation rules
-- Python (PEP 8: 4 spaces)
autocmd("FileType", {
  group = filetype_group,
  pattern = { "python" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
    vim.opt_local.colorcolumn = "88"
  end,
})

-- C / C++ (4 spaces)
autocmd("FileType", {
  group = filetype_group,
  pattern = { "c", "cpp", "h", "hpp" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
    vim.opt_local.colorcolumn = "100"
  end,
})

-- Rust (4 spaces)
autocmd("FileType", {
  group = filetype_group,
  pattern = { "rust" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
    vim.opt_local.colorcolumn = "100"
  end,
})

-- Go (Tabs, width 4)
autocmd("FileType", {
  group = filetype_group,
  pattern = { "go", "gomod", "gowork" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = false
  end,
})

-- Web / JS / TS / JSON / YAML / Lua (2 spaces)
autocmd("FileType", {
  group = filetype_group,
  pattern = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
    "jsonc",
    "yaml",
    "html",
    "css",
    "scss",
    "lua",
  },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

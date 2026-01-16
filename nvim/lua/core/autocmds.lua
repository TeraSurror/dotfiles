-- Autocommands configuration
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General settings
local general = augroup("General", { clear = true })

-- Highlight yanked text
autocmd("TextYankPost", {
  group = general,
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
  desc = "Highlight when yanking text",
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = general,
  pattern = "*",
  command = [[%s/\s\+$//e]],
  desc = "Remove trailing whitespace",
})

-- Restore cursor position
autocmd("BufReadPost", {
  group = general,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Restore cursor position",
})

-- Language-specific settings
local filetype_settings = augroup("FileTypeSettings", { clear = true })

-- C/C++ settings
autocmd("FileType", {
  group = filetype_settings,
  pattern = { "c", "cpp" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
    vim.opt_local.colorcolumn = "80"
  end,
  desc = "C/C++ specific settings",
})

-- Python settings
autocmd("FileType", {
  group = filetype_settings,
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
    vim.opt_local.colorcolumn = "88"
  end,
  desc = "Python specific settings",
})

-- JavaScript/TypeScript settings
autocmd("FileType", {
  group = filetype_settings,
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
  desc = "JavaScript/TypeScript specific settings",
})

-- Go settings
autocmd("FileType", {
  group = filetype_settings,
  pattern = "go",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = false
  end,
  desc = "Go specific settings",
})

-- Auto-format on save for Go
autocmd("BufWritePre", {
  group = filetype_settings,
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
  desc = "Format Go files on save",
})

-- Close certain filetypes with 'q'
autocmd("FileType", {
  group = general,
  pattern = {
    "qf",
    "help",
    "man",
    "lspinfo",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
  desc = "Close with q",
})

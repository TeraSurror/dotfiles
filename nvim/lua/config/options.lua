-- Core Neovim options configuration
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs and indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line wrapping
opt.wrap = false

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.cursorline = true

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- File encoding
opt.fileencoding = "utf-8"

-- Undo and backup
opt.undofile = true
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Update time
opt.updatetime = 300
opt.timeoutlen = 300

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Mouse
opt.mouse = "a"

-- Scroll
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Command line
opt.cmdheight = 1
opt.showmode = false

-- Performance
opt.lazyredraw = true

-- Show matching brackets
opt.showmatch = true

-- Configure diagnostic appearance
vim.diagnostic.config({
  virtual_text = false,        -- Disable inline error text
  signs = true,                -- Keep gutter signs
  underline = true,            -- Enable underlines
  update_in_insert = false,
  severity_sort = true,
})

return {}
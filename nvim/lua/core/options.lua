-- ============================================================================
-- Core Neovim Options
-- ============================================================================

local opt = vim.opt

-- Line Numbers & Gutter
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true

-- Tabs & Indentation (Defaults: 2 spaces, overridden per filetype in autocmds)
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.shiftround = true

-- Line Wrapping & Formatting
opt.wrap = false
opt.linebreak = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Search Settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.inccommand = "split" -- Live preview of search/replace (:s/foo/bar/g)

-- Colors & Appearance
opt.termguicolors = true
opt.background = "dark"
opt.showmode = false -- Mode is shown in lualine
opt.pumheight = 10 -- Popup menu height
opt.pumblend = 10 -- Popup menu transparency

-- System Clipboard
opt.clipboard:append("unnamedplus")

-- Window Splits
opt.splitright = true
opt.splitbelow = true

-- File & Buffer Handling
opt.fileencoding = "utf-8"
opt.undofile = true -- Persistent undo history across sessions
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.autoread = true -- Auto reload file if changed outside Neovim

-- Performance & Timings
opt.updatetime = 250 -- Faster completion & diagnostic updates (default 4000)
opt.timeoutlen = 300 -- Faster which-key and leader trigger
opt.lazyredraw = false -- Keep UI responsive with modern Lua plugins

-- Completion Menu
opt.completeopt = "menu,menuone,noselect"

-- Mouse Support
opt.mouse = "a"

-- UI Symbols & Folds
opt.fillchars = {
  eob = " ", -- Hide ugly ~ on blank lines at end of buffer
  fold = " ",
  foldopen = "",
  foldsep = " ",
  foldclose = "",
}
opt.list = true
opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
}

-- Code Folding (using Tree-sitter expression folding by default)
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- ~/.config/nvim/lua/options.lua
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.termguicolors = true -- Essential for true color support
vim.opt.cmdheight = 1
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.wrap = true -- Disable word wrap
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 100 -- Faster update for LSP diagnostics
vim.opt.timeoutlen = 1000 -- Shorter timeout for key sequences
vim.opt.signcolumn = "yes" -- Always show sign column for LSP diagnostics

vim.opt.syntax = "on"
vim.opt.pumblend = 20

-- vim.api.nvim_command("highlight NormalFloat guibg=NONE") -- Makes background transparent for GUI
vim.api.nvim_command("highlight NormalFloat ctermbg=NONE") -- Makes background transparent for terminal

-- Line Numbers
vim.opt.number = true         -- Absolute line numbers
vim.opt.relativenumber = false -- Relative line numbers (helpful for Vim motions)

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = false

-- Search
vim.opt.hlsearch   = true
vim.opt.incsearch  = true
vim.opt.ignorecase = false
vim.opt.smartcase  = true

-- Folding (optional)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.get_foldtext()"
vim.opt.foldnestmax = 3
vim.opt.foldenable = false


-- vim.o.completeopt = "menu,preview"

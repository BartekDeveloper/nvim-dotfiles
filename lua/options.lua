vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.termguicolors = true
vim.opt.cmdheight = 1
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.wrap = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 100
vim.opt.timeoutlen = 300
vim.opt.signcolumn = "yes:1"
vim.opt.syntax = "on"
vim.opt.pumblend = 20
vim.api.nvim_command("highlight NormalFloat ctermbg=NONE")
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Folds (nvim-ufo)
vim.opt.foldmethod = "expr"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldcolumn = "1"

-- UI Settings
vim.opt.cursorline = true
vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Completion
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Split behavior
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Wildmenu
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.wildignore = "*.o,*.obj,*.bak,*.exe,*.pyc,*.swp"

-- List chars for visibility
vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",
  trail = "·",
  extends = "…",
  precedes = "…",
  nbsp = "␣",
}

-- Other settings
vim.opt.lazyredraw = false
vim.opt.synmaxcol = 300
vim.opt.backupdir = vim.fn.stdpath("data") .. "/backup"
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
vim.opt.timeout = true

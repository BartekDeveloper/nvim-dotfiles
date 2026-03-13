-- ~/.config/nvim/init.lua

-- Set your leader key (e.g., spacebar) before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.lsp.set_log_level("INFO")

-- --- Lazy.nvim (plugin manager) setup ---
-- Define the path where Lazy.nvim will be installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if Lazy.nvim is already installed. If not, clone it.
if not vim.loop.fs_stat(lazypath) then
  print("Installing lazy.nvim...")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
  print("lazy.nvim installed.")
end

-- Add Lazy.nvim to Neovim's runtime path so it can be loaded
vim.opt.rtp:prepend(lazypath)

-- --- Load Lazy.nvim and define/load your plugins ---
-- This is the core call that makes Lazy.nvim run and manage your plugins.
-- It will read the `plugins` table returned by `require("plugins")`.
require("lazy").setup({
  { import = "plugins" }, -- This line tells Lazy.nvim to load plugins from lua/plugins.lua
}, {
  -- Lazy.nvim configuration options
  change_detection = {
    enabled = true,
    notify  = true, -- Disable notification for changes (optional)
  },
  -- Debugging option: Set to true if plugins are not loading
  verbose = true,
  -- Concurrency: How many plugins to install/update at once
  concurrency = 10,
})

-- --- Load your custom configuration files ---
-- These are loaded *after* plugins, as plugins might set up defaults
-- that you then want to override or augment.
require("options")   -- For general Neovim options (e.g., line numbers)
require("keymaps")   -- For your custom keybindings
require("autocmds")  -- Autocmds and additional settings

-- --- Filetype detection for C3 ---
vim.filetype.add({
  extension = {
    c3 = "c3",
    c3i = "c3",
  },
})

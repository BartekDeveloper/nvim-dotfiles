-- Autocmds and additional settings

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 150,
      on_visual = true,
    })
  end,
})

-- Set filetype for specific extensions
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.c3",
  command = "set filetype=c3",
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  command = "wincmd =",
})

-- Open help in a vertical split
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = "wincmd L",
})

-- Set spell checking for specific filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit" },
  command = "setlocal spell",
})

-- Auto-save session (requires session plugin)
-- vim.api.nvim_create_autocmd("VimLeavePre", {
--   pattern = "*",
--   command = "SessionSave",
-- })

-- Enable italic comments
vim.cmd("highlight Comment gui=italic")

-- Better quickfix behavior
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  command = "set nobuflisted",
})

-- Better terminal behavior
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "setlocal nonumber norelativenumber",
})

-- Better file type detection
vim.filetype.add({
  extension = {
    c3 = "c3",
    c3i = "c3",
    mdx = "markdown",
  },
  filename = {
    ["TODO"] = "todo",
    ["FIXME"] = "todo",
    ["NOTE"] = "todo",
  },
  pattern = {
    [".*%.c3i"] = "c3",
  },
})

-- Better search highlighting
vim.api.nvim_create_autocmd("CmdlineEnter", {
  pattern = "/,?",
  command = "set hlsearch",
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
  pattern = "/,?",
  command = "set nohlsearch",
})

-- Formatting commands
-- Auto-detect indentation and set options
vim.api.nvim_create_user_command("FormatIndent", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local expandtab = vim.bo[bufnr].expandtab
  local shiftwidth = vim.bo[bufnr].shiftwidth
  
  if expandtab then
    vim.notify("Detected spaces (shiftwidth=" .. shiftwidth .. ")", vim.log.levels.INFO)
  else
    vim.notify("Detected tabs (tabstop=" .. vim.bo[bufnr].tabstop .. ")", vim.log.levels.INFO)
  end
end, { desc = "Auto-detect indentation type" })

-- Format to 2 spaces
vim.api.nvim_create_user_command("FormatToSpaces2", function()
  vim.bo.expandtab = true
  vim.bo.tabstop = 2
  vim.bo.shiftwidth = 2
  vim.cmd("retab!")
  vim.notify("Converted to 2 spaces", vim.log.levels.INFO)
end, { desc = "Convert buffer to 2 spaces" })

-- Format to 4 spaces
vim.api.nvim_create_user_command("FormatToSpaces4", function()
  vim.bo.expandtab = true
  vim.bo.tabstop = 4
  vim.bo.shiftwidth = 4
  vim.cmd("retab!")
  vim.notify("Converted to 4 spaces", vim.log.levels.INFO)
end, { desc = "Convert buffer to 4 spaces" })

-- Format to tabs
vim.api.nvim_create_user_command("FormatToTabs", function()
  vim.bo.expandtab = false
  vim.bo.tabstop = 4
  vim.bo.shiftwidth = 4
  vim.cmd("retab!")
  vim.notify("Converted to tabs", vim.log.levels.INFO)
end, { desc = "Convert buffer to tabs" })

-- Convert spaces to tabs
vim.api.nvim_create_user_command("ConvertToTabs", function()
  vim.cmd("set expandtab!")
  vim.cmd("retab!")
  vim.notify("Converted spaces to tabs", vim.log.levels.INFO)
end, { desc = "Convert spaces to tabs" })

-- Convert tabs to spaces
vim.api.nvim_create_user_command("ConvertToSpaces", function()
  vim.cmd("set expandtab")
  vim.cmd("retab!")
  vim.notify("Converted tabs to spaces", vim.log.levels.INFO)
end, { desc = "Convert tabs to spaces" })

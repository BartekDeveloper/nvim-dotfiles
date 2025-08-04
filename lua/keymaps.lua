-- ~/.config/nvim/lua/keymaps.lua
-- This file defines your custom keybindings.

-- Set a convenient variable for setting keymaps
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Example custom keymaps:
map("n", "<leader>w", ":w<CR>", opts)  -- Save file
map("n", "<leader>q", ":q<CR>", opts)  -- Quit Neovim
map("n", "<leader>Q", ":qa!<CR>", opts) -- Force quit all buffers
map("n", "<leader>s", "<cmd>split<CR>", opts) -- Horizontal split
map("n", "<leader>v", "<cmd>vsplit<CR>", opts) -- Vertical split
map("t", "<Esc>", "<C-\\><C-n>", opts)

-- Navigate between splits
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Buffer navigation
map("n", "<leader>bn", ":bnext<CR>", opts) -- Next buffer
map("n", "<leader>bp", ":bprevious<CR>", opts) -- Previous buffer
map("n", "<leader>bd", ":bdelete<CR>", opts) -- Delete current buffer

-- For LSP formatting, which is also mapped via LSP's on_attach
map("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", { desc = "Format current buffer" })

-- ~/.config/nvim/init.lua (or a separate keymaps file)

-- Set up some basic keybindings
vim.keymap.set("i", "<C-Del>", "<C-w>", { desc = "Delete word backward (like Ctrl+Backspace)" })
vim.keymap.set("i", "<C-S-Del>", "<Esc>de", { desc = "Delete word forward (like Ctrl+Del)" })
vim.keymap.set("i", "<C-S-D>", "<Esc>dE", { desc = "Delete WORD forward (even more, similar to Ctrl+Shift+Del)" })

-- Explanation of the above mappings:
-- In Insert mode:
-- <C-Del> (Ctrl + Delete): Mapped to <C-w>. In Neovim, <C-w> in insert mode deletes the word before the cursor.
-- This mimics the behavior of Ctrl+Backspace in many editors, but it's a common mapping for Ctrl+Del.
-- If you want Ctrl+Del to delete the word *after* the cursor (more like standard Ctrl+Del), you need to exit insert mode,
-- delete the word, and then go back to insert mode.
--
-- <C-S-Del> (Ctrl + Shift + Delete): Mapped to <Esc>de.
--   <Esc>: Exit Insert mode to Normal mode.
--   d: Delete operator.
--   e: Motion to the end of the current word.
--   This sequence effectively deletes the word from the cursor to its end, then puts you back in Normal mode.
--   If you want to stay in insert mode, it's a bit more complex and often not ideal due to Neovim's modal nature.
--
-- <C-S-D> (Ctrl + Shift + D): Mapped to <Esc>dE.
--   Similar to <C-S-Del>, but uses 'E' motion (end of a "WORD" - non-whitespace characters) instead of 'e' (end of a "word" - alphanumeric characters).
--   This allows you to delete "even more" by considering different word boundaries, which aligns with your "delete even more" request.
--   You can adjust this motion (e.g., `d$`) if "even more" means to the end of the line.

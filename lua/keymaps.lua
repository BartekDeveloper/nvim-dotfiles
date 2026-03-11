local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)
map("n", "<leader>Q", ":qa!<CR>", opts)
map("n", "<leader>s", "<cmd>split<CR>", opts)
map("n", "<leader>v", "<cmd>vsplit<CR>", opts)
map("t", "<Esc>", "<C-\\><C-n>", opts)

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("n", "<leader>bn", ":bnext<CR>", opts)
map("n", "<leader>bp", ":bprevious<CR>", opts)
map("n", "<leader>bd", ":bdelete<CR>", opts)

map("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", { desc = "Format current buffer" })

vim.keymap.set("i", "<C-Del>", "<C-w>", { desc = "Delete word backward (like Ctrl+Backspace)" })
vim.keymap.set("i", "<C-S-Del>", "<Esc>de", { desc = "Delete word forward (like Ctrl+Del)" })
vim.keymap.set("i", "<C-S-D>", "<Esc>dE", { desc = "Delete WORD forward (even more, similar to Ctrl+Shift+Del)" })

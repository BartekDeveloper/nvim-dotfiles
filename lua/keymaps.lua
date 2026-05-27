local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Save and quit
map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)
map("n", "<leader>Q", ":qa!<CR>", opts)

-- NEW: :Q and :Q! commands - save all and quit
-- Overwrite the existing Q command (which is an alias for :visual)
vim.api.nvim_create_user_command("Q", function(opts)
  if opts.bang then
    vim.cmd("wqa!")
  else
    vim.cmd("wqa")
  end
end, { bang = true })

-- Diagnostics keymaps
map("n", "<leader>dn", function() vim.diagnostic.goto_next() end, { desc = "Go to next diagnostic" })
map("n", "<leader>dp", function() vim.diagnostic.goto_prev() end, { desc = "Go to previous diagnostic" })
map("n", "<leader>da", function() vim.diagnostic.open_float() end, { desc = "Show diagnostic at cursor" })
map("n", "<leader>dq", function() vim.diagnostic.setloclist() end, { desc = "Add diagnostics to location list" })

-- NEW: <leader>space to save file
map("n", "<leader><space>", ":w<CR>", { desc = "Save file" })

-- NEW: <leader>gh to switch between C/C++ source and header files
map("n", "<leader>gh", ":ClangdSwitchSourceHeader<CR>", { desc = "Switch between C/C++ source and header" })

-- NEW: <leader>hx to toggle hex/bin view of file
map("n", "<leader>hx", function()
  -- Check if we're already in hex view by looking for xxd filetype
  if vim.bo.filetype == "xxd" then
    -- Convert back to normal file
    vim.cmd(":%!xxd -r")
    vim.bo.filetype = ""
    vim.notify("Switched to normal file view", vim.log.levels.INFO)
  else
    -- Convert to hex view
    vim.cmd(":%!xxd")
    vim.bo.filetype = "xxd"
    vim.notify("Switched to hex view", vim.log.levels.INFO)
  end
end, { desc = "Toggle hex/normal file view" })
map("n", "<leader>hX", ":%!xxd -r<CR>", { desc = "Convert hex back to binary" })

-- Split window management
map("n", "<leader>s", "<cmd>split<CR>", opts)
map("n", "<leader>v", "<cmd>vsplit<CR>", opts)
map("t", "<Esc>", "<C-\\><C-n>", opts)

-- Window navigation (using Ctrl+w + direction for standard Vim navigation)
-- Note: Ctrl+L is now used for selecting whole line
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
-- map("n", "<C-l>", "<C-w>l", opts)  -- Removed: now used for selecting whole line

-- NEW: Tab navigation with Alt+H and Alt+L using bufferline
-- Bufferline provides a visual tab bar at the top
-- These mappings cycle through tabs/buffers shown in the bar
map("n", "<A-h>", ":BufferLineCyclePrev<CR>", { desc = "Go to previous tab" })
map("n", "<A-l>", ":BufferLineCycleNext<CR>", { desc = "Go to next tab" })
-- Move tabs left/right
map("n", "<A-H>", ":BufferLineMovePrev<CR>", { desc = "Move tab left" })
map("n", "<A-L>", ":BufferLineMoveNext<CR>", { desc = "Move tab right" })
-- Pick tab by letter
map("n", "<leader>bb", ":BufferLinePick<CR>", { desc = "Pick tab" })

-- Buffer navigation
map("n", "<leader>bn", ":bnext<CR>", opts)
map("n", "<leader>bp", ":bprevious<CR>", opts)
map("n", "<leader>bd", ":bdelete<CR>", opts)

-- LSP formatting
map("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", { desc = "Format current buffer" })

-- Fold keymaps
map("n", "<leader>zz", "za", { desc = "Toggle fold under cursor" })
map("n", "<leader>zO", "zR", { desc = "Open all folds" })
map("n", "<leader>zC", "zM", { desc = "Close all folds" })
map("n", "<leader>zo", "zr", { desc = "Reduce fold level" })
map("n", "<leader>zc", "zm", { desc = "Increase fold level" })

-- Git keymaps
map("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Git status" })
map("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Git blame" })
map("n", "<leader>gd", "<cmd>Gdiff<CR>", { desc = "Git diff" })
map("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "Git commit" })
map("n", "<leader>gp", "<cmd>Git push<CR>", { desc = "Git push" })
map("n", "<leader>gl", "<cmd>Git log<CR>", { desc = "Git log" })
map("n", "<leader>gr", "<cmd>Git reset<CR>", { desc = "Git reset" })

-- Trouble keymaps (also defined in plugin setup but kept here for reference)
-- <leader>xx, <leader>xw, <leader>xd, <leader>xq, <leader>xl, gr

-- Quick buffer navigation
map("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<CR>", { desc = "Go to buffer 1" })
map("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<CR>", { desc = "Go to buffer 2" })
map("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<CR>", { desc = "Go to buffer 3" })
map("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<CR>", { desc = "Go to buffer 4" })
map("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<CR>", { desc = "Go to buffer 5" })

-- Quick tab navigation
map("n", "<leader>tt", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "<leader>tn", "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<leader>tp", "<cmd>tabprevious<CR>", { desc = "Previous tab" })

-- Telescope enhancements
map("n", "<leader>fR", "<cmd>Telescope registers<CR>", { desc = "Telescope registers" })
map("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "Telescope marks" })
map("n", "<leader>fq", "<cmd>Telescope quickfix<CR>", { desc = "Telescope quickfix" })
map("n", "<leader>fl", "<cmd>Telescope loclist<CR>", { desc = "Telescope loclist" })
map("n", "<leader>fc", "<cmd>Telescope commands<CR>", { desc = "Telescope commands" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Telescope keymaps" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope help tags" })
map("n", "<leader>ft", "<cmd>Telescope treesitter<CR>", { desc = "Telescope treesitter" })

-- Telescope keybindings
map("n", "ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fa", "<cmd>Telescope live_grep_args<CR>", { desc = "Live grep with args" })



-- Insert mode deletions
vim.keymap.set("i", "<C-Del>", "<C-w>", { desc = "Delete word backward (like Ctrl+Backspace)" })
vim.keymap.set("i", "<C-S-Del>", "<Esc>de", { desc = "Delete word forward (like Ctrl+Del)" })
vim.keymap.set("i", "<C-S-D>", "<Esc>dE", { desc = "Delete WORD forward (even more, similar to Ctrl+Shift+Del)" })

-- Conform formatting (from plugins.lua)
map("n", "<leader>fm", "<cmd>ConformFormat<CR>", { desc = "Format with Conform" })
map("v", "<leader>fm", "<cmd>ConformFormatVisual<CR>", { desc = "Format selection with Conform" })

-- NvimTree toggle (from plugins.lua, improved logic)
map("n", "<leader>e", function()
  local view = require("nvim-tree.view")
  local api = require("nvim-tree.api")
  if view.is_visible() then
    api.tree.close()
  else
    -- Get the directory of the current file
    local current_file = vim.fn.expand("%:p")
    if current_file and current_file ~= "" then
      -- If file is in a git repo, use git root, else use file's directory
      local current_dir = vim.fn.fnamemodify(current_file, ":h")
      -- Change to that directory
      vim.cmd("cd " .. vim.fn.fnameescape(current_dir))
    end
    api.tree.open()
  end
end, { desc = "Toggle file explorer at file's directory" })

-- Trouble keymaps (from plugins.lua)
map("n", "<leader>xx", "<cmd>TroubleToggle<CR>", { desc = "Toggle Trouble" })
map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", { desc = "Workspace diagnostics" })
map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", { desc = "Document diagnostics" })
map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", { desc = "Quickfix" })
map("n", "<leader>xl", "<cmd>TroubleToggle loclist<CR>", { desc = "Loclist" })
map("n", "gr", "<cmd>TroubleToggle lsp_references<CR>", { desc = "LSP References" })

-- DAP keymaps (from plugins.lua)
map("n", "<leader>dd", function() require("dap").continue() end, { desc = "Start/Continue debugging" })
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle breakpoint" })
map("n", "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = "Set conditional breakpoint" })
map("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Run last debug session" })
map("n", "<leader>dn", function() require("dap").step_over() end, { desc = "Step over" })
map("n", "<leader>di", function() require("dap").step_into() end, { desc = "Step into" })
map("n", "<leader>do", function() require("dap").step_out() end, { desc = "Step out" })
map("n", "<leader>dc", function() require("dap").terminate() end, { desc = "Terminate debugging" })

-- WhichKey keymap (from plugins.lua)
map("n", "<leader>", "<cmd>WhichKey '<leader>'<CR>", { desc = "Show WhichKey" })

-- Image viewing (requires kitty or wezterm)
map("n", "<leader>im", function()
  require("image").toggle()
end, { desc = "Toggle image viewing" })

-- Ctrl+L to select whole line (visual mode)
map("x", "<C-l>", "V", { desc = "Select whole line" })
-- Ctrl+L to select current line in normal mode
map("n", "<C-l>", "V", { desc = "Select current line" })

-- Clear search highlights
map("n", "<Leader>l", "<Cmd>noh<CR>", { desc = "Clear search highlights" })


-- Get directory of current file (NOT cwd)
local function get_current_file_dir()
  local current_file = vim.fn.expand("%:p")
  if current_file == "" then
    return vim.fn.getcwd()
  end
  return vim.fn.fnamemodify(current_file, ":h")
end

-- Create new file
local function create_file()
  local dir = get_current_file_dir()

  vim.ui.input({
    prompt = "New file: ",
    default = dir .. "/",
  }, function(input)
    if not input or input == "" then return end

    local ok, err = pcall(function()
      local file_dir = vim.fn.fnamemodify(input, ":h")
      vim.fn.mkdir(file_dir, "p")

      if vim.fn.filereadable(input) == 0 then
        vim.fn.writefile({}, input)
      end

      vim.cmd("edit " .. vim.fn.fnameescape(input))
      vim.notify("Created file: " .. input, vim.log.levels.INFO)
    end)

    if not ok then
      vim.notify("Error: " .. err, vim.log.levels.ERROR)
    end
  end)
end

-- Create new directory
local function create_dir()
  local dir = get_current_file_dir()

  vim.ui.input({
    prompt = "New directory: ",
    default = dir .. "/",
  }, function(input)
    if not input or input == "" then return end

    local ok, err = pcall(function()
      vim.fn.mkdir(input, "p")
      vim.notify("Created directory: " .. input, vim.log.levels.INFO)
    end)

    if not ok then
      vim.notify("Error: " .. err, vim.log.levels.ERROR)
    end
  end)
end

-- KEYMAPS

-- Ctrl + Numpad5 → file
vim.keymap.set("n", "<C-k5>", create_file, {
  desc = "Create file in current file directory",
})

-- Ctrl + Numpad2 → directory
vim.keymap.set("n", "<C-k2>", create_dir, {
  desc = "Create directory in current file directory",
})

-- ~/.config/nvim/lua/plugins.lua
-- This file defines all the Neovim plugins you want to use.

return {
  -- --- Colorscheme ---
  {
    "folke/tokyonight.nvim",
    lazy = false, -- Load this plugin immediately at startup
    priority = 1000, -- Ensures it loads before other plugins
    config = function()
      vim.cmd.colorscheme("tokyonight-night") -- Set your desired colorscheme style
      vim.o.background = "dark"
    end,
  },

  -- --- Treesitter ---
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- This command installs Treesitter parsers after plugin installation
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c", "cpp", "python", "rust", "go", "lua", "php", "html", "css", "javascript", "typescript", "odin", "toml"
        },
        highlight = {
          enable = true, -- Enable Treesitter syntax highlighting
        },
        indent = { enable = true }, -- Enable Treesitter-based indentation (optional)
      })
    end,
  },

  -- --- LSP (Language Server Protocol) Support ---
  -- Mason: Universal package manager for language servers, formatters, linters, etc.
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  -- Mason-LSPConfig: Integrates Mason with nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
            "rust_analyzer",
            "clang_format", -- Generally clang-format is an executable, not an LSP. Reverted to clang_format for consistency if it's meant to be an LSP.
            "gopls",
            "clangd",
            "pyright",
            "intelephense",
            "ts_ls",        -- Corrected from ts-ls
            "lua_ls",
            "ols",
            "asm_lsp",
            "jdtls",
            "ast_grep",
            "html",
            "cssls",
            "harper_ls",
            "denols",
            "cmake",
            "eslint_d",     -- ADDED: For ESLint linting and fixes
        },
      })
    end,
  },
  -- nvim-lspconfig: Neovim's built-in LSP client configurations
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
    config = function()
      local lspconfig = require("lspconfig")
      local on_attach = function(client, bufnr)
        -- Keybindings for LSP actions (e.g., go to definition, rename, code action)
        local buf_set_keymap = vim.api.nvim_buf_set_keymap
        local opts = { noremap = true, silent = true }

        buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
        buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
        -- REMOVED: Auto-format on save. Formatting is now handled manually by conform.nvim (<leader>fm)
        -- or via a manual LSP format action if conform is not configured for the filetype.
        -- buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts) -- Use <leader>fm for conform.nvim
        buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
        buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
        buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.set_loclist()<CR>", opts)

        -- ADDED: Keymap for ESLint fix-all (only for relevant filetypes)
        if client.name == "eslint" then
          buf_set_keymap(bufnr, "n", "<leader>ef", "<cmd>lua vim.lsp.buf.code_action({ context = { only = { 'source.fixAll' } }, apply = true })<CR>", { noremap = true, silent = true, desc = "ESLint: Fix All Problems" })
        end

        -- Removed auto-format on save entirely. User wants explicit control.
        -- if client.supports_method("textDocument/formatting") then
        --     vim.api.nvim_create_autocmd("BufWritePre", {
        --         group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
        --         buffer = bufnr,
        --         callback = function()
        --             vim.lsp.buf.format({ bufnr = bufnr })
        --         end,
        --     })
        -- end
      end

      -- Setup individual language servers (Mason-LSPConfig handles most of this automatically,
      -- but you can still override or add custom settings here if needed)
      lspconfig.rust_analyzer.setup({ on_attach = on_attach })
      lspconfig.gopls.setup({ on_attach = on_attach })
      lspconfig.clangd.setup({ on_attach = on_attach })
      lspconfig.pyright.setup({ on_attach = on_attach })
      lspconfig.intelephense.setup({ on_attach = on_attach })
      lspconfig.html.setup({ on_attach = on_attach })
      lspconfig.cssls.setup({ on_attach = on_attach })
      lspconfig.ts_ls.setup({ on_attach = on_attach })
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
      -- ADDED: ESLint LSP setup
      lspconfig.eslint.setup({
          on_attach = on_attach,
          settings = {
              -- ESLint's 'validate' setting controls which filetypes it applies to.
              -- Add "html" and "css" if you are using ESLint to lint embedded JS/CSS in HTML,
              -- or if you have specific ESLint plugins for HTML/CSS files.
              -- By default, it's usually for JS/TS/JSX/TSX.
              -- Ensure you have an ESLint config file (.eslintrc.*) in your project.
              validate = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
              format = { enable = false }, -- Let conform.nvim handle formatting if you use it for that.
          },
      })
      -- For Odin, if you find an LSP server not covered by Mason, you'd set it up manually here:
      -- lspconfig.odins.setup({
      --    cmd = { "path/to/your/odin-lsp-server" }, -- Replace with the actual path to the Odin LSP server executable
      --    on_attach = on_attach,
      --    filetypes = { "odin" },
      -- })
    end,
  },

  -- --- Autocompletion (nvim-cmp) ---
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter", -- Load only when entering insert mode
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",    -- LSP source for nvim-cmp
      "L3MON4D3/LuaSnip",        -- Snippet engine
      "saadparwaiz1/cmp_luasnip", -- LuaSnip source for nvim-cmp
      "hrsh7th/cmp-buffer",      -- Buffer word completion
      "hrsh7th/cmp-path",        -- File path completion
      "nvim-tree/nvim-web-devicons",
      "onsails/lspkind.nvim",
      "rafamadriz/friendly-snippets", -- For common snippets (HTML/CSS included)
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind");

      -- Load friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        auto_select = true,
        snippet = {
          -- Use LuaSnip to expand snippets
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion
          ["<C-e>"] = cmp.mapping.abort(),          -- Abort completion
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept selected item
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },  -- LSP suggestions
          { name = "luasnip" },    -- Snippet suggestions
          { name = "buffer" },     -- Words from current buffer
          { name = "path" },       -- File paths
        }),

        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = lspkind.cmp_format({
              mode = "symbol",
              maxwidth = 200,
              ellipsis_char = "...",
              before = function(entry, vim_item)
                  if entry.documentation then
                      vim_item.documentation = entry.documentation
                  end

                  if entry.detail then
                      vim_item.menu = vim_item.menu .. " " .. entry.detail
                  end

                  return vim_item
              end,
            }),
        },
      })
    end,
  },
  { "L3MON4D3/LuaSnip" }, -- Standalone snippet engine
  { "rafamadriz/friendly-snippets" }, -- Snippet collection for LuaSnip

  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    config = function ()
        require("lsp_signature").setup({
            bind = true,
            doc_lines = 4,
            floating_window = true,
            hint_enable = true,
            hint_prefix = "",
            handler_opts = {
                -- We'll try to set the border here. 'rounded' is a valid Neovim border style.
                border = "rounded",
            },
            extra_trigger_chars = { "(", ",", ".", "{", "[", ":", " ", "\t", "\n", ")", "}", "]", ";", "?", "!", "=", "/", "\\", "+", "-", "_", "*", "'", "\"", "`" },
            -- Positions relative to the cursor line
            floating_window_above_cur_line = false, -- Set to true to initially place it above the current line
            floating_window_off_x = 400, -- Shift 5 characters to the right
            floating_window_off_y = 40, -- Shift 40 lines up (negative value moves it up)
        })

        -- Set the transparency for the LspSignatureHelp highlight group
        -- This will affect all floating windows using this highlight group.
        -- 0 = opaque, 100 = fully transparent. Setting it to 10 for slight transparency.
        vim.api.nvim_set_hl(10, "LspSignatureHelp", { link = "NormalFloat", blend = 10 })
        vim.api.nvim_set_hl(0, "LspSignatureHelpBorder", { link = "FloatBorder", blend = 10 })
    end,
  },

  -- Auto-closing/renaming HTML/XML tags (Kept, as this is a writing aid, not a formatting tool)
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascriptreact", "typescriptreact", "xml", "php" }, -- Only load for these filetypes
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- Formatter Manager (for manual formatting only)
  {
    "stevearc/conform.nvim",
    lazy = false, -- Load immediately to ensure keymaps are set
    opts = {
      -- Use Mason-installed formatters by default
      formatters_by_ft = {
        html = { "prettier" },    -- You can remove "prettier" if you don't want it even for manual use.
        css = { "prettier" },     -- You can remove "prettier" if you don't want it even for manual use.
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" }, -- Good for your Neovim config files!
        -- Add other languages as needed.
        -- If you want ESLint to *format* via conform, you'd add:
        -- javascript = { "eslint_d" }, -- This would run `eslint --fix` for formatting
        -- typescript = { "eslint_d" },
      },
      -- REMOVED: format_on_save settings. Formatting is now purely manual.
    },
    init = function()
      -- Keymaps to trigger formatting manually
      vim.api.nvim_set_keymap("n", "<leader>fm", "<cmd>ConformFormat<CR>", { desc = "Format current buffer (Conform)" })
      vim.api.nvim_set_keymap("v", "<leader>fm", "<cmd>ConformFormatVisual<CR>", { desc = "Format visual selection (Conform)" })
    end,
  },

  -- --- File Explorer ---
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 15,
        },
        renderer = {
          group_empty = true,
         },
        filters = {
          dotfiles = false,
        },
      })
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    end,
  },

  -- --- Fuzzy Finder ---
  {
    "nvim-telescope/telescope.nvim",
    -- tag = "0.1.6", -- Use the latest stable tag (or remove for latest)
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
    end,
  },

  -- --- Statusline ---
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "tokyonight",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },

  -- --- Git Integration ---
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = true,
      })
    end,
  },

  -- --- Commenting ---
  {
    "numToStr/Comment.nvim",
    opts = {}, -- Default options are fine for basic commenting
    lazy = false, -- Load immediately
  },

  -- --- Which-Key (for discovering keybindings) ---
  {
    "folke/which-key.nvim",
    event = "VeryLazy", -- Load late
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require("which-key").setup({
        -- your configuration comes here
        -- for example, change the mapping leader key to the spacebar
        -- this is the default setting, but it's good to be explicit
        plugins = {
          marks = true, -- shows a list of your marks on ' and `
          registers = true, -- shows your registers on " in NORMAL or VISUAL mode
          spelling = {
            enabled = true, -- enabling this will show "spell" in the command bar
            suggestions = 120, -- how many suggestions should be listed in the popup (default: 20)
          },
          -- the presets below are not enabled by default, you can enable them by setting the key to true
          presets = {
            operators    = true, -- adds help for operators like d, y, ...
            motions      = true, -- adds help for motions like w, e, h, l, ...
            text_objects = true, -- adds help for text objects like iw, aw, as, ...
            windows      = true, -- default command for windows is <C-w>
            nav          = true, -- adds help for navigation commands like H, L, M, ...
            g            = true, -- adds help for g<char> commands
          },
        },
        -- add operators that will be changed to a text object if the next keystroke is a text object
        -- for example "daw" changes to "delete a word"
        operators = {
          -- gc = "Comment",
        },
        -- disable a bunch of keymaps
        ignore_missing = true,
        -- your "your" key will be used by which-key.
        -- this is just an example for your own leader key
        -- if you want to use the default ' ' or '\' you can leave it empty
        -- (the default is just the leader key)
        -- a list of commands that should be colored and which ones not to.
        -- colors are defined in your colorscheme.
        -- 'default' value for "enabled" is false
        -- disable = {
        --    "g",
        --    "z",
        -- },
        -- prefix for show mode (default: "n")
        -- if set to true, it will show the full keymap for the prefix
        show_help = true,
        -- if set to true, it will show the default keymap for the prefix
        -- if there is no user-defined keymap for the prefix
        -- (default: false)
        show_default = false,
        -- if set to true, it will show the full keymap for the prefix
        -- if there is only one keymap for the prefix
        -- (default: false)
        show_single_key = true,
        -- delay before showing the popup (default: 1000ms)
        delay = 0,
        icons = {
          group = "",
          -- plugins = "Plugins", -- can be string or false
          -- mappings = "Mappings",
        },
        -- disable floating window for which-key (default: false)
        -- use a custom floating window for which-key (default: nil)
        -- a function returning a table with `border`, `winblend`, `focusable` (default: nil)
        -- a function to override the default display of which-key's help (default: nil)
        -- for example:
        -- display_fn = function(mappings)
        --    -- use `vim.print` to show the mappings
        -- end,
      })
      -- Example keymap to open which-key with leader prefix
      vim.keymap.set("n", "<leader>", "<cmd>WhichKey '<leader>'<CR>", { silent = true })
    end,
  },

  -- --- Multi-Cursor Support (vim-visual-multi) ---
  -- This plugin enables VSCode-like multi-cursor editing.
  {
    "mg979/vim-visual-multi",
    branch = "master", -- Use the master branch for the latest version
    config = function()
        -- Ensure the plugin is loaded before setting its specific keymaps.
        -- These are the standard "plug" mappings exposed by vim-visual-multi.
        -- If you still want Ctrl-N to add cursors:
        vim.api.nvim_set_keymap('n', '<C-n>', '<Plug>(VM-toggle-cursor)', { noremap = false, silent = true, desc = "VM: Toggle Cursor" })
        vim.api.nvim_set_keymap('i', '<C-n>', '<Plug>(VM-toggle-cursor)', { noremap = false, silent = true, desc = "VM: Toggle Cursor" })
        vim.api.nvim_set_keymap('v', '<C-n>', '<Plug>(VM-toggle-cursor)', { noremap = false, silent = true, desc = "VM: Toggle Cursor" })

        -- Mappings for find/select next/previous occurrence
        vim.api.nvim_set_keymap('n', '<C-m>', '<Plug>(VM-Find-next)', { noremap = false, silent = true, desc = "VM: Find Next Occurrence" })
        vim.api.nvim_set_keymap('v', '<C-m>', '<Plug>(VM-Find-next)', { noremap = false, silent = true, desc = "VM: Find Next Occurrence" })
        vim.api.nvim_set_keymap('n', '<C-p>', '<Plug>(VM-Find-prev)', { noremap = false, silent = true, desc = "VM: Find Previous Occurrence" })
        vim.api.nvim_set_keymap('v', '<C-p>', '<Plug>(VM-Find-prev)', { noremap = false, silent = true, desc = "VM: Find Previous Occurrence" })

        -- Alt+Click functionality:
        -- vim-visual-multi is designed to handle Alt+Click out of the box if your terminal
        -- sends the correct escape codes. No specific Neovim mapping is usually needed here.
        -- If it doesn't work, verify your terminal emulator settings.
        -- E.g., for Alacritty, check `mouse.bindings` and `key_bindings`.
        -- For Kitty, check `map kitty_mod+left_click` etc.

        -- Custom mappings for Ctrl+Del / Ctrl+Shift+Del (approximate)
        -- Note: Actual Ctrl+Del/Shift+Del behavior depends on your terminal sending correct escape codes.
        -- These map to Neovim's 'delete word' and 'delete WORD' behavior.
        -- To delete to end of current word (skipping punctuation)
        vim.api.nvim_set_keymap('i', '<C-Del>', '<C-o>dw', { noremap = false, silent = true, desc = "Delete word forward (Ctrl+Del)" })
        vim.api.nvim_set_keymap('n', '<C-Del>', 'dw', { noremap = false, silent = true, desc = "Delete word forward (Ctrl+Del)" })

        -- To delete to end of current WORD (whitespace separated)
        vim.api.nvim_set_keymap('i', '<C-S-Del>', '<C-o>dW', { noremap = false, silent = true, desc = "Delete WORD forward (Ctrl+Shift+Del)" })
        vim.api.nvim_set_keymap('n', '<C-S-Del>', 'dW', { noremap = false, silent = true, desc = "Delete WORD forward (Ctrl+Shift+Del)" })

        -- If you want delete backward (similar to Ctrl+Backspace):
        -- vim.api.nvim_set_keymap('i', '<C-BS>', '<C-w>', { noremap = false, silent = true, desc = "Delete word backward (Ctrl+Backspace)" })
    end,
  },

  {
    "RRethy/nvim-base16", -- A good dependency if you want to use color schemes from base16
    lazy = false,
    priority = 1000,
  },
}

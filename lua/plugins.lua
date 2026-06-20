return {
  { "nvim-neotest/nvim-nio" },
  { "tpope/vim-sleuth" },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night", -- night, day, storm, moon
        transparent = true, -- transparency
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = "transparent", -- transparent sidebar
          floats = "transparent",   -- transparent floats
        },
        sidebars = { "qf", "help", "terminal", "packer" },
        day_brightness = 0.3,
        hide_inactive_statusline = false,
        dim_inactive = false,
        lualine_bold = false,
        on_colors = function(colors)
          -- Pure black for OLED
          colors.black = "#000000"
          colors.bg = "#000000"
          colors.bg_sidebar = "#000000"
          colors.bg_float = "#000000"
          colors.bg_statusline = "#000000"
          colors.bg_highlight = "#4a4a4a"
          
          -- Dark grayish borders (no white)
          colors.border = "#2a2a2a"
          colors.border_highlight = "#404040"
          
          -- Keep text readable
          colors.fg = "#c0c0c0"
          colors.fg_gutter = "#565f89"
          colors.fg_sidebar = "#c0c0c0"
        end,
        on_highlights = function(hl, colors)
          hl.NvimTreeVisual = { bg = "#030303" }
          -- Border highlights for floating windows
          hl.NormalFloat = { bg = colors.bg_float, fg = colors.fg }
          hl.FloatBorder = { bg = colors.bg_float, fg = colors.border }
          hl.FloatTitle = { bg = colors.bg_float, fg = colors.fg }
          
          -- Window borders
          hl.VertSplit = { fg = colors.border }
          hl.WinSeparator = { fg = colors.border }
          
          -- Popup menus
          hl.Pmenu = { bg = colors.bg_sidebar, fg = colors.fg }
          hl.PmenuSel = { bg = colors.bg_highlight, fg = colors.fg }
          hl.PmenuSbar = { bg = colors.bg_sidebar }
          hl.PmenuThumb = { bg = colors.bg_highlight }
          
          -- Telescope borders
          hl.TelescopeBorder = { fg = colors.border }
          hl.TelescopePromptBorder = { fg = colors.border }
          hl.TelescopeResultsBorder = { fg = colors.border }
          hl.TelescopePreviewBorder = { fg = colors.border }
          
          -- NvimTree borders
          hl.NvimTreeWinSeparator = { fg = colors.border }
          
          -- WhichKey borders
          hl.WhichKeyBorder = { fg = colors.border }
          
          -- LSP floating window
          hl.LspFloatWinNormal = { bg = colors.bg_float, fg = colors.fg }
          hl.LspFloatWinBorder = { fg = colors.border }
          
          -- Fold column
          hl.FoldColumn = { bg = colors.bg, fg = colors.comment }
          
          -- Tab line
          hl.TabLine = { bg = colors.black, fg = colors.comment }
          hl.TabLineSel = { bg = colors.black, fg = colors.fg }
          hl.TabLineFill = { bg = colors.black }
          
          -- Cursor line/column (dark gray instead of bright)
          hl.CursorLine = { bg = colors.bg }
          hl.CursorLineNr = { bg = colors.bg, fg = colors.fg }
          hl.LineNr = { bg = colors.bg, fg = colors.comment }
          
          -- GitSigns (darken the colors)
          hl.GitSignsAdd = { fg = "#2d5a3d" }
          hl.GitSignsChange = { fg = "#4a4a2a" }
          hl.GitSignsDelete = { fg = "#5a2d2d" }
          hl.GitSignsAddNr = { fg = "#2d5a3d" }
          hl.GitSignsChangeNr = { fg = "#4a4a2a" }
          hl.GitSignsDeleteNr = { fg = "#5a2d2d" }
          
          -- Diagnostics (dark grayish colors, still visible on black)
          hl.DiagnosticError = { fg = "#8b4545" }
          hl.DiagnosticWarn = { fg = "#8b7b3a" }
          hl.DiagnosticInfo = { fg = "#4a6a8b" }
          hl.DiagnosticHint = { fg = "#4a7a5a" }
          hl.DiagnosticVirtualTextError = { bg = colors.bg, fg = "#6b3535" }
          hl.DiagnosticVirtualTextWarn = { bg = colors.bg, fg = "#6b5b2a" }
          hl.DiagnosticVirtualTextInfo = { bg = colors.bg, fg = "#3a5a7b" }
          hl.DiagnosticVirtualTextHint = { bg = colors.bg, fg = "#3a6a4a" }
          
          -- Status line
          hl.StatusLine = { bg = colors.black, fg = colors.fg }
          hl.StatusLineNC = { bg = colors.black, fg = colors.comment }
          
          -- Search
          hl.Search = { bg = colors.bg_highlight, fg = colors.fg }
          hl.IncSearch = { bg = colors.bg_highlight, fg = colors.fg }
          
          -- Visual selection
          hl.Visual = { bg = colors.bg_highlight }
          
          -- Flash.nvim highlights
          hl.FlashMatch = { bg = colors.bg_highlight, fg = colors.fg }
          hl.FlashCurrent = { bg = colors.bg_highlight, fg = colors.fg, bold = true }
          hl.FlashBackdrop = { fg = colors.comment }
          hl.FlashLabel = { bg = "#2a2a2a", fg = colors.fg, bold = true }
          
          -- Trouble.nvim highlights
          hl.TroubleNormal = { bg = colors.bg }
          hl.TroubleText = { fg = colors.fg }
          hl.TroubleFile = { fg = colors.fg }
          hl.TroubleCode = { fg = colors.fg }
          
          -- Todo-comments highlights
          hl.TodoFgFIX = { fg = "#8b4545" }
          hl.TodoFgTODO = { fg = "#4a7a5a" }
          hl.TodoFgHACK = { fg = "#8b7b3a" }
          hl.TodoFgWARN = { fg = "#8b7b3a" }
          hl.TodoFgPERF = { fg = "#4a6a8b" }
          hl.TodoFgNOTE = { fg = "#6a4a8b" }
          
          -- Highlight undo
          hl.Undo = { bg = colors.bg_highlight }
          
          -- Neogit (if added later)
          hl.NeogitBranch = { fg = colors.fg }
          hl.NeogitRemote = { fg = colors.fg }
          hl.NeogitHunkHeader = { bg = colors.bg_highlight, fg = colors.fg }
          hl.NeogitHunkHeaderHighlight = { bg = colors.bg_highlight, fg = colors.fg, bold = true }
          
          -- Better indentation lines
          hl.IndentBlanklineChar = { fg = "#2a2a2a" }
          hl.IndentBlanklineContextChar = { fg = "#404040" }
          
          -- Better scrollbar
          hl.Scrollbar = { fg = colors.border }
          hl.ScrollbarHandle = { bg = colors.bg_highlight }
          
          -- Better window separator
          hl.WinSeparator = { fg = colors.border, bold = false }
          
          -- Better folded text
          hl.Folded = { bg = "#121212", fg = colors.comment }
        end,
      })
      vim.cmd.colorscheme("tokyonight-night")
      vim.o.background = "dark"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          -- C/C++/CMake
          "c", "cpp", "cmake", "make",
          -- C3 Language
          "c3",
          -- Go
          "go", "gowork", "gosum",
          -- Rust
          "rust",
          -- Python
          "python",
          -- TypeScript/JavaScript/React
          "typescript", "javascript", "tsx", "jsx",
          -- Web (HTML/CSS/XML)
          "html", "css", "xml",
          -- PHP
          "php",
          -- Lua
          "lua",
          -- Bash
          "bash",
          -- Odin
          "odin",
          -- Zig
          "zig",
          -- SQL
          "sql",
          -- Go Template
          "gotemplate",
          -- Vue
          "vue",
          -- Svelte
          "svelte",
          -- TOML/JSON/YAML
          "toml", "json", "yaml",
          -- Markdown
          "markdown", "markdown_inline",
          -- Git
          "git_config", "git_rebase", "gitcommit", "gitignore",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  { "williamboman/mason.nvim", config = function() require("mason").setup() end },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- C/C++/CMake
          "clangd", "cmake",

          -- Go
          "gopls",
          -- Rust
          "rust_analyzer",
          -- Python
          "pyright",
          -- TypeScript/JavaScript
          "ts_ls", "eslint", "denols",
          -- PHP
          "intelephense",
          -- Web (HTML/CSS)
          "html", "cssls",
          -- Lua
          "lua_ls",
          -- Bash
          "bashls",
          -- Odin
          "ols",
          -- Zig
          "zls",
          -- SQL
          "sqls",
          -- OmniSharp (C#)
          "omnisharp",
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
    config = function()
      local on_attach = function(client, bufnr)
        local buf_set_keymap = vim.api.nvim_buf_set_keymap
        local opts = { noremap = true, silent = true }

        buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
        buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
        buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
        buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
        buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.set_loclist()<CR>", opts)
        
        -- Clangd specific: switch source/header
        if client.name == "clangd" then
          buf_set_keymap(bufnr, "n", "<leader>gh", "<cmd>ClangdSwitchSourceHeader<CR>", opts)
        end
      end

      -- Setup LSP servers using vim.lsp.config (Neovim 0.11+)
      local servers = {
        "rust_analyzer","gopls","clangd","pyright","intelephense","ts_ls",
        "lua_ls","html","cssls","eslint","denols","cmake","omnisharp","bashls","zls","ols"
      }
      for _, lsp in ipairs(servers) do
        vim.lsp.config(lsp, { on_attach = on_attach })
      end

      -- Clangd specific settings - disable auto-import and enable diagnostics
      vim.lsp.config("clangd", {
        on_attach = on_attach,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=never",  -- Disable auto-import
          "--header-insertion-decorators=0",
          "--limit-results=100",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--log=verbose",
        },
        settings = {
          clangd = {
            diagnostics = {
              underline = true,
              severity = {
                min = "Warning",
              },
            },
            inlayHints = {
              parameterNames = true,
              deducedTypes = true,
            },
          },
        },
      })

      -- CMake settings
      vim.lsp.config("cmake", {
        on_attach = on_attach,
        settings = {
          cmake = {
            buildDirectory = "build",
          },
        },
      })

      -- Go settings
      vim.lsp.config("gopls", {
        on_attach = on_attach,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      })

      -- TypeScript/JavaScript settings
      vim.lsp.config("ts_ls", {
        on_attach = on_attach,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      })

      -- Python settings
      vim.lsp.config("pyright", {
        on_attach = on_attach,
        settings = {
          python = {
            analysis = {
              autoImportCompletions = false,
              typeCheckingMode = "basic",
            },
          },
        },
      })

      -- PHP settings
      vim.lsp.config("intelephense", {
        on_attach = on_attach,
        settings = {
          intelephense = {
            files = {
              maxSize = 1000000,
            },
          },
        },
      })

      -- Lua specific settings
      vim.lsp.config("lua_ls", {
        on_attach = on_attach,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      -- HTML/CSS settings
      vim.lsp.config("html", {
        on_attach = on_attach,
        settings = {
          html = {
            format = {
              wrapLineLength = 120,
            },
          },
        },
      })

      vim.lsp.config("cssls", {
        on_attach = on_attach,
        settings = {
          css = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
            },
          },
        },
      })

      -- ESLint settings
      vim.lsp.config("eslint", {
        on_attach = on_attach,
        settings = {
          codeActionOnSave = {
            enable = false,
          },
        },
      })

      -- Denols settings
      vim.lsp.config("denols", {
        on_attach = on_attach,
        settings = {
          deno = {
            enable = true,
            lint = true,
          },
        },
      })

      -- Odin/ols settings
      vim.lsp.config("ols", {
        on_attach = on_attach,
        settings = {
          ols = {
            checkForAnalysis = true,
          },
        },
      })

      -- Zig settings (zls)
      vim.lsp.config("zls", {
        on_attach = on_attach,
        settings = {
          zls = {
            enableAutofix = true,
          },
        },
      })

      -- SQL settings
      vim.lsp.config("sqls", {
        on_attach = on_attach,
        settings = {
          sqls = {
            connections = {},
          },
        },
      })

      -- C3 Language settings
      vim.lsp.config("c3-lsp", {
        on_attach = on_attach,
        settings = {
          c3 = {
            lsp = {
              diagnostics = true,
              inlayHints = true,
            },
          },
        },
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp","L3MON4D3/LuaSnip","saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer","hrsh7th/cmp-path","nvim-tree/nvim-web-devicons",
      "onsails/lspkind.nvim","rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      require("luasnip.loaders.from_vscode").lazy_load()
      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          fields = { "kind","abbr","menu" },
          format = lspkind.cmp_format({ mode = "symbol", maxwidth = 200 }),
        },
      })
    end,
  },

  { "L3MON4D3/LuaSnip" },
  { "rafamadriz/friendly-snippets" },

  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    config = function()
      require("lsp_signature").setup({ bind=true, doc_lines=4, floating_window=true, hint_enable=true, hint_prefix="", handler_opts={border="rounded"} })
    end,
  },

  --[[
  {
    "windwp/nvim-ts-autotag",
    ft = { "html","javascriptreact","typescriptreact","xml","php" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function() require("nvim-ts-autotag").setup() end,
  },
  ]]--

  {
    "stevearc/conform.nvim",
    lazy = false,
    opts = {
      formatters_by_ft = {
        html = {"prettier"}, css = {"prettier"}, javascript = {"prettier"},
        typescript = {"prettier"}, json = {"prettier"}, yaml = {"prettier"},
        markdown = {"prettier"}, lua = {"stylua"}, python = {"black"},
        go = {"gofmt"}, rust = {"rustfmt"}, php = {"php-cs-fixer"},
        sh = {"shfmt"}, bash = {"shfmt"}
      }
    },

  },

  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 28,
          relativenumber = false,
          float = {
            enable = false,
            quit_on_focus_loss = true,
            open_win_config = {
              relative = "editor",
              border = "single",
              width = 30,
              height = 30,
              row = 1,
              col = 1,
            },
          },
        },
        renderer = {
          group_empty = true,
          root_folder_label = ":~:s?$?/..?",
          highlight_git = true,
          indent_markers = {
            enable = true,
            inline_arrows = true,
            icons = {
              corner = "└",
              edge = "│",
              item = "│",
              bottom = "─",
              none = " ",
            },
          },
        },
        filters = {
          dotfiles = false,
        },
        update_focused_file = {
          enable = true,
          update_cwd = false,
          ignore_list = {},
        },
        actions = {
          open_file = {
            quit_on_open = false,
            resize_window = true,
          },
        },
        git = {
          enable = true,
          ignore = false,
          timeout = 500,
        },
        -- This ensures the tree opens at the directory of the current file
        tab = {
          sync = {
            open = false,
            close = false,
          },
        },
        -- OLED friendly colors
        -- Note: The actual colors are handled by tokyonight setup
        -- but we can set some structural colors here
      })
      
      -- Auto-open NvimTree at start if width > 500
      local function open_nvim_tree()
        -- Only open if window width is greater than 500
        if vim.fn.winwidth(0) > 500 then
          local api = require("nvim-tree.api")
          api.tree.open()
        end
      end
      
      -- Auto-open on startup
      vim.api.nvim_create_autocmd("VimEnter", {
        pattern = "*",
        callback = function()
          -- Delay to ensure all plugins are loaded
          vim.defer_fn(open_nvim_tree, 100)
        end,
        once = true,
      })
      
      -- Auto-expand src/ directory after NvimTree is opened
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*",
        callback = function()
          local view = require("nvim-tree.view")
          if view.is_visible() then
            local api = require("nvim-tree.api")
            -- Find and expand src/ directory only (direct child only)
            local current_nodes = api.tree.get_nodes()
            if current_nodes then
              for _, node in ipairs(current_nodes) do
                if node.name == "src" and node.type == "directory" then
                  api.node.expand(node)
                  break
                end
              end
            end
          end
        end,
        once = true,
      })
      
      -- Open default files when opening a directory
      vim.api.nvim_create_autocmd("VimEnter", {
        pattern = "*",
        callback = function()
          -- Check if we're opening a directory
          local first_arg = vim.fn.argv(0)
          if first_arg ~= "" and vim.fn.isdirectory(first_arg) == 1 then
            -- Change to that directory
            vim.cmd("cd " .. vim.fn.fnameescape(first_arg))
            local files_to_try = {
              "index.lua", "main.lua", "app.lua", "src/index.lua", "src/main.lua", "src/app.lua",
              "index.js", "main.js", "app.js", "src/index.js", "src/main.js", "src/app.js",
              "index.ts", "main.ts", "app.ts", "src/index.ts", "src/main.ts", "src/app.ts",
              "index.py", "main.py", "app.py", "src/index.py", "src/main.py", "src/app.py",
              "index.go", "main.go", "app.go", "src/index.go", "src/main.go", "src/app.go",
              "index.rs", "main.rs", "app.rs", "src/index.rs", "src/main.rs", "src/app.rs",
              "index", "main", "app", "src/index", "src/main", "src/app",
            }
            for _, file in ipairs(files_to_try) do
              if vim.fn.filereadable(file) == 1 then
                vim.cmd("edit " .. file)
                break
              end
            end
          end
        end,
        once = true,
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- Keymaps moved to keymaps.lua
    end,
  },

  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    config = function()
      require("telescope").load_extension("live_grep_args")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      -- Catppuccin colors for mode indicator foreground only
      local catppuccin_colors = {
        rosewater = "#f5e0dc",
        flamingo = "#f2cdcd",
        pink = "#f5c2e7",
        mauve = "#cba6f7",
        red = "#f38ba8",
        maroon = "#eba0ac",
        peach = "#fab387",
        yellow = "#f9e2af",
        green = "#a6e3a1",
        teal = "#94e2d5",
        sky = "#89dceb",
        sapphire = "#74c7ec",
        blue = "#89b4fa",
        lavender = "#b4befe",
        text = "#cdd6f4",
        subtext1 = "#bac2de",
        subtext0 = "#a6adc8",
        overlay2 = "#9399b2",
        overlay1 = "#7f849c",
        overlay0 = "#6c7086",
        surface2 = "#585b70",
        surface1 = "#45475a",
        surface0 = "#313244",
        base = "#1e1e2e",
        mantle = "#181825",
        crust = "#11111b",
      }
      
      local colors = {
        black = "#000000",
        fg = "#c0c0c0",
        gray = "#2a2a2a",
        comment = "#565f89",
        blue = "#7aa2f7",
        green = "#9ece6a",
        yellow = "#e0af68",
        red = "#f7768e",
        cyan = "#7dcfff",
        magenta = "#bb9af7",
      }
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = {
            -- Mode indicator (lualine_a) uses Catppuccin colors for foreground only
            -- Background remains pure black for OLED
            normal = { 
              a = { bg = colors.black, fg = catppuccin_colors.blue },
              b = { bg = colors.black, fg = colors.fg },
              c = { bg = colors.black, fg = colors.fg } 
            },
            insert = { 
              a = { bg = colors.black, fg = catppuccin_colors.green },
              b = { bg = colors.black, fg = colors.fg },
              c = { bg = colors.black, fg = colors.fg } 
            },
            visual = { 
              a = { bg = colors.black, fg = catppuccin_colors.mauve },
              b = { bg = colors.black, fg = colors.fg },
              c = { bg = colors.black, fg = colors.fg } 
            },
            replace = { 
              a = { bg = colors.black, fg = catppuccin_colors.red },
              b = { bg = colors.black, fg = colors.fg },
              c = { bg = colors.black, fg = colors.fg } 
            },
            command = { 
              a = { bg = colors.black, fg = catppuccin_colors.peach },
              b = { bg = colors.black, fg = colors.fg },
              c = { bg = colors.black, fg = colors.fg } 
            },
            inactive = { 
              a = { bg = colors.black, fg = catppuccin_colors.surface1 },
              b = { bg = colors.black, fg = colors.comment },
              c = { bg = colors.black, fg = colors.comment } 
            },
          },
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {},
          always_divide_middle = true,
          globalstatus = false,
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
        tabline = {},
        extensions = {},
      })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 0,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
      })
    end,
  },

  { "numToStr/Comment.nvim", opts={}, lazy=false },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function() vim.o.timeout=true; vim.o.timeoutlen=300 end,
    config = function()
      require("which-key").setup({})
      -- Keymap moved to keymaps.lua
    end,
  },

  {
    "mg979/vim-visual-multi",
    branch="master",
    config = function()
      vim.api.nvim_set_keymap('n','<C-n>','<Plug>(VM-toggle-cursor)',{})
      vim.api.nvim_set_keymap('i','<C-n>','<Plug>(VM-toggle-cursor)',{})
      vim.api.nvim_set_keymap('v','<C-n>','<Plug>(VM-toggle-cursor)',{})
      vim.api.nvim_set_keymap('n','<C-m>','<Plug>(VM-Find-next)',{})
      vim.api.nvim_set_keymap('v','<C-m>','<Plug>(VM-Find-next)',{})
      vim.api.nvim_set_keymap('n','<C-p>','<Plug>(VM-Find-prev)',{})
      vim.api.nvim_set_keymap('v','<C-p>','<Plug>(VM-Find-prev)',{})
      vim.api.nvim_set_keymap('i','<C-Del>','<C-o>dw',{})
      vim.api.nvim_set_keymap('n','<C-Del>','dw',{})
      vim.api.nvim_set_keymap('i','<C-S-Del>','<C-o>dW',{})
      vim.api.nvim_set_keymap('n','<C-S-Del>','dW',{})
    end,
  },

  { "RRethy/nvim-base16", lazy=false, priority=1000 },

  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      
      -- GDB configuration
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--quiet", "--interpreter=dap" },
      }
      
      -- LLDB configuration
      dap.adapters.lldb = {
        type = "executable",
        command = "lldb-vscode",
        name = "lldb",
      }
      
      -- C++ configuration with GDB
      dap.configurations.cpp = {
        {
          name = "Launch (GDB)",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
          externalConsole = false,
        },
        {
          name = "Launch (LLDB)",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
        {
          name = "Attach (GDB)",
          type = "gdb",
          request = "attach",
          processId = function()
            return require("dap.utils").pick_process({ filter = ".*" })
          end,
        },
      }
      
      -- C configuration (same as C++)
      dap.configurations.c = dap.configurations.cpp
      
      -- Rust configuration
      dap.configurations.rust = dap.configurations.cpp
      
      -- Keymaps moved to keymaps.lua
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies={ "mfussenegger/nvim-dap" },
    config=function() require("dapui").setup() end,
  },
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({})
    end,
  },
  {
    "p00f/clangd_extensions.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("clangd_extensions").setup({
        inlay_hints = {
          inline = true,
          only_current_line = false,
          show_parameter_hints = true,
          parameter_hints_prefix = " ",
          other_hints_prefix = " ",
          max_len_align = false,
          max_len_align_padding = 1,
          right_align = false,
          right_align_padding = 7,
          highlight = "Comment",
          priority = 100,
        },
        ast = {
          role_icons = {
            type = "",
            declaration = "",
            expression = "",
            specifier = "",
            statement = "",
            ["template argument"] = "",
          },
          kind_icons = {
            Compound = "",
            Namespace = "",
            Enum = "",
            Struct = "",
            Class = "",
            Interface = "",
            TypeAlias = "",
            EnumMember = "",
            Field = "",
            Property = "",
            Function = "",
            Variable = "",
            Constant = "",
            Parameter = "",
            Macro = "",
          },
        },
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",  -- Show buffers instead of tabs
          style_preset = {
            require("bufferline").style_preset.minimal,
          },
          themable = true,
          show_buffer_close_icons = false,
          show_close_icon = false,
          diagnostics = "nvim_lsp",
          separator_style = "slant",
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "left",
              separator = true,
            },
          },
        },
        highlights = {
          fill = { bg = "#000000" },
          background = { bg = "#000000" },
          tab = { bg = "#000000", fg = "#565f89" },
          tab_close = { bg = "#000000" },
          close_button = { bg = "#000000" },
          separator = { fg = "#2a2a2a" },
          separator_visible = { fg = "#2a2a2a" },
          separator_selected = { fg = "#2a2a2a" },
          offset_separator = { fg = "#2a2a2a" },
          duplicate = { bg = "#000000", fg = "#565f89" },
          modified = { bg = "#000000", fg = "#8b7b3a" },
          indicator_visible = { bg = "#000000" },
          pick = { bg = "#000000", fg = "#7aa2f7", bold = true },
          buffer = { bg = "#000000", fg = "#c0c0c0" },
          buffer_visible = { bg = "#000000", fg = "#565f89" },
          buffer_selected = { bg = "#000000", fg = "#c0c0c0", bold = true },
          numbers = { bg = "#000000", fg = "#565f89" },
          numbers_visible = { bg = "#000000", fg = "#565f89" },
          numbers_selected = { bg = "#000000", fg = "#c0c0c0", bold = true },
          diagnostic = { bg = "#000000" },
          diagnostic_visible = { bg = "#000000" },
          diagnostic_selected = { bg = "#000000", bold = true },
          info = { bg = "#000000", fg = "#4a6a8b" },
          info_visible = { bg = "#000000", fg = "#4a6a8b" },
          info_selected = { bg = "#000000", fg = "#4a6a8b", bold = true },
          warning = { bg = "#000000", fg = "#8b7b3a" },
          warning_visible = { bg = "#000000", fg = "#8b7b3a" },
          warning_selected = { bg = "#000000", fg = "#8b7b3a", bold = true },
          error = { bg = "#000000", fg = "#8b4545" },
          error_visible = { bg = "#000000", fg = "#8b4545" },
          error_selected = { bg = "#000000", fg = "#8b4545", bold = true },
        },
      })
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end
      })
    end,
  },

  -- Additional useful plugins
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  {
    "tpope/vim-fugitive",
    lazy = false,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({
        position = "bottom",
        height = 10,
        width = 50,
        icons = true,
        mode = "workspace_diagnostics",
        fold_open = "",
        fold_closed = "",
        indent_lines = true,
        auto_open = false,
        auto_close = false,
        auto_preview = true,
        auto_fold = false,
        auto_jump = { "lsp_definitions" },
      })
      -- Keymaps moved to keymaps.lua
    end,
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({
        signs = true,
        sign_priority = 8,
        keywords = {
          FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        },
        merge_keywords = true,
        highlight = {
          before = "",
          keyword = "wide",
          after = "fg",
          pattern = [[.*<(KEYWORDS)\s*:]],
          comments_only = true,
          max_line_length = 0,
          exclude = {},
        },
        colors = {
          error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
          warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
          info = { "DiagnosticInfo", "#2563EB" },
          hint = { "DiagnosticHint", "#10B981" },
          default = { "Identifier", "#7C3AED" },
        },
        search = {
          pattern = [[\b(KEYWORDS):]],
        },
      })
      vim.keymap.set("n", "<leader>td", "<cmd>TodoTrouble<CR>", { desc = "Todo Trouble" })
      vim.keymap.set("n", "<leader>tt", "<cmd>TodoTelescope<CR>", { desc = "Todo Telescope" })
    end,
  },

  {
    "folke/flash.nvim",
    enabled = false,
    event = "VeryLazy",
    config = function()
      require("flash").setup({
        search = {
          enabled = false,
        },
        labels = "asdfghjklqwertyuiopzxcvbnm",
        search = {
          forward = true,
          wrap = true,
          mode = "search",
          incremental = false,
        },
        jump = {
          autojump = true,
        },
        label = {
          uppercase = false,
          rainbow = {
            enabled = true,
            shade = 5,
          },
        },
        highlight = {
          backdrop = true,
          matches = true,
          groups = {
            match = "FlashMatch",
            current = "FlashCurrent",
            backdrop = "FlashBackdrop",
            label = "FlashLabel",
          },
        },
        modes = {
          search = {
            enabled = true,
            highlight = { backdrop = false },
            jump = { history = true, register = true, nohlsearch = true },
            search = { incremental = true },
          },
          char = {
            enabled = true,
            config = function(opts)
              opts.autohide = vim.fn.mode(true):find "no"
            end,
            highlight = { backdrop = false },
            jump = { register = false },
          },
        },
      })
      vim.keymap.set({ "n", "x", "o" }, "s", function()
        require("flash").jump()
      end, { desc = "Flash" })
      vim.keymap.set({ "n", "x", "o" }, "S", function()
        require("flash").treesitter()
      end, { desc = "Flash Treesitter" })
      vim.keymap.set("o", "r", function()
        require("flash").remote()
      end, { desc = "Remote Flash" })
      vim.keymap.set({ "n", "x", "o" }, "R", function()
        require("flash").treesitter_search()
      end, { desc = "Treesitter Search" })
      vim.keymap.set("c", "<c-s>", function()
        require("flash").toggle()
      end, { desc = "Toggle Flash Search" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
          java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
          offset = 0,
          end_key = "$",
          keys = "qwertyuiopzxcvbnm",
          check_comma = true,
          highlight = "PmenuSel",
          highlight_grey = "Comment",
        },
      })
    end,
  },

  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("hlslens").setup()
      vim.keymap.set("n", "n", "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>", {})
      vim.keymap.set("n", "N", "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>", {})
      vim.keymap.set("n", "*", "*<Cmd>lua require('hlslens').start()<CR>", {})
      vim.keymap.set("n", "#", "#<Cmd>lua require('hlslens').start()<CR>", {})
      vim.keymap.set("n", "g*", "g*<Cmd>lua require('hlslens').start()<CR>", {})
      vim.keymap.set("n", "g#", "g#<Cmd>lua require('hlslens').start()<CR>", {})
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "*",
      }, {
        RGB = true,
        RRGGBB = true,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        mode = "background",
      })
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",
          smart_indent_cap = true,
        },
        whitespace = {
          remove_blankline_trail = true,
        },
        scope = {
          enabled = true,
          char = "┃",
          show_start = false,
          show_end = false,
          injected_languages = true,
          highlight = { "Function", "Label" },
          priority = 50,
        },
        exclude = {
          filetypes = {
            "help",
            "startify",
            "aerial",
            "alpha",
            "dashboard",
            "lazy",
            "neogitstatus",
            "NvimTree",
            "neo-tree",
            "Trouble",
          },
          buftypes = {
            "terminal",
            "nofile",
            "quickfix",
            "prompt",
          },
        },
      })
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
    end,
  },

  {
    "3rd/image.nvim",
    config = function()
      require("image").setup({
        backend = "kitty",
        kitty_method = "normal",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "markdown", "vimwiki" },
          },
          neorg = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "norg" },
          },
          html = {
            enabled = false,
          },
          css = {
            enabled = false,
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = false,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        editor_only_render_when_focused = false,
        tmux_show_only_in_active_window = false,
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
      })
    end,
  },
}

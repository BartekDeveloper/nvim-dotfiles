return {
  { "nvim-neotest/nvim-nio" },
  { "tpope/vim-sleuth" },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight-night")
      vim.o.background = "dark"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c","cpp","python","rust","go","lua","php","html","css",
          "javascript","typescript","odin","toml","bash","make","cmake",
          "vue","svelte"
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
          "rust_analyzer","gopls","clangd","pyright","intelephense","tsserver",
          "lua_ls","html","cssls","eslint","denols","cmake","omnisharp","bashls"
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
    config = function()
      local lspconfig = require("lspconfig")
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
      end

      -- Setup LSP servers
      local servers = {
        "rust_analyzer","gopls","clangd","pyright","intelephense","tsserver",
        "lua_ls","html","cssls","eslint","denols","cmake","omnisharp","bashls"
      }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({ on_attach = on_attach })
      end

      -- Lua specific settings
      lspconfig.lua_ls.setup({
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

  {
    "windwp/nvim-ts-autotag",
    ft = { "html","javascriptreact","typescriptreact","xml","php" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function() require("nvim-ts-autotag").setup() end,
  },

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
    init = function()
      vim.api.nvim_set_keymap("n","<leader>fm","<cmd>ConformFormat<CR>",{})
      vim.api.nvim_set_keymap("v","<leader>fm","<cmd>ConformFormatVisual<CR>",{})
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        sort_by="case_sensitive", view={width=15}, renderer={group_empty=true}, filters={dotfiles=false}
      })
      vim.keymap.set("n","<leader>e",":NvimTreeToggle<CR>",{})
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local b = require("telescope.builtin")
      vim.keymap.set("n","<leader>ff",b.find_files,{})
      vim.keymap.set("n","<leader>fg",b.live_grep,{})
      vim.keymap.set("n","<leader>fb",b.buffers,{})
      vim.keymap.set("n","<leader>fh",b.help_tags,{})
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = { icons_enabled=true, theme="tokyonight", component_separators={left="",right=""}, section_separators={left="",right=""} },
        sections = { lualine_a={"mode"}, lualine_b={"branch","diff","diagnostics"}, lualine_c={"filename"}, lualine_x={"encoding","fileformat","filetype"}, lualine_y={"progress"}, lualine_z={"location"} },
        inactive_sections = { lualine_a={}, lualine_b={}, lualine_c={"filename"}, lualine_x={"location"}, lualine_y={}, lualine_z={} },
      })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({ current_line_blame=true })
    end,
  },

  { "numToStr/Comment.nvim", opts={}, lazy=false },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function() vim.o.timeout=true; vim.o.timeoutlen=300 end,
    config = function()
      require("which-key").setup({})
      vim.keymap.set("n","<leader>","<cmd>WhichKey '<leader>'<CR>",{})
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
      local dap=require("dap")
      dap.adapters.lldb={type='executable',command='lldb-vscode',name='lldb'}
      dap.configurations.cpp={{name='Launch',type='lldb',request='launch',program=function() return vim.fn.input('Path to executable: ',vim.fn.getcwd()..'/', 'file') end,cwd='${workspaceFolder}',stopOnEntry=false,args={}}}
      dap.configurations.c=dap.configurations.cpp
      dap.configurations.rust=dap.configurations.cpp
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies={ "mfussenegger/nvim-dap" },
    config=function() require("dapui").setup() end,
  },
}

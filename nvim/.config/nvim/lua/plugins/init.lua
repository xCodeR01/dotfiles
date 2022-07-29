vim.cmd "packadd packer.nvim"

local function plugins(use)
  -- core stuff
  use "wbthomason/packer.nvim"
  use { "nvim-lua/plenary.nvim", module = "plenary" }
  -- use { "nvim-lua/popup.nvim", module = "popup" }
  use {
    "rmagatti/auto-session",
    config = function()
      require("plugins.configs.others").auto_session()
    end,
  }
  use {
    "lewis6991/impatient.nvim",
    config = function()
      require("impatient").enable_profile()
    end,
  }
  use {
    "folke/which-key.nvim",
    module = "which-key",
    config = function()
      require "plugins.configs.whichkey"
    end,
  }

  -- telescope stuff
  use {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
    config = function()
      require "plugins.configs.telescope"
    end,
  }
  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
    run = "make",
  }

  -- treesitter stuff
  use {
    "nvim-treesitter/nvim-treesitter",
    module = "nvim-treesitter",
    setup = function()
      require("core.lazy_load").on_file_open "nvim-treesitter"
    end,
    cmd = require("core.lazy_load").treesitter_cmds,
    run = ":TSUpdate",
    config = function()
      require "plugins.configs.treesitter"
    end,
  }
  use {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufReadPost",
  }
  use {
    "windwp/nvim-ts-autotag",
    after = "nvim-treesitter",
  }

  -- cmp and snippets
  use { "rafamadriz/friendly-snippets", module = "cmp_nvim_lsp", event = "InsertEnter" }
  use {
    "L3MON4D3/LuaSnip",
    after = "friendly-snippets",
    config = function()
      require("plugins.configs.others").luasnip()
    end,
  }
  use {
    "hrsh7th/nvim-cmp",
    after = "LuaSnip",
    config = function()
      require "plugins.configs.cmp"
    end,
  }
  use { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" }
  use { "hrsh7th/cmp-nvim-lua", after = "cmp_luasnip" }
  use { "hrsh7th/cmp-nvim-lsp", after = "cmp-nvim-lua" }
  use { "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" }
  use { "hrsh7th/cmp-path", after = "cmp-buffer" }

  -- lsp and debug stuff
  use {
    "williamboman/mason.nvim",
    -- issue with lazyloading as this plugin also loads its env
    -- cmd = { "Mason" },
    config = function()
      require "plugins.configs.mason"
    end,
  }
  use {
    "neovim/nvim-lspconfig",
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "nvim-lspconfig"
    end,
    config = function()
      require "plugins.lsp.lspconfig"
    end,
  }
  use { "b0o/schemastore.nvim" }
  use {
    "glepnir/lspsaga.nvim",
    branch = "main",
    after = "nvim-lspconfig",
    config = function()
      require "plugins.lsp.lspsaga"
    end,
  }
  use {
    "jose-elias-alvarez/null-ls.nvim",
    after = "nvim-lspconfig",
    config = function()
      require "plugins.lsp.null-ls"
    end,
  }
  use {
    "mfussenegger/nvim-dap",
    module = "dap",
    config = function()
      require "plugins.dap.dapconfig"
    end,
  }
  use {
    "rcarriga/nvim-dap-ui",
    after = "nvim-dap",
    config = function()
      require "plugins.dap.dapui"
    end,
  }

  -- ide stuff
  use {
    "goolord/alpha-nvim",
    config = function()
      require "plugins.configs.alpha"
    end,
  }
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require "plugins.configs.project"
    end,
  }
  use {
    "kyazdani42/nvim-tree.lua",
    ft = "alpha",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require "plugins.configs.nvim-tree"
    end,
  }
  use {
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    config = function()
      require("plugins.configs.others").devicons()
    end,
  }
  use {
    "nvim-lualine/lualine.nvim",
    config = function()
      require "plugins.configs.lualine"
    end,
  }
  use {
    "akinsho/bufferline.nvim",
    branch = "main",
    event = "BufWinEnter",
    config = function()
      require "plugins.configs.bufferline"
    end,
    requires = { "moll/vim-bbye" },
  }
  use {
    "lewis6991/gitsigns.nvim",
    ft = "gitcommit",
    setup = function()
      require("core.lazy_load").gitsigns()
    end,
    config = function()
      require "plugins.configs.gitsigns"
    end,
  }
  use {
    "lukas-reineke/indent-blankline.nvim",
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "indent-blankline.nvim"
    end,
    config = function()
      require "plugins.configs.blankline"
    end,
    disable = true,
  }
  use {
    "numToStr/Comment.nvim",
    module = "Comment",
    keys = { "gc", "gb" },
    config = function()
      require "plugins.configs.comment"
    end,
  }
  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require "plugins.configs.autopairs"
    end,
  }
  use {
    "RRethy/vim-illuminate",
    config = function()
      require("plugins.configs.others").illuminate()
    end,
  }
  use {
    "norcalli/nvim-colorizer.lua",
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "nvim-colorizer.lua"
    end,
    config = function()
      require("plugins.configs.others").colorizer()
    end,
  }
  use {
    "akinsho/toggleterm.nvim",
    tag = "v1.*",
    event = "BufWinEnter",
    config = function()
      require "plugins.configs.toggleterm"
    end,
  }

  -- colorschemes
  use {
    "navarasu/onedark.nvim",
    config = function()
      require("plugins.configs.others").onedark()
    end,
    disable = true,
  }
  use {
    "morhetz/gruvbox",
    config = function()
      vim.cmd [[colorscheme gruvbox]]
    end,
    disable = false,
  }

  -- extra stuff
  use {
    "ggandor/lightspeed.nvim",
    config = function()
      require("plugins.configs.others").lightspeed()
    end,
  }
  use {
    "github/copilot.vim",
    event = "InsertEnter",
    cmd = { "Copilot" },
    config = function()
      require("plugins.configs.others").copilot()
    end,
  }
end

require("core.packer").run(plugins)

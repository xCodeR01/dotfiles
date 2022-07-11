vim.cmd "packadd packer.nvim"

local function plugins(use)
  use "wbthomason/packer.nvim"
  use { "nvim-lua/plenary.nvim", module = "plenary" }
  use { "nvim-lua/popup.nvim", module = "popup" }
  use {
    "lewis6991/impatient.nvim",
    config = function()
      require("impatient").enable_profile()
    end,
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

  -- lsp and dap
  use {
    "williamboman/nvim-lsp-installer",
    opt = true,
    cmd = require("core.lazy_load").lsp_cmds,
    setup = function()
      require("core.lazy_load").on_file_open "nvim-lsp-installer"
    end,
  }
  use {
    "neovim/nvim-lspconfig",
    after = "nvim-lsp-installer",
    module = "lspconfig",
    config = function()
      require "plugins.configs.lsp_installer"
      require "plugins.configs.lspconfig"
    end,
  }
  use {
    "glepnir/lspsaga.nvim",
    after = "nvim-lspconfig",
    config = function()
      require "plugins.configs.lspsaga"
    end,
  }
  use {
    "RRethy/vim-illuminate",
    after = "nvim-lsp-installer",
    config = function()
      require("plugins.configs.others").illuminate()
    end,
  }
  use {
    "tamago324/nlsp-settings.nvim",
    after = "nvim-lsp-installer",
    config = function()
      require "plugins.configs.nlsp-settings"
    end,
  }
  use {
    "jose-elias-alvarez/null-ls.nvim",
    after = "nvim-lsp-installer",
    config = function()
      require "plugins.configs.null-ls"
    end,
  }
  use { "mfussenegger/nvim-dap", after = "nvim-lspconfig" }
  use {
    "ravenxrz/DAPInstall.nvim",
    after = "nvim-dap",
    config = function()
      require("plugins.configs.dap").dap_install()
    end,
  }
  use {
    "rcarriga/nvim-dap-ui",
    after = "nvim-dap",
    config = function()
      require("plugins.configs.dap").dapui()
    end,
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
  use { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" }
  use {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascriptreact", "typescriptreact" },
    after = "nvim-treesitter",
  }
  use { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" }

  -- searching stuff with telescope
  use {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    requires = {
      "nvim-telescope/telescope-media-files.nvim",
    },
    config = function()
      require "plugins.configs.telescope"
    end,
  }
  use {
    "ahmedkhalf/project.nvim",
    after = "telescope.nvim",
    config = function()
      require "plugins.configs.project"
    end,
  }

  -- ide stuff
  use {
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    config = function()
      require("plugins.configs.others").devicons()
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
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require("plugins.configs.others").autopairs()
    end,
  }
  use {
    "numToStr/Comment.nvim",
    module = "Comment",
    keys = { "gc", "gb" },
    config = function()
      require("plugins.configs.others").comment()
    end,
  }
  use {
    "lewis6991/gitsigns.nvim",
    opt = true,
    setup = function()
      require("core.lazy_load").gitsigns()
    end,
    config = function()
      require("plugins.configs.others").gitsigns()
    end,
  }
  use {
    "lukas-reineke/indent-blankline.nvim",
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "indent-blankline.nvim"
    end,
    config = function()
      require("plugins.configs.others").blankline()
    end,
  }
  use {
    "NvChad/nvim-colorizer.lua",
    opt = true,
    setup = function()
      require("core.lazy_load").colorizer()
    end,
    config = function()
      require("plugins.configs.others").colorizer()
    end,
  }
  use {
    "goolord/alpha-nvim",
    config = function()
      require "plugins.configs.alpha"
    end,
  }
  use {
    "akinsho/bufferline.nvim",
    requires = { "moll/vim-bbye" },
    setup = function()
      require("core.lazy_load").bufferline()
    end,
    config = function()
      require "plugins.configs.bufferline"
    end,
  }
  use {
    "akinsho/toggleterm.nvim",
    tag = 'v1.*',
    cmd = "ToggleTerm",
    config = function()
      require "plugins.configs.toggleterm"
    end,
  }
  use {
    "nvim-lualine/lualine.nvim",
    config = function()
      require "plugins.configs.lualine"
    end,
  }
  use {
    "ggandor/lightspeed.nvim",
    config = function()
      require("plugins.configs.others").lightspeed()
    end,
  }

  -- colorschemes
  use "navarasu/onedark.nvim"
  -- use "morhetz/gruvbox"
  -- use "Mofiqul/dracula.nvim"
  -- use "folke/tokyonight.nvim"

  -- load whichkey after all the gui
  use {
    "folke/which-key.nvim",
    module = "which-key",
    config = function()
      require "plugins.configs.whichkey"
    end,
  }
end

require("core.packer").run(plugins)

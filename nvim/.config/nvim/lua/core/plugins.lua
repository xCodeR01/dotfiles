vim.cmd "packadd packer.nvim"

local function plugins(use)
  -- core stuff
  use "wbthomason/packer.nvim"
  use { "nvim-lua/plenary.nvim", module = "plenary" }
  use { "nvim-lua/popup.nvim", module = "popup" }
  use {
    "lewis6991/impatient.nvim",
    config = function()
      require("impatient").enable_profile()
    end,
  }
  use {
    "folke/which-key.nvim",
    config = function()
      require "configs.whichkey"
    end,
  }
  use {
    "rmagatti/auto-session",
    config = function()
      require("configs.others").auto_session()
    end,
  }

  -- cmp and snippets
  use { "rafamadriz/friendly-snippets", module = "cmp_nvim_lsp", event = "InsertEnter" }
  use {
    "L3MON4D3/LuaSnip",
    after = "friendly-snippets",
    config = function()
      require("configs.others").luasnip()
    end,
  }
  use {
    "hrsh7th/nvim-cmp",
    after = "LuaSnip",
    config = function()
      require "configs.cmp"
    end,
  }
  use { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" }
  use { "hrsh7th/cmp-nvim-lua", after = "cmp_luasnip" }
  use { "hrsh7th/cmp-nvim-lsp", after = "cmp-nvim-lua" }
  use { "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" }
  use { "hrsh7th/cmp-path", after = "cmp-buffer" }

  -- lsp stuff
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
      -- don't change this load order
      require "lsp.lsp_installer"
      require "lsp.lspconfig"
    end,
    requires = { "b0o/schemastore.nvim" },
  }
  use {
    "glepnir/lspsaga.nvim",
    branch = "main",
    after = "nvim-lsp-installer",
    config = function()
      require "lsp.lspsaga"
    end,
  }
  use {
    "jose-elias-alvarez/null-ls.nvim",
    after = "nvim-lsp-installer",
    config = function()
      require "lsp.null-ls"
    end,
  }

  -- debug stuff
  use {
    "mfussenegger/nvim-dap",
    module = "dap",
    config = function()
      require("configs.dap").setup()
    end,
  }
  use {
    "rcarriga/nvim-dap-ui",
    after = "nvim-dap",
    config = function()
      require("configs.dap").dapui()
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
      require "configs.treesitter"
    end,
  }
  use {
    "JoosepAlviste/nvim-ts-context-commentstring",
    after = "nvim-treesitter",
  }
  use {
    "windwp/nvim-ts-autotag",
    after = "nvim-treesitter",
  }
  use { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" }

  -- telescope stuff
  use {
    "nvim-telescope/telescope.nvim",
    config = function()
      require "configs.telescope"
    end,
    requires = {
      { "nvim-telescope/telescope-media-files.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    },
  }

  -- ide stuff
  use {
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    config = function()
      require("configs.others").devicons()
    end,
  }
  use {
    "kyazdani42/nvim-tree.lua",
    ft = "alpha",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require "configs.nvim-tree"
    end,
  }
  use {
    "lukas-reineke/indent-blankline.nvim",
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "indent-blankline.nvim"
    end,
    config = function()
      require "configs.blankline"
    end,
  }
  use {
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require "configs.autopairs"
    end,
  }
  use {
    "numToStr/Comment.nvim",
    module = "Comment",
    keys = { "gc", "gb" },
    config = function()
      require "configs.comment"
    end,
  }
  use {
    "RRethy/vim-illuminate",
    config = function()
      require("configs.others").illuminate()
    end,
  }
  use {
    "akinsho/bufferline.nvim",
    branch = "main",
    event = "BufWinEnter",
    config = function()
      require "configs.bufferline"
    end,
    requires = { "moll/vim-bbye" },
  }
  use {
    "nvim-lualine/lualine.nvim",
    config = function()
      require "configs.lualine"
    end,
  }
  use {
    "lewis6991/gitsigns.nvim",
    opt = true,
    setup = function()
      require("core.lazy_load").gitsigns()
    end,
    config = function()
      require "configs.gitsigns"
    end,
  }
  use {
    "norcalli/nvim-colorizer.lua",
    opt = true,
    setup = function()
      require("core.lazy_load").colorizer()
    end,
    config = function()
      require("configs.others").colorizer()
    end,
  }
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require "configs.project"
    end,
  }
  use {
    "goolord/alpha-nvim",
    config = function()
      require "configs.alpha"
    end,
  }
  use {
    "akinsho/toggleterm.nvim",
    tag = "v1.*",
    event = "BufWinEnter",
    config = function()
      require "configs.toggleterm"
    end,
  }

  -- colorschemes
  use {
    "navarasu/onedark.nvim",
    config = function()
      require("configs.colorschemes").onedark()
    end,
    disable = false,
  }
  use { "morhetz/gruvbox", disable = true }
  use { "Mofiqul/dracula.nvim", disable = true }
  use { "folke/tokyonight.nvim", disable = true }

  -- extra stuff
  use {
    "ggandor/lightspeed.nvim",
    config = function()
      require("configs.others").lightspeed()
    end,
  }
  use {
    "github/copilot.vim",
    event = "InsertEnter",
    cmd = { "Copilot" },
    config = function()
      vim.schedule(require("configs.others").copilot)
    end,
  }
end

require("core.packer").run(plugins)

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  local config = function(name)
    return string.format("require('raven.%s')", name)
  end

  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "kyazdani42/nvim-tree.lua"
  use "kyazdani42/nvim-web-devicons"
  use "akinsho/bufferline.nvim"
  use "nvim-lualine/lualine.nvim"
  use "moll/vim-bbye"
  use "akinsho/toggleterm.nvim"
  use "ahmedkhalf/project.nvim"
  use "lewis6991/impatient.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "goolord/alpha-nvim"
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim"

  -- Colorschemes
  use "lunarvim/darkplus.nvim"
  use "morhetz/gruvbox"

  -- CMP plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- Add buffer completions
  use "hrsh7th/cmp-path" -- Add path completions
  use "hrsh7th/cmp-cmdline" -- Add cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- Add snippet completions
  use "hrsh7th/cmp-nvim-lsp"	-- Add LSP completions

  -- Snippets
  use "L3MON4D3/LuaSnip" -- The snippet engine
  use "rafamadriz/friendly-snippets" -- A bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- Enable neovim LSP
  use "williamboman/nvim-lsp-installer" -- Simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- For setting neovim LSP with json files
  use "jose-elias-alvarez/null-ls.nvim" -- For formatters and linters

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use 'nvim-telescope/telescope-media-files.nvim'

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "p00f/nvim-ts-rainbow"
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Git
  use "lewis6991/gitsigns.nvim"

  -- Copilot
  use({"github/copilot.vim", config=config("copilot")  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

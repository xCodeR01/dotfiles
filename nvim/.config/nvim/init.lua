-- setup core stuff
require "options"
require "keymaps"
require "plugins"
require "colorscheme"

-- setup plugins
require "configs.cmp"
require "configs.telescope"
require "configs.treesitter"
require "configs.autopairs"
require "configs.comment"
require "configs.gitsigns"
require "configs.nvim-tree"
require "configs.bufferline"
require "configs.lualine"
require "configs.toggleterm"
require "configs.project"
require "configs.impatient"
require "configs.alpha"
require "configs.whichkey"
require "configs.autocommands"

-- Setup lsp
require "lsp.lsp-installer"
require "lsp.lspsaga"
require "lsp.null-ls"

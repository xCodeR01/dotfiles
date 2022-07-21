local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- don't auto-comment newlines
autocmd("BufEnter", {
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})

-- core setup
require "core.options"

vim.defer_fn(function()
  local mappings = require "core.mappings"
  mappings.lspconfig = nil -- handled in lspconfig.lua
  require("core.utils").load_mappings(mappings)
end, 0)

-- plugin configurations
require("core.packer").bootstrap()
require "core.plugins"

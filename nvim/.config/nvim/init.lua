local autocmd = vim.api.nvim_create_autocmd

-- don't auto-comment newlines
autocmd("BufEnter", {
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})

-- core setup
require "core.options"
require "core.colorscheme"

vim.defer_fn(function()
  local mappings = require "core.mappings"
  require("core.utils").load_mappings(mappings)
end, 0)

-- plugin configurations
require("core.packer").bootstrap()
require "plugins"

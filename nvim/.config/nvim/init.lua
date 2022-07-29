-- core setup
require "core.autocmds"
require "core.options"
require "ui.highlights"

vim.defer_fn(function()
  local mappings = require "core.mappings"
  require("core.utils").load_mappings(mappings)
end, 0)

-- plugin configurations
require("core.packer").bootstrap()
require "plugins"

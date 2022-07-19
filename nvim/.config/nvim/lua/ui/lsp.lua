local diag_icons = require("ui.icons").diagnostics

local function lspSymbol(name, icon)
  local hl = "DiagnosticSign" .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

lspSymbol("Error", diag_icons.error)
lspSymbol("Warn", diag_icons.warn)
lspSymbol("Info", diag_icons.info)
lspSymbol("Hint", diag_icons.hint)

vim.diagnostic.config {
  virtual_text = false,
  underline = true,
  update_in_insert = true,
}

-- suppress error messages from lang servers
vim.notify = function(msg, log_level)
  if msg:match "exit code" then
    return
  end
  if log_level == vim.log.levels.ERROR then
    vim.api.nvim_err_writeln(msg)
  else
    vim.api.nvim_echo({ { msg } }, true, {})
  end
end

-- borders for LspInfo winodw
local win = require "lspconfig.ui.windows"
local _default_opts = win.default_opts

win.default_opts = function(options)
  local opts = _default_opts(options)
  opts.border = "rounded"
  return opts
end

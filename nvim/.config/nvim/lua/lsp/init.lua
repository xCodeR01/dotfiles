local lspconfig_present, _ = pcall(require, "lspconfig")
if not lspconfig_present then
  return
end

local present, _ = pcall(require, "nvim-lsp-installer")
if not present then
  return
end

require "lsp.nlsp-settings"
require "lsp.lsp-setup"
require "lsp.lspsaga"
require "lsp.null-ls"

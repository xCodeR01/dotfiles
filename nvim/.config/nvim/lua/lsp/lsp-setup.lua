local lspconfig = require "lspconfig"
local lsp_installer = require "nvim-lsp-installer"
local server_opts = require "lsp.server-opts"

lsp_installer.setup {
  automatic_installation = true,
  ui = {
    icons = {
      server_installed = " ",
      server_pending = " ",
      server_uninstalled = " ",
    },
  },
  max_concurrent_installers = 10,
}

local function on_attach(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local ill_present, illuminate = pcall(require, "illuminate")
  if ill_present then
    illuminate.on_attach(client)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local cmp_present, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_present then
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end

lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
  on_attach = on_attach,
  capabilities = capabilities,
})

for _, server in ipairs(lsp_installer.get_installed_servers()) do
  local opts = {}
  if server_opts[server.name] then
    opts = server_opts[server.name]
  end
  lspconfig[server.name].setup(opts)
end

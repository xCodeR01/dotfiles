local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

lsp_installer.setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_cmp_ok then
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end

local function on_attach(client, bufnr)
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
  end

  if client.name == "sumneko_lua" then
    client.resolved_capabilities.document_formatting = false
  end

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local ill_status_ok, illuminate = pcall(require, "illuminate")
  if ill_status_ok then
    illuminate.on_attach(client)
  end

end

for _, server in ipairs(lsp_installer.get_installed_servers()) do
  local server_name = server.name
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  local has_settings, settings = pcall(require, "lsp.settings." .. server_name)
  if has_settings then
    opts.settings = settings
  end

  require("lspconfig")[server_name].setup(opts)
end

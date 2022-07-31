local present, lspconfig = pcall(require, "lspconfig")
if not present then
  return
end

require "ui.lsp"

local lsp_mappings = {
  n = {
    ["<leader>l"] = { name = "LSP" },
    -- lspsaga integration
    ["gh"] = { "<cmd>Lspsaga lsp_finder<CR>", "LSP finder" },
    ["K"] = { "<cmd>Lspsaga hover_doc<CR>", "Hover doc" },
    ["gy"] = { "<Cmd>Lspsaga signature_help<CR>", "Signature help" },
    ["gd"] = { "<cmd>Lspsaga preview_definition<CR>", "Preview defintion" },
    ["gi"] = { "<cmd>Lspsaga implment<CR>", "Show implementation" },
    ["gl"] = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Show line diagnostics" },
    ["gr"] = { "<cmd>Lspsaga rename<CR>", "LSP rename" },
    ["[d"] = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Goto prev diagnostic" },
    ["]d"] = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Goto next diagnostic" },
    ["<C-f>"] = {
      "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>",
      "Scroll forward in saga",
    },
    ["<C-b>"] = {
      "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>",
      "Scroll backward in saga",
    },
    ["<leader>la"] = { "<cmd>Lspsaga code_action<CR>", "Code Actions" },
    -- built-in lsp
    ["<leader>lf"] = { "<cmd>lua vim.lsp.buf.formatting{async=true}<CR>", " lsp formatting" },
    ["<leader>ll"] = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    ["<leader>lq"] = { "<cmd>lua vim.lsp.diagnostic.setloclist()<cr>", "Quickfix" },
    ["<leader>lA"] = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", " add workspace folder" },
    ["<leader>lR"] = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", " remove workspace folder" },
    -- telescope integration
    ["<leader>lw"] = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
    ["<leader>ld"] = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" },
    ["<leader>ls"] = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    ["<leader>lS"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
  },
  v = {
    ["<leader>la"] = { "<cmd><C-U>Lspsaga range_code_action<CR>", "Code Actions" },
  },
}

local function on_attach(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
  -- client.server_capabilities.documentFormattingProvider = false
  -- client.server_capabilities.documentRangeFormattingProvider = false

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  require("core.utils").load_mappings({ lsp_mappings }, { buffer = bufnr })

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

local lsp_servers = {
  "sumneko_lua",
  "tsserver",
  "jsonls",
  "solang",
  "rust_analyzer",
  "pyright",
}
local server_opts = require "plugins.lsp.server-opts"

-- init lsp servers with custom opts if available
for _, server_name in ipairs(lsp_servers) do
  local opts = server_opts[server_name] or {}
  lspconfig[server_name].setup(opts)
end

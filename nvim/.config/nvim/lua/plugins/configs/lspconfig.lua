local present, lspconfig = pcall(require, "lspconfig")
if not present then
  return
end

require "ui.lsp"

local lsp_mappings = {
  n = {
    ["gh"] = { "<cmd>Lspsaga lsp_finder<CR>", "" },
    ["K"] = { "<cmd>Lspsaga hover_doc<CR>", "" },
    ["gs"] = { "<Cmd>Lspsaga signature_help<CR>", "" },
    ["gd"] = { "<cmd>Lspsaga preview_definition<CR>", "" },
    ["gl"] = { "<cmd>Lspsaga show_line_diagnostics<CR>", "" },
    ["[d"] = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "" },
    ["]d"] = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "" },
    ["<C-u>"] = {
      "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(2)",
      "Scroll up in saga",
    },
    ["<C-d>"] = {
      "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-2)",
      "Scroll down in saga",
    },
    ["<leader>l"] = { name = "LSP" },
    ["<leader>la"] = { "<cmd>Lspsaga code_action<CR>", "Code Actions" },
    ["<leader>ld"] = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" },
    ["<leader>lf"] = { "<cmd>lua vim.lsp.buf.formatting{async=true}<CR>", " lsp formatting" },
    ["<leader>li"] = { "<cmd>LspInfo<cr>", "Info" },
    ["<leader>lI"] = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    ["<leader>ll"] = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    ["<leader>lq"] = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    ["<leader>lr"] = { "<cmd>Lspsaga rename<CR>", "Lsp Rename" },
    ["<leader>ls"] = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    ["<leader>lS"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
    ["<leader>lw"] = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
    ["<leader>lW"] = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", " add workspace folder" },
    ["<leader>lR"] = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", " remove workspace folder" },
  },
  v = {
    ["<leader>la"] = { "<cmd><C-U>Lspsaga range_code_action<CR>", "Code Actions" },
  },
}

local function on_attach(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false

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

local lsp_installer = require "nvim-lsp-installer"
local server_opts = {}

server_opts.sumneko_lua = {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
    },
  },
}

-- init lsp servers
for _, server in ipairs(lsp_installer.get_installed_servers()) do
  local opts = server_opts[server.name] or {}
  lspconfig[server.name].setup(opts)
end

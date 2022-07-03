local present, null_ls = pcall(require, "null-ls")
if not present then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
  debug = false,
  sources = {
    diagnostics.eslint,
    formatting.prettier.with {
      extra_filetypes = { "toml" },
    },
    diagnostics.flake8,
    formatting.black,
    formatting.stylua,
  },
}

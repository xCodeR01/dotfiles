local present, blankline = pcall(require, "indent_blankline")
if not present then
  return
end

blankline.setup {
  indentLine_enabled = 1,
  char = "▏",
  filetype_exclude = {
    "help",
    "terminal",
    "alpha",
    "packer",
    "lspinfo",
    "TelescopePrompt",
    "TelescopeResults",
    "lsp-installer",
    "NvimTree",
  },
  buftype_exclude = { "terminal", "nofile" },
  show_trailing_blankline_indent = false,
  show_first_indent_level = true,
  show_current_context = true,
  show_current_context_start = false,
  use_treesitter = true,
}

-- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
vim.wo.colorcolumn = "99999"

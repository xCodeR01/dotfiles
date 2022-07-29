local present, wk = pcall(require, "which-key")
if not present then
  return
end

wk.setup {
  icons = {
    breadcrumb = "»",
    separator = "  ",
    group = "+",
  },
  plugins = {
    spelling = {
      enabled = false,
    },
    presets = {
      operators = false,
    },
  },
  popup_mappings = {
    scroll_down = "<c-d>",
    scroll_up = "<c-u>",
  },
  layout = {
    spacing = 4, -- spacing between columns
  },
  window = {
    border = "rounded",
    position = "bottom",
    margin = { 1, 0, 1, 0 },
    padding = { 2, 2, 2, 2 },
    winblend = 0,
  },
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
  -- list of mode / prefixes that should never be hooked by WhichKey
  triggers_blacklist = {
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

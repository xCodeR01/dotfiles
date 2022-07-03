local present, saga = pcall(require, "lspsaga")
if not present then
  return
end

-- docs => https://github.com/glepnir/lspsaga.nvim#configuration
saga.init_lsp_saga({
  border_style = "rounded",
  move_in_saga = { prev = '<C-k>', next = '<C-j>' },
  diagnostic_header = { "", "", "", "" },
  show_diagnostic_source = true,
  diagnostic_source_bracket = {},
  code_action_icon = "💡",
  code_action_num_shortcut = true,
  code_action_lightbulb = {
    enable = true,
    sign = true,
    sign_priority = 20,
    virtual_text = true,
  },
  code_action_keys = {
    quit = "q",
    exec = "<CR>",
  },
  finder_separator = "  ",
  max_preview_lines = 15,
  finder_action_keys = {
    open = "<CR>",
    vsplit = "s",
    split = "i",
    tabe = "t",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  definition_preview_icon = " ",
  rename_action_quit = "<C-e>",
})

local action = require "lspsaga.action"
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
keymap("n", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", opts)
keymap("n", "gd", "<cmd>Lspsaga preview_definition<CR>", opts)
keymap("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
keymap("n", "<C-f>", function()
  action.smart_scroll_with_saga(1)
end, opts)
keymap("n", "<C-b>", function()
  action.smart_scroll_with_saga(-1)
end, opts)

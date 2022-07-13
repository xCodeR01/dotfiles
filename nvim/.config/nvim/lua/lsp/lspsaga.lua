local present, saga = pcall(require, "lspsaga")
if not present then
  return
end

-- docs => https://github.com/glepnir/lspsaga.nvim#configuration
saga.init_lsp_saga {
  border_style = "rounded",
  move_in_saga = { prev = "<C-k>", next = "<C-j>" },
  diagnostic_header = { "", "", "", "" },
  show_diagnostic_source = true,
  diagnostic_source_bracket = {},
  code_action_icon = "",
  code_action_num_shortcut = true,
  code_action_lightbulb = {
    enable = true,
    sign = true,
    sign_priority = 20,
    virtual_text = true,
  },
  finder_separator = "  ",
  max_preview_lines = 15,
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    tabe = "t",
    quit = "q",
    scroll_up = "<C-u>",
    scroll_down = "<C-d>",
  },
  definition_preview_icon = " ",
  code_action_keys = {
    quit = "q",
    exec = "<CR>",
  },
  rename_action_quit = "<C-e>",
}

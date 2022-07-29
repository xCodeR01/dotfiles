local present, saga = pcall(require, "lspsaga")
if not present then
  return
end

local diag_icons = require("ui.icons").diagnostics

-- docs => https://github.com/glepnir/lspsaga.nvim#configuration
saga.init_lsp_saga {
  border_style = "rounded",
  code_action_lightbulb = {
    enable = false,
  },
  diagnostic_header = {
    diag_icons.error,
    diag_icons.warn,
    diag_icons.info,
    diag_icons.hint,
  },
  diagnostic_source_bracket = { "<", ">" },
  definition_preview_icon = " ",
  finder_icons = {
    def = "  ",
    ref = "諭 ",
    link = "  ",
  },
  max_preview_lines = 12,
  rename_action_quit = "<C-e>",
}

local present, autopairs = pcall(require, "nvim-autopairs")
if not present then
  return
end

autopairs.setup {
  check_ts = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
    java = false,
  },
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
  fast_wrap = {
    map = "<M-e>", -- M is short for alt key
    chars = { "{", "[", "(", '"', "'", "`" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    offset = 0,
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "PmenuSel",
    highlight_grey = "LineNr",
  },
}

pcall(function()
  local cmp = require "cmp"
  local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  local ts_utils = require "nvim-treesitter.ts_utils"

  cmp.event:on("confirm_done", function(evt)
    local node_type = ts_utils.get_node_at_cursor():type()
    if node_type ~= "named_imports" then
      cmp_autopairs.on_confirm_done()(evt)
    end
  end)
end)

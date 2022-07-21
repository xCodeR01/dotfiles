local present, nvim_comment = pcall(require, "Comment")
if not present then
  return
end

nvim_comment.setup {
  ignore = "^$",
  mappings = {
    basic = true,
    extra = false,
    extended = false,
  },
  pre_hook = function(ctx)
    -- enable this only for tsx and jsx
    local ft = vim.bo.filetype
    if not (ft == "typescriptreact" or ft == "javascriptreact") then
      return
    end

    local U = require "Comment.utils"

    -- determine whether to use linewise or blockwise commentstring
    local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"
    -- determine the location where to calculate commentstring from
    local location = nil
    if ctx.ctype == U.ctype.block then
      location = require("ts_context_commentstring.utils").get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require("ts_context_commentstring.utils").get_visual_start_location()
    end

    return require("ts_context_commentstring.internal").calculate_commentstring {
      key = type,
      location = location,
    }
  end,
}

local M = {}

-- docs => https://github.com/navarasu/onedark.nvim#default-configuration
M.onedark = function()
  local present, onedark = pcall(require, "onedark")
  if not present then
    vim.notify "colorscheme onedark is not available."
    return
  end

  onedark.setup {
    style = "darker",
    transparent = false,
    toggle_style_key = "<leader>ot",

    -- plugins config --
    diagnostics = {
      darker = true,
      undercurl = true,
      background = true,
    },
  }

  onedark.load()
end

return M

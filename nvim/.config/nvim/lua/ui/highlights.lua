local M = {}
local set_hl = vim.api.nvim_set_hl

M.nvim_tree = function()
  set_hl(0, "NvimTreeGitIgnored", {
    link = "Comment",
  })
end

return M

local M = {}
local set_hl = vim.api.nvim_set_hl

-- local function get_color_from_hl(hl_name, fallback)
--   local id = vim.api.nvim_get_hl_id_by_name(hl_name)
--   if not id then
--     return fallback
--   end

--   local foreground = vim.fn.synIDattr(vim.fn.synIDtrans(id), "fg")
--   if not foreground or foreground == "" then
--     return fallback
--   end

--   return foreground
-- end

M.nvim_tree = function()
  set_hl(0, "NvimTreeFolderName", {})
  set_hl(0, "NvimTreeEmptyFolderName", {})
  set_hl(0, "NvimTreeOpenedFolderName", {})
end

return M

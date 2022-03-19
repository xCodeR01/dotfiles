vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
vim.cmd [[imap <silent><script><expr> <C-l> copilot#Accept("")]]

-- https://github.com/hrsh7th/nvim-cmp/issues/459
-- https://github.com/LunarVim/LunarVim/issues/1856
-- local copilot_keys = vim.fn["copilot#Accept"]()
--    if copilot_keys ~= "" then
--        vim.api.nvim_feedkeys(copilot_keys, "i", true)
--    else
--        fallback()
--    end

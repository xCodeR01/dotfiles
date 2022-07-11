vim.g.copilot_no_tab_map = true
-- vim.g.copilot_assume_mapped = true
-- vim.g.copilot_tab_fallback = ""
vim.cmd [[imap <silent><script><expr> <C-space> copilot#Accept()]]

vim.g.copilot_filetypes = {
  ["markdown"] = false,
}

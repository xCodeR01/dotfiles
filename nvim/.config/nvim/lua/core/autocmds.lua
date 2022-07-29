local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- don't auto-comment newlines
autocmd({ "BufWinEnter", "BufRead", "BufNewFile" }, {
  pattern = "*",
  command = "setlocal fo-=c fo-=r fo-=o",
})

-- enable spell check for some filetypes
autocmd("FileType", {
  pattern = { "gitcommit", "markdown" },
  command = "setlocal wrap spell",
})

-- highlight text on yank
autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    require("vim.highlight").on_yank { higroup = "Search", timeout = 200 }
  end,
})

autocmd("FileType", {
  pattern = { "qf", "help", "man", "floaterm", "lspinfo", "null-ls-info" },
  command = "nnoremap <silent> <buffer> q :close<CR>",
})

-- function enable_transparent_mode()
--   autocmd("ColorScheme", {
--     pattern = "*",
--     callback = function()
--       local hl_groups = {
--         "Normal",
--         "SignColumn",
--         "NormalNC",
--         "TelescopeBorder",
--         "NvimTreeNormal",
--         "EndOfBuffer",
--         "MsgArea",
--       }
--       for _, name in ipairs(hl_groups) do
--         vim.cmd(string.format("highlight %s ctermbg=none guibg=none", name))
--       end
--     end,
--   })
--   vim.opt.fillchars = "eob: "
-- end

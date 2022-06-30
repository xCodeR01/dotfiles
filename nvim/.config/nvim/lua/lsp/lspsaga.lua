local lspsaga_status_ok, saga = pcall(require, "lspsaga")
if not lspsaga_status_ok then
    return
end

-- docs => https://github.com/glepnir/lspsaga.nvim#configuration
saga.init_lsp_saga({
    border_style = "rounded",
    move_in_saga = { prev = '<C-k>', next = '<C-j>' },
    diagnostic_header = { "", "", "", "" },
    show_diagnostic_source = true,
    diagnostic_source_bracket = {},
    code_action_icon = "💡",
    code_action_num_shortcut = true,
    code_action_lightbulb = {
        enable = true,
        sign = true,
        sign_priority = 20,
        virtual_text = true,
    },
    code_action_keys = {
        quit = "q",
        exec = "<CR>",
    },
    finder_separator = "  ",
    max_preview_lines = 15,
    finder_action_keys = {
        open = "o",
        vsplit = "s",
        split = "i",
        tabe = "t",
        quit = "q",
        scroll_down = "<C-f>",
        scroll_up = "<C-b>",
    },
    definition_preview_icon = " ",
    rename_action_quit = "<C-c>",
})

local action = require "lspsaga.action"
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts) -- find word definition/reference
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show hover doc
keymap("n", "gs", "<Cmd>Lspsaga signature_help<CR>", opts) -- show signature help
keymap("n", "gd", "<cmd>Lspsaga preview_definition<CR>", opts) -- preview definition
keymap("n", "<C-f>", function()
    action.smart_scroll_with_saga(1)
end, opts)
keymap("n", "<C-b>", function()
    action.smart_scroll_with_saga(-1)
end, opts)

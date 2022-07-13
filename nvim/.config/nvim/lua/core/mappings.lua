local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local M = {}

M.general = {
  n = {
    ["<leader>a"] = { "<cmd> Alpha <cr>", "Alpha" },
    ["<leader>h"] = { "<cmd> nohlsearch <CR>", "  No Highlight" },

    -- resize window
    ["<C-Up>"] = { ":resize +2<CR>", "Increase window height" },
    ["<C-Down>"] = { ":resize -2<CR>", "Decrease window height" },
    ["<C-Left>"] = { ":vertical resize -2<CR>", "Decrease window width" },
    ["<C-Right>"] = { ":vertical resize +2<CR>", "Increase window width" },

    -- switch between windows and buffers
    ["<C-h>"] = { "<C-w>h", " window left" },
    ["<C-l>"] = { "<C-w>l", " window right" },
    ["<C-j>"] = { "<C-w>j", " window down" },
    ["<C-k>"] = { "<C-w>k", " window up" },
    ["<S-l>"] = { ":bnext<CR>", "Buffer right" },
    ["<S-h>"] = { ":bprevious<CR>", "Buffer left" },

    -- save, close and quit
    ["<C-s>"] = { "<cmd> w <CR>", "﬚  Save File" },
    ["<C-q>"] = { "<cmd> qa <CR>", "Quit Neovim" },
    ["<leader>q"] = { "<cmd> q <CR>", "Quit Window" },
    ["<leader>c"] = { "<cmd> Bdelete <CR>", "Close Buffer" },

    -- move text
    ["<A-j>"] = { "<Esc>:m .+1<CR>==gi", "Move text up" },
    ["<A-k>"] = { "<Esc>:m .-2<CR>==gi", "Move text down" },
  },
  i = {
    ["jk"] = { "<Esc>", "Exit insert mode" },
    ["<C-s>"] = { "<cmd> w <CR>", "﬚  Save File" },
    ["<C-b>"] = { "<ESC>^i", "論 beginning of line" },
    ["<C-e>"] = { "<End>", "壟 end of line" },
  },
  v = {
    ["<A-j>"] = { ":m .+1<CR>==", "Move text up" },
    ["<A-k>"] = { ":m .-2<CR>==", "Move text down" },
    p = { '"_dP', "" },

    -- Stay in indent mode
    ["<"] = { "<gv", "" },
    [">"] = { ">gv", "" },
  },
  x = {
    -- keymap("x", "J", ":move '>+1<CR>gv-gv")
    -- keymap("x", "K", ":move '<-2<CR>gv-gv")
    -- keymap("x", "<A-j>", ":move '>+1<CR>gv-gv")
    -- keymap("x", "<A-k>", ":move '<-2<CR>gv-gv")
  },

  t = {
    ["<C-x>"] = { termcodes "<C-\\><C-N>", "   escape terminal mode" },
  },
}

M.comment = {

  -- toggle comment in both modes
  n = {
    ["<leader>/"] = {
      "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>",
      "蘒 Toggle Comment",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
      "蘒 Toggle Comment",
    },
  },
}

M.nvimtree = {
  n = {
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "  Toggle Nvimtree" },
  },
}

M.telescope = {
  n = {
    ["<leader>f"] = {
      "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      "  Find Files",
    },
    ["<leader>F"] = { "<cmd> Telescope live_grep theme=ivy<CR>", "  Live grep" },
    ["<leader>b"] = {
      "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      "Buffers",
    },
    ["<leader>P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
    ["<leader>s"] = { name = "Search" },
    ["<leader>sa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find All Files" },
    ["<leader>sc"] = { "<cmd> Telescope colorscheme<cr>", "Colorscheme" },
    ["<leader>sh"] = { "<cmd> Telescope help_tags<cr>", "Find Help" },
    ["<leader>sr"] = { "<cmd> Telescope oldfiles<cr>", "Open Recent File" },
    ["<leader>sR"] = { "<cmd> Telescope registers<cr>", "Registers" },
    ["<leader>sk"] = { "<cmd> Telescope keymaps<cr>", "Keymaps" },
    ["<leader>sC"] = { "<cmd> Telescope commands<cr>", "Commands" },

    -- git
    ["<leader>go"] = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    ["<leader>gb"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    ["<leader>gc"] = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
  },
}

-- M.whichkey = {
--   n = {
--     ["<leader>wK"] = {
--       function()
--         vim.cmd "WhichKey"
--       end,
--       "  which-key all keymaps",
--     },
--     ["<leader>wk"] = {
--       function()
--         local input = vim.fn.input "WhichKey: "
--         vim.cmd("WhichKey " .. input)
--       end,
--       "  which-key query lookup",
--     },
--   },
-- }

-- M.blankline = {
--   n = {
--     ["<leader>bc"] = {
--       function()
--         local ok, start = require("indent_blankline.utils").get_current_context(
--           vim.g.indent_blankline_context_patterns,
--           vim.g.indent_blankline_use_treesitter_scope
--         )

--         if ok then
--           vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
--           vim.cmd [[normal! _]]
--         end
--       end,

--       " Jump to current_context",
--     },
--   },
-- }

M.gitsigns = {
  n = {
    ["<leader>g"] = { name = "Git" },
    ["<leader>gg"] = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    ["<leader>gj"] = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    ["<leader>gk"] = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    ["<leader>gl"] = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    ["<leader>gp"] = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    ["<leader>gr"] = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    ["<leader>gR"] = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    ["<leader>gs"] = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    ["<leader>gu"] = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    ["<leader>gd"] = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },
}

M.dap = {
  n = {
    ["<leader>d"] = { name = "DAP" },
    ["<leader>db"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    ["<leader>dc"] = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    ["<leader>di"] = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    ["<leader>do"] = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    ["<leader>dO"] = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    ["<leader>dr"] = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle REPL" },
    ["<leader>dl"] = { "<cmd>lua require'dap'.run_last()<cr>", "Run Last" },
    ["<leader>du"] = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle DAP UI" },
    ["<leader>dt"] = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
  },
}

M.packer = {
  n = {
    ["<leader>p"] = { name = "Packer" },
    ["<leader>pc"] = { "<cmd>PackerCompile<cr>", "Compile" },
    ["<leader>pi"] = { "<cmd>PackerInstall<cr>", "Install" },
    ["<leader>ps"] = { "<cmd>PackerSync<cr>", "Sync" },
    ["<leader>pS"] = { "<cmd>PackerStatus<cr>", "Status" },
    ["<leader>pu"] = { "<cmd>PackerUpdate<cr>", "Update" },
  },
}

M.terminal = {
  n = {
    ["<leader>t"] = { name = "Terminal" },
    ["<leader>tn"] = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    ["<leader>tu"] = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    ["<leader>tt"] = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    ["<leader>tp"] = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    ["<leader>tf"] = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    ["<leader>th"] = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    ["<leader>tv"] = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },
}

return M

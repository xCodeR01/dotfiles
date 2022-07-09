local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local M = {}

M.general = {
  i = {
    -- keymap("i", "jk", "<ESC>")
    -- go to  beginning and end
    ["<C-b>"] = { "<ESC>^i", "論 beginning of line" },
    ["<C-e>"] = { "<End>", "壟 end of line" },
  },
  n = {
    -- keymap("n", "<C-Up>", ":resize +2<CR>")
    -- keymap("n", "<C-Down>", ":resize -2<CR>")
    -- keymap("n", "<C-Left>", ":vertical resize -2<CR>")
    -- keymap("n", "<C-Right>", ":vertical resize +2<CR>")
    ["<ESC>"] = { "<cmd> noh <CR>", "  no highlight" },

    -- switch between windows
    ["<C-h>"] = { "<C-w>h", " window left" },
    ["<C-l>"] = { "<C-w>l", " window right" },
    ["<C-j>"] = { "<C-w>j", " window down" },
    ["<C-k>"] = { "<C-w>k", " window up" },

    ["<S-l>"] = { ":bnext<CR>", "Buffer right" },
    ["<S-h>"] = { ":bprevious<CR>", "Buffer left" },

    -- save
    ["<leader>w"] = { "<cmd> w <CR>", "﬚  save file" },

    -- Copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "  copy whole file" },
    -- keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi")
    -- keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi")
  },

  v = {

    -- -- Stay in indent mode
    -- keymap("v", "<", "<gv")
    -- keymap("v", ">", ">gv")

    -- -- Move text up and down
    -- keymap("v", "<A-j>", ":m .+1<CR>==")
    -- keymap("v", "<A-k>", ":m .-2<CR>==")
    -- keymap("v", "p", '"_dP')
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
      "蘒  toggle comment",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
      "蘒  toggle comment",
    },
  },
}

M.nvimtree = {
  n = {
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "   toggle nvimtree" },
  },
}

M.telescope = {
  n = {
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "  find files" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "  find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "   live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "  find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "  help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "   find oldfiles" },
    ["<leader>tk"] = { "<cmd> Telescope keymaps <CR>", "   show keys" },

    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "   git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "  git status" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "   pick hidden term" },

    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "   nvchad themes" },
  },
}

M.nvterm = {
  t = {
    -- toggle in terminal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "   toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "   toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "   toggle vertical term",
    },
  },

  n = {
    -- toggle in normal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "   toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "   toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "   toggle vertical term",
    },

    -- new

    ["<leader>h"] = {
      function()
        require("nvterm.terminal").new "horizontal"
      end,
      "   new horizontal term",
    },

    ["<leader>v"] = {
      function()
        require("nvterm.terminal").new "vertical"
      end,
      "   new vertical term",
    },
  },
}

M.whichkey = {
  n = {
    ["<leader>wK"] = {
      function()
        vim.cmd "WhichKey"
      end,
      "   which-key all keymaps",
    },
    ["<leader>wk"] = {
      function()
        local input = vim.fn.input "WhichKey: "
        vim.cmd("WhichKey " .. input)
      end,
      "   which-key query lookup",
    },
  },
}

M.blankline = {
  n = {
    ["<leader>bc"] = {
      function()
        local ok, start = require("indent_blankline.utils").get_current_context(
          vim.g.indent_blankline_context_patterns,
          vim.g.indent_blankline_use_treesitter_scope
        )

        if ok then
          vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
          vim.cmd [[normal! _]]
        end
      end,

      "  Jump to current_context",
    },
  },
}

M.dap = {
  n = {
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

return M

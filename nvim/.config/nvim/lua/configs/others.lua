local M = {}

M.devicons = function()
  local present, devicons = pcall(require, "nvim-web-devicons")
  if not present then
    return
  end

  devicons.setup { override = require("ui.icons").devicons }
end

M.autopairs = function()
  local present, autopairs = pcall(require, "nvim-autopairs")
  if not present then
    return
  end

  autopairs.setup {
    check_ts = true,
    ts_config = {
      lua = { "string", "source" },
      javascript = { "string", "template_string" },
      java = false,
    },
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
    fast_wrap = {
      map = "<M-e>", -- M is short for alt key
      chars = { "{", "[", "(", '"', "'", "`" },
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
      offset = 0,
      end_key = "$",
      keys = "qwertyuiopzxcvbnmasdfghjkl",
      check_comma = true,
      highlight = "PmenuSel",
      highlight_grey = "LineNr",
    },
  }

  -- local cmp_present, cmp = pcall(require, "cmp")
  -- if not cmp_present then
  --    return
  -- end

  -- local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

M.comment = function()
  local present, nvim_comment = pcall(require, "Comment")

  if not present then
    return
  end

  nvim_comment.setup {}
end

-- docs => https://github.com/lewis6991/gitsigns.nvim#usage
M.gitsigns = function()
  local present, gitsigns = pcall(require, "gitsigns")
  if not present then
    return
  end

  gitsigns.setup {
    signs = {
      add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
      change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
      delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    },
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 1000,
      ignore_whitespace = false,
    },
    current_line_blame_formatter_opts = {
      relative_time = false,
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = 40000,
    preview_config = {
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
  }
end

M.colorizer = function()
  local present, colorizer = pcall(require, "colorizer")
  if not present then
    return
  end

  local filetypes = {
    "*",
  }

  local options = {
    RGB = true,
    RRGGBB = true,
    names = false,
    rgb_fn = true,
    mode = "background",
  }

  colorizer.setup(filetypes, options)

  vim.cmd "ColorizerAttachToBuffer"
end

M.blankline = function()
  local present, blankline = pcall(require, "indent_blankline")
  if not present then
    return
  end

  blankline.setup {
    indentLine_enabled = 1,
    char = "▏",
    filetype_exclude = {
      "help",
      "terminal",
      "alpha",
      "packer",
      "lspinfo",
      "TelescopePrompt",
      "TelescopeResults",
      "lsp-installer",
      "NvimTree",
    },
    buftype_exclude = { "terminal", "nofile" },
    show_trailing_blankline_indent = false,
    show_first_indent_level = true,
    show_current_context = true,
    show_current_context_start = false,
    use_treesitter = true,
  }

  -- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
  vim.wo.colorcolumn = "99999"
end

M.luasnip = function()
  local present, luasnip = pcall(require, "luasnip")
  if not present then
    return
  end

  luasnip.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
  }

  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.luasnippets_path or "" }

  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      if
        require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require("luasnip").session.jump_active
      then
        require("luasnip").unlink_current()
      end
    end,
  })
end

M.illuminate = function()
  vim.g.Illuminate_ftblacklist = { "alpha", "NvimTree" }
  vim.api.nvim_set_keymap(
    "n",
    "<a-n>",
    '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>',
    { noremap = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<a-p>",
    '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
    { noremap = true }
  )
end

-- docs => https://github.com/ggandor/lightspeed.nvim#-configuration
M.lightspeed = function()
  local present, lightspeed = pcall(require, "lightspeed")
  if not present then
    return
  end

  lightspeed.setup {
    jump_to_unique_chars = false,
    safe_labels = {},
  }
end

return M

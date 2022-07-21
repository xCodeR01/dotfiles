local M = {}

M.auto_session = function()
  local present, session = pcall(require, "auto-session")
  if not present then
    return
  end

  vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

  local function close_nvim_tree()
    pcall(vim.cmd, "NvimTreeClose")
  end

  -- docs => https://github.com/rmagatti/auto-session#custom
  session.setup {
    auto_session_enabled = true,
    auto_save_enabled = true,
    auto_restore_enabled = true,
    bypass_session_save_file_types = { "alpha" },
    pre_save_cmds = { close_nvim_tree },
  }
end

M.devicons = function()
  local present, devicons = pcall(require, "nvim-web-devicons")
  if not present then
    return
  end

  devicons.setup { override = require("ui.icons").devicons }
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

M.copilot = function()
  vim.api.nvim_set_keymap("i", "<C-l>", "copilot#Accept()", { silent = true, expr = true })
  vim.g.copilot_no_tab_map = true
  vim.g.copilot_filetypes = {
    ["markdown"] = false,
  }
end

return M

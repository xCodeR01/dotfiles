local present, nvim_tree = pcall(require, "nvim-tree")
if not present then
  return
end

local diag_icons = require("ui.icons").diagnostics

-- docs => https://github.com/kyazdani42/nvim-tree.lua#setup
nvim_tree.setup {
  hijack_netrw = true,
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha",
  },
  respect_buf_cwd = true,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    icons = {
      error = diag_icons.error,
      warning = diag_icons.warn,
      hint = diag_icons.hint,
      info = diag_icons.info,
    },
  },
  git = {
    ignore = false,
  },
  filters = {
    custom = { "^.git$" },
  },
  view = {
    width = 25,
    hide_root_folder = true,
    adaptive_size = true,
    -- to see default mapping use `:help nvim-tree.view.mappings`
    mappings = {
      list = {
        { key = { "<CR>", "o", "l" }, action = "edit" },
        { key = "h", action = "close_node" },
        { key = "v", action = "vsplit" },
      },
    },
  },
  renderer = {
    group_empty = false,
    highlight_git = true,
    highlight_opened_files = "all",
    icons = {
      webdev_colors = true,
      git_placement = "before",
      show = {
        git = true,
        file = true,
        folder = true,
        folder_arrow = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          deleted = "",
          untracked = "U",
          ignored = "",
        },
      },
    },
  },
}

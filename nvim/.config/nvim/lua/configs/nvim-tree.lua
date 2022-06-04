local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

-- docs => https://github.com/kyazdani42/nvim-tree.lua#setup
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
nvim_tree.setup {
  hijack_cursor = false,
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha",
  },
  open_on_tab = false,
  update_cwd = true,
  respect_buf_cwd = true,
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = true,
    side = "left",
    adaptive_size = true,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {
        { key = { "<CR>", "o", "l" }, action = "edit" },
        { key = "h", action = "close_node" },
        { key = "v", action = "vsplit" },
      },
    },
  },
  renderer = {
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        git = true,
        file = true,
        folder = true,
        folder_arrow = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          deleted = "",
          untracked = "U",
          ignored = "◌",
        },
      },
    },
  },
}

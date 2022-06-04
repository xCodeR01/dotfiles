local status_ok, project = pcall(require, "project_nvim")
if not status_ok then
  return
end

-- docs => https://github.com/ahmedkhalf/project.nvim#%EF%B8%8F-configuration
project.setup({
  active = true,
  on_config_done = nil,
  manual_mode = false,
  -- NOTE: lsp detection will get annoying with multiple langs in one project
  detection_methods = { "lsp", "pattern" },
  patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "Pipfile" },
  show_hidden = false,
  silent_chdir = true,
  ignore_lsp = {},
  datapath = vim.fn.stdpath("data"),
})

local tele_status_ok, telescope = pcall(require, "telescope")
if not tele_status_ok then
  return
end

telescope.load_extension('projects')

local present, project = pcall(require, "project_nvim")
if not present then
  return
end

-- docs => https://github.com/ahmedkhalf/project.nvim#%EF%B8%8F-configuration
project.setup({
  active = true,
  on_config_done = nil,
  manual_mode = false,
  detection_methods = { "pattern" },
  patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "Pipfile" },
  show_hidden = false,
  silent_chdir = true,
  ignore_lsp = {},
  datapath = vim.fn.stdpath("data"),
})

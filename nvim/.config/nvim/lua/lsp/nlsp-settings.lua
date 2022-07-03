local present, nlspsettings = pcall(require, "nlspsettings")
if not present then
  return
end

nlspsettings.setup({
  config_home = vim.fn.stdpath('config') .. '/lua/lsp/settings',
  local_settings_dir = ".nlsp-settings",
  local_settings_root_markers = { '.git' },
  append_default_schemas = true,
  loader = 'json'
})

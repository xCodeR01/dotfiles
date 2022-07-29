local present, mason = pcall(require, "mason")
if not present then
  return
end

mason.setup {
  ui = {
    border = "rounded",
    icons = {
      package_installed = " ",
      package_pending = " ",
      package_uninstalled = " ",
    },
    keymaps = {
      cancel_installation = "<C-e>",
    },
  },
  max_concurrent_installers = 5,
}

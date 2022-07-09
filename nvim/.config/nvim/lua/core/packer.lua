local M = {}

M.bootstrap = function()
  local fn = vim.fn
  local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e222a" })

  if fn.empty(fn.glob(install_path)) > 0 then
    print "Cloning packer .."
    fn.system {
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    }
  end
end

M.run = function(plugins)
  local present, packer = pcall(require, "packer")
  if not present then
    return
  end

  packer.init {
    auto_clean = true,
    compile_on_sync = true,
    git = { clone_timeout = 6000 },
    display = {
      working_sym = "ﲊ",
      error_sym = "✗ ",
      done_sym = " ",
      removed_sym = " ",
      moved_sym = "",
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  packer.startup(plugins)
end

return M

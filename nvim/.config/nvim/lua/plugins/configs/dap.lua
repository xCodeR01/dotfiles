local M = {}

-- docs => https://github.com/rcarriga/nvim-dap-ui#configuration
M.dapui = function()
  local present, dapui = pcall(require, "dapui")
  if not present then
    return
  end

  local dap = require "dap"

  dapui.setup {
    layouts = {
      {
        elements = {
          "scopes",
          "breakpoints",
          "stacks",
          "watches",
        },
        size = 40,
        position = "left",
      },
      {
        elements = {
          "repl",
          "console",
        },
        size = 10,
        position = "bottom",
      },
    },
  }

  vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end

  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end

  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

-- docs => https://github.com/ravenxrz/DAPInstall.nvim#-configuration
M.dap_install = function()
  local present, dap_install = pcall(require, "dap-install")
  if not present then
    return
  end

  dap_install.setup {}

  dap_install.config("python", {})

  -- local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()
  -- for _, debugger in ipairs(dbg_list) do
  --   dap_install.config(debugger)
  -- end
end

return M

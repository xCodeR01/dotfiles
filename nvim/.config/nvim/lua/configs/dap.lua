local M = {}

-- docs => https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
M.setup = function()
  local present, dap = pcall(require, "dap")
  if not present then
    return
  end

  -- configurations for the specific adapters

  -- register adapters with nvim-dap
end

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

return M

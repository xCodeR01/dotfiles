local dap_present, dap = pcall(require, "dap")
if not dap_present then
  return
end

local dap_ui_present, dapui = pcall(require, "dapui")
if not dap_ui_present then
  return
end

local dap_install_present, dap_install = pcall(require, "dap-install")
if not dap_install_present then
  return
end

dap_install.setup {}

-- debugger specific configs go here
dap_install.config("python", {})

-- docs => https://github.com/rcarriga/nvim-dap-ui#configuration
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

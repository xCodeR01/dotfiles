local M = {}
local api = vim.api

local merge_tb = vim.tbl_deep_extend

M.load_mappings = function(mappings, mapping_opt)
  -- set mapping function with/without whichkey
  local map_func
  local whichkey_exists, wk = pcall(require, "which-key")

  if whichkey_exists then
    map_func = function(keybind, mapping_info, opts)
      wk.register({ [keybind] = mapping_info }, opts)
    end
  else
    map_func = function(keybind, mapping_info, opts)
      local mode = opts.mode
      opts.mode = nil
      vim.keymap.set(mode, keybind, mapping_info[1], opts)
    end
  end

  for _, section_mappings in pairs(mappings) do
    for mode, mode_mappings in pairs(section_mappings) do
      for keybind, mapping_info in pairs(mode_mappings) do
        -- handle ["key"] = { name = "+prefix"} map if wk is not present
        -- if not whichkey_exists and mapping_info.name ~= nil then
        --   return
        -- end
        -- merge default + user opts
        local default_opts = merge_tb("force", { mode = mode }, mapping_opt or {})
        local opts = merge_tb("force", default_opts, mapping_info.opts or {})

        if mapping_info.opts then
          mapping_info.opts = nil
        end

        map_func(keybind, mapping_info, opts)
      end
    end
  end
end

M.packer_sync = function(...)
  local git_exists, git = pcall(require, "nvchad.utils.git")
  local defaults_exists, defaults = pcall(require, "nvchad.utils.config")
  local packer_exists, packer = pcall(require, "packer")

  if git_exists and defaults_exists then
    local current_branch_name = git.get_current_branch_name()

    -- warn the user if we are on a snapshot branch
    if current_branch_name:match(defaults.snaps.base_snap_branch_name .. "(.+)" .. "$") then
      vim.api.nvim_echo({
        { "WARNING: You are trying to use ", "WarningMsg" },
        { "PackerSync" },
        {
          " on a NvChadSnapshot. This will cause issues if NvChad dependencies contain "
            .. "any breaking changes! Plugin updates will not be included in this "
            .. "snapshot, so they will be lost after switching between snapshots! Would "
            .. "you still like to continue? [y/N]\n",
          "WarningMsg",
        },
      }, false, {})

      local ans = vim.trim(string.lower(vim.fn.input "-> "))

      if ans ~= "y" then
        return
      end
    end
  end

  if packer_exists then
    packer.sync(...)
  else
    error "Packer could not be loaded!"
  end
end

M.bufilter = function()
  local bufs = vim.t.bufs

  for i = #bufs, 1, -1 do
    if not vim.api.nvim_buf_is_valid(bufs[i]) then
      table.remove(bufs, i)
    end
  end

  return bufs
end

M.close_buffer = function(bufnr)
  if vim.bo.buftype == "terminal" then
    vim.cmd(vim.bo.buflisted and "set nobl | enew" or "hide")
  elseif vim.bo.modified then
    print "save the file bruh"
  else
    bufnr = bufnr or api.nvim_get_current_buf()
    require("core.utils").tabuflinePrev()
    vim.cmd("bd" .. bufnr)
  end
end

-- closes tab + all of its buffers
M.close_all_bufs = function(action)
  local bufs = vim.t.bufs

  if action == "closeTab" then
    vim.cmd "tabclose"
  end

  for _, buf in ipairs(bufs) do
    M.close_buffer(buf)
  end

  if action ~= "closeTab" then
    vim.cmd "enew"
  end
end

return M

local M = {}
local merge_tb = vim.tbl_deep_extend

M.load_mappings = function(mappings, mapping_opt)
  -- set mapping function with/without whichkey
  local set_maps
  local whichkey_exists, wk = pcall(require, "which-key")

  if whichkey_exists then
    set_maps = function(keybind, mapping_info, opts)
      wk.register({ [keybind] = mapping_info }, opts)
    end
  else
    set_maps = function(keybind, mapping_info, opts)
      local mode = opts.mode
      opts.mode = nil
      vim.keymap.set(mode, keybind, mapping_info[1], opts)
    end
  end

  for _, section in pairs(mappings) do
    for mode, mode_values in pairs(section) do
      for keybind, mapping_info in pairs(mode_values) do
        -- handle ["key"] = { name = "+prefix"} map if wk is not present
        if mapping_info.name and not whichkey_exists then
          return
        end
        -- merge default + user opts
        local default_opts = merge_tb("force", { mode = mode }, mapping_opt or {})
        local opts = merge_tb("force", default_opts, mapping_info.opts or {})

        if mapping_info.opts then
          mapping_info.opts = nil
        end

        set_maps(keybind, mapping_info, opts)
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

return M
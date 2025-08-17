-- Main plugin loader for organized plugin structure
-- This file automatically imports all plugins from subdirectories

local M = {}

-- Function to recursively scan for plugin files
local function scan_dir(directory)
  local plugins = {}
  local config_path = vim.fn.stdpath("config")
  local full_path = config_path .. "/lua/" .. directory:gsub("%.", "/")
  
  -- Check if directory exists
  if vim.fn.isdirectory(full_path) == 0 then
    return plugins
  end
  
  -- Get all files and directories
  local items = vim.fn.readdir(full_path)
  
  for _, item in ipairs(items) do
    local item_path = full_path .. "/" .. item
    local module_path = directory .. "." .. item:gsub("%.lua$", "")
    
    if vim.fn.isdirectory(item_path) == 1 then
      -- Recursively scan subdirectories
      local subdir_plugins = scan_dir(module_path)
      for _, plugin in ipairs(subdir_plugins) do
        table.insert(plugins, plugin)
      end
    elseif item:match("%.lua$") and item ~= "init.lua" then
      -- Load .lua files (except init.lua)
      local ok, plugin_spec = pcall(require, module_path)
      if ok and plugin_spec then
        -- Handle both single plugin specs and arrays of plugin specs
        if type(plugin_spec) == "table" then
          if type(plugin_spec[1]) == "string" then
            -- Single plugin spec
            table.insert(plugins, plugin_spec)
          else
            -- Array of plugin specs
            for _, spec in ipairs(plugin_spec) do
              table.insert(plugins, spec)
            end
          end
        end
      else
        vim.notify("Failed to load plugin: " .. module_path, vim.log.levels.WARN)
      end
    end
  end
  
  return plugins
end

-- Automatically discover and load all plugins
local plugins = scan_dir("config.plugins")

return plugins

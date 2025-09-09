-- Simple automatic plugin loader using globbing
local M = {}

-- Get all .lua files in the plugins directory and subdirectories
local function load_all_plugins()
  local plugins = {}
  local config_dir = vim.fn.stdpath("config") .. "/lua/config/plugins"
  
  -- Use vim.fn.glob to find all .lua files recursively
  local files = vim.fn.glob(config_dir .. "/**/*.lua", false, true)
  
  for _, file in ipairs(files) do
    -- Skip init.lua files
    if not file:match("init%.lua$") then
      -- Convert file path to module path
      local module_path = file:gsub(config_dir .. "/", ""):gsub("%.lua$", ""):gsub("/", ".")
      module_path = "config.plugins." .. module_path
      
      local ok, plugin_spec = pcall(require, module_path)
      if ok and plugin_spec then
        table.insert(plugins, plugin_spec)
      end
    end
  end
  
  return plugins
end

return load_all_plugins()

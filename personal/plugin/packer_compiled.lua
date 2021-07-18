-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/evan/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/evan/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/evan/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/evan/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/evan/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["TrueZen.nvim"] = {
    loaded = true,
    path = "/home/evan/.local/share/nvim/site/pack/packer/start/TrueZen.nvim"
  },
  ["barbar.nvim"] = {
    loaded = true,
    path = "/home/evan/.local/share/nvim/site/pack/packer/start/barbar.nvim"
  },
  embark = {
    loaded = true,
    path = "/home/evan/.local/share/nvim/site/pack/packer/start/embark"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/evan/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["goyo.vim"] = {
    loaded = true,
    path = "/home/evan/.local/share/nvim/site/pack/packer/start/goyo.vim"
  },
  ["lazygit.nvim"] = {
    loaded = true,
    path = "/home/evan/.local/share/nvim/site/pack/packer/start/lazygit.nvim"
  },
  ["lightline.vim"] = {
    loaded = true,
    path = "/home/evan/.local/share/nvim/site/pack/packer/start/lightline.vim"
  },
  ["minimap.vim"] = {
    loaded = true,
    path = "/home/evan/.local/share/nvim/site/pack/packer/start/minimap.vim"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/evan/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-toggleterm.lua"] = {
    loaded = true,
    path = "/home/evan/.local/share/nvim/site/pack/packer/start/nvim-toggleterm.lua"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/evan/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/evan/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/evan/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/home/evan/.local/share/nvim/site/pack/packer/start/tokyonight.nvim"
  },
  ["typescript-vim"] = {
    loaded = true,
    path = "/home/evan/.local/share/nvim/site/pack/packer/start/typescript-vim"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/evan/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-javascript"] = {
    loaded = true,
    path = "/home/evan/.local/share/nvim/site/pack/packer/start/vim-javascript"
  },
  ["vim-jsx-typescript"] = {
    loaded = true,
    path = "/home/evan/.local/share/nvim/site/pack/packer/start/vim-jsx-typescript"
  },
  ["vim-one"] = {
    loaded = true,
    path = "/home/evan/.local/share/nvim/site/pack/packer/start/vim-one"
  },
  ["vim-styled-components"] = {
    loaded = true,
    path = "/home/evan/.local/share/nvim/site/pack/packer/start/vim-styled-components"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/home/evan/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  },
  ["zen-mode.nvim"] = {
    loaded = true,
    path = "/home/evan/.local/share/nvim/site/pack/packer/start/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end

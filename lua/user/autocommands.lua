-- List of vim events:
-- https://tech.saigonist.com/b/code/list-all-vim-script-events.html
--
-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd [[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins/init.lua source <afile> | PackerSync
--   augroup end
-- ]]

-- Open Alpha when deleting last buffer
local groupname = vim.api.nvim_create_augroup("buffer-close", {})
vim.api.nvim_create_autocmd({ "BufDelete" }, {
  group = groupname,
  callback = function()
    local loaded_buffers = Get_loaded_buffers()
    if #loaded_buffers == 2 and vim.fn.expand "%" == "" then
      -- vim.cmd "Alpha"
      vim.cmd "bdelete #"
    end
  end,
})

-- Hightlight on yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 400 })
  end,
})

-- Clear command line message after a few seconds
local cmdline_timer = vim.loop.new_timer()
local message_duration = 4000
vim.api.nvim_create_autocmd({ "CmdlineLeave" }, {
  callback = function()
    cmdline_timer:start(
      message_duration,
      0,
      vim.schedule_wrap(function()
        -- vim.notify ""
      end)
    )
  end,
})

vim.api.nvim_create_autocmd({ "CmdwinEnter", "CmdlineEnter" }, {
  callback = function()
    cmdline_timer:stop()
  end,
})

-- Return to last cursor position on enter
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd [[silent! '"; normal z.]]
  end,
})

local svelte_group = vim.api.nvim_create_augroup("custom-prettier", {})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = svelte_group,
  pattern = { "*.svelte", "*.astro" },
  callback = function()
    vim.cmd ":silent !prettier --write %"
  end,
})

-- TODO: set this up with default highlight groups
--
--[[ vim.api.nvim_create_autocmd("ModeChanged", { ]]
--[[   callback = function() ]]
--[[     local modes = { ]]
--[[       ["i"] = "#7aa2f7", ]]
--[[       ["c"] = "#e0af68", ]]
--[[       ["v"] = "#c678dd", ]]
--[[       ["V"] = "#c678dd", ]]
--[[       [""] = "#c678dd", ]]
--[[     } ]]
--[[     vim.api.nvim_set_hl(0, "CursorLineNr", { ]]
--[[       foreground = modes[vim.api.nvim_get_mode().mode] or "#737aa2", ]]
--[[     }) ]]
--[[   end, ]]
--[[ }) ]]

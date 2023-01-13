local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Save
keymap("n", "<C-s>", CMD "update", opts)
-- better window movement
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- resize with arrows
keymap("n", "<C-Up>", CMD "resize +3", opts)
keymap("n", "<C-Down>", CMD "resize -3", opts)
keymap("n", "<C-Left>", CMD "vertical resize +3", opts)
keymap("n", "<C-Right>", CMD "vertical resize -3", opts)

-- better indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Navigate buffers
keymap("n", "]b", CMD "bnext", opts) -- Next buffer
keymap("n", "<C-n>", CMD "bnext", opts)
keymap("n", "<TAB>", CMD "bnext", opts)
keymap("n", "[b", CMD "bprevious", opts) -- Previous buffer
keymap("n", "<S-TAB>", CMD "bprevious", opts)
keymap("n", "<BS>", CMD "b#", opts)
keymap("n", "<leader>lb", ":ls<CR>:b<space>", opts)


vim.api.nvim_create_user_command("CloseBuffer", function()
  local loaded_buffers = Get_loaded_buffers()
  if #loaded_buffers == 0 then
    return
  elseif #loaded_buffers == 1 then
    vim.cmd "bdelete"
  else
    vim.cmd "bprevious|bdelete#"
  end
end, {})
keymap("n", "<C-w>", CMD "CloseBuffer", opts)

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- When going up or down one line, use displayed lines instead of physical lines
keymap("n", "k", "gk", opts)
keymap("n", "j", "gj", opts)
keymap("v", "k", "gk", opts)
keymap("v", "$", "g$", opts)

-- Navigate to beginning or ending of line
keymap("n", "H", "0", opts)
keymap("v", "H", "0", opts)
keymap("n", "L", "$", opts)
keymap("v", "L", "$", opts)

-- Start search and replace in visual mode
keymap("v", "f", ":s/", opts)

-- Prevent overiding the last yank when deleting empty line
keymap("n", "dd", function()
  if vim.api.nvim_get_current_line():match "^%s*$" then
    return '"_dd'
  else
    return "dd"
  end
end, { expr = true, noremap = true })

keymap("n", "<Esc>", function()
  require("notify").dismiss({}) -- clear notifications
  CMD "nohl" -- clear highlights
  CMD "echo " -- clear short-message
end)

keymap("", "<Space>", "<Nop>", opts)

-- Terminal
keymap("t", "<Esc><Esc>", [[<C-\><C-N> :q<CR>]], opts)

-- Disable recording
keymap("n", "Q", "<nop>", opts)
keymap("n", "q", "<nop>", opts)

-- Leader key mappings

keymap("n", "<leader>O", CMD "OpenSlides", opts)

local fn = require "user.functions.utils"

fn.register_key_map({
  q = {
    CMD "quitall!",
    "Quit",
  },
  l = {
    CMD "noh",
    "Clear highlights",
  },
  c = {
    CMD "close",
    "Close window",
  },
  ["-"] = {
    CMD "b#",
    "return to last buffer",
  },
  ["]"] = {
    CMD "bnext",
    "Go to next buffer",
  },
  ["["] = {
    CMD "bprev",
    "Go to previous buffer",
  },
  ["<TAB>"] = {
    CMD "Telescope buffers",
    "Go to previous buffer",
  },
  t = {
    a = {
      CMD "$tabnew | NvimTreeOpen",
      "New tab",
    },
    c = {
      CMD "tabclose",
      "Close tab",
    },
  },
  T = {
    name = "Toggle vim option",
    c = {
      fn.toggle_option "cursorcolumn",
      "cursorcolumn",
    },
    r = {
      fn.toggle_option "relativenumber",
      "relative number",
    },
  },
  E = {
    function()
      require("user.env").printValues()
    end,
    "Show all values in .env file",
  },
})

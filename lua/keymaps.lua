-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  print("call a func")
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Change leader to a comma
--vim.g.mapleader = ''

-- Save file with Ctrl+S
map('n', '<C-s>', ':w<CR>')

-- Reread file with Ctrl+R
map('n', '<C-r>', ':so<CR>')

-- Toggle file manager
map('n', '<C-1>', ':NERDTreeToggle<CR>')

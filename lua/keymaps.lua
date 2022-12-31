print('keymaps.lua')
-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  print("map" .. mode .. lhs .. rhs)
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Toggle file manager
map('n', '<Leader>nt', ':NvimTreeToggle<CR>')

-- Toggle undotree
map('n', '<Leader>tt', ':UndotreeToggle<CR>')

-- Example func
map('n', '<Leader>bo', ':lua print("hello")<CR>')

require('keymaps')

local present = function(a, b)
    print("A: ", a)
    print("B: ", b)

    print("Hello from NVIM")
end

present(1, 2)

vim.o.relativenumber = true

local set = vim.o

set.tabstop = 8
set.softtabstop = 0
set.expandtab = true
set.shiftwidth = 4
set.swapfile = false
set.cursorline = true
set.spell = false


require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- this is essential.
    use 'preservim/nerdtree'
    use 'Mofiqul/dracula.nvim'
    use 'williamboman/mason.nvim'
    use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
end)

-- Color schema
vim.cmd [[colorscheme dracula]]

vim.lsp.start({
    name = 'my-server-name',
    cmd = { 'name-of-language-server-executable' },
    root_dir = vim.fs.dirname(vim.fs.find({ 'setup.py', 'pyproject.toml' }, { upward = true })[1]),
})

-- Mason
require('mason').setup()


vim.lsp.set_log_level("debug")

-- LSP mappings
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    print('on-attach')
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
    print('ex')
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

require('vim.lsp.log').set_format_func(vim.inspect)


-- Lua lsp
require('lspconfig')['sumneko_lua'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = '5.1',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

print(_VERSION)

local f = function(a, b)
end

f()

vim.lsp.set_log_level("debug")

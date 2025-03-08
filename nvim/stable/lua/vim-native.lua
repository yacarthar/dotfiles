vim.g.mapleader = " "


vim.cmd.syntax = "enable"       -- Enabling syntax highlighting
vim.opt.number = true           -- Show line numbers
vim.opt.wrap = false            -- Disable line wrapping

vim.opt.expandtab = true        -- Use spaces instead of tabs
vim.opt.tabstop = 4             -- Number of spaces a <Tab> counts for
vim.opt.softtabstop = 4         -- Number of spaces a <Tab> in insert mode counts for
vim.opt.shiftwidth = 4          -- Number of spaces to use for autoindent
vim.opt.autoindent = true       -- Enable automatic indentation
vim.opt.smarttab = true         -- Smart tabbing based on shiftwidth


vim.opt.list = true
vim.opt.listchars = { tab = '▸ ', trail = '·' }
vim.opt.clipboard = 'unnamedplus'
vim.opt.encoding = 'utf-8'

vim.api.nvim_create_user_command('Q', 'q', {})

-- Quickly escape to normal mode
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true, silent = true })

-- Save file the traditional way
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })

-- Quick edit and reload Neovim config
vim.api.nvim_set_keymap('n', '<leader>ve', ':edit $MYVIMRC<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>vr', ':source $MYVIMRC<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-e>", "4<C-e>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-y>", "4<C-y>", { noremap = true, silent = true })


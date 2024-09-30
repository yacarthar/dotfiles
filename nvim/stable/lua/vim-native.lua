vim.cmd("syntax enable")
vim.cmd("set number")
vim.cmd("set nowrap")

vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set autoindent")


vim.api.nvim_create_user_command('Q', 'q', {})


vim.g.mapleader = " "

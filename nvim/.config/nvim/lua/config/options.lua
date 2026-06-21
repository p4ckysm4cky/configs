vim.cmd("syntax on")

-- Interface
vim.opt.wildmenu = true
vim.opt.number = true
vim.opt.laststatus = 2
vim.opt.visualbell = true
vim.opt.wrap = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Searching
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Disable special numeric format
vim.opt.nrformats = {}

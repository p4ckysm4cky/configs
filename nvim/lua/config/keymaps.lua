-- Navigation
vim.keymap.set("", "j", "gj")
vim.keymap.set("", "k", "gk")

vim.keymap.set("", "<S-h>", "gT")
vim.keymap.set("", "<S-l>", "gt")

vim.keymap.set("", "<S-j>", "5gj")
vim.keymap.set("", "<S-k>", "5gk")

vim.keymap.set("", "<C-h>", "<C-w>h")
vim.keymap.set("", "<C-l>", "<C-w>l")

-- Mark navigation
vim.keymap.set("n", "mq", "mQ")
vim.keymap.set("v", "mq", "mQ")

vim.keymap.set("n", "mw", "mW")
vim.keymap.set("v", "mw", "mW")

vim.keymap.set("n", "me", "mE")
vim.keymap.set("v", "me", "mE")

vim.keymap.set("n", "mr", "mR")
vim.keymap.set("v", "mr", "mR")

vim.keymap.set("n", "'q", "'Q")
vim.keymap.set("v", "'q", "'Q")

vim.keymap.set("n", "'w", "'W")
vim.keymap.set("v", "'w", "'W")

vim.keymap.set("n", "'e", "'E")
vim.keymap.set("v", "'e", "'E")

vim.keymap.set("n", "'r", "'R")
vim.keymap.set("v", "'r", "'R")

-- Custom binds
vim.keymap.set("n", "<leader>r", "<cmd>set relativenumber!<CR>")
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>m", "<cmd>delmarks!<CR>")
vim.keymap.set("n", "<leader>M", "<cmd>delmarks A-Z<CR>")

-- Clipboard binds
vim.keymap.set("n", "Y", '+"+y')
vim.keymap.set("v", "Y", '+"+y')
vim.keymap.set("v", "P", '+"+p')
vim.keymap.set("n", "P", '+"+p')

-- local builtin = require("telescope.builtin")

-- Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Save / quit behavior
vim.keymap.set("n", "<leader>s", ":w<CR>")
vim.keymap.set("n", "<leader>k", ":bd<CR>")

-- File / buffer
vim.keymap.set("n", "<leader>f", ":Ex<CR>") -- file explorer (netrw)
-- vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "[F]ind files" })
vim.keymap.set("n", "<leader>b", ":ls<CR>")
-- vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Find existing [B]uffers" })

-- Command mode
vim.keymap.set("n", "<leader><space>", ":")

-- Window navigation
vim.keymap.set("n", "<leader>wk", "<C-w>k")
vim.keymap.set("n", "<leader>wh", "<C-w>h")
vim.keymap.set("n", "<leader>wj", "<C-w>j")
vim.keymap.set("n", "<leader>wl", "<C-w>l")

-- Splits
vim.keymap.set("n", "<leader>v", ":vsplit<CR>")
vim.keymap.set("n", "<leader>t", ":split<CR>")

-- Window control
vim.keymap.set("n", "<leader>0", "<C-w>c")
vim.keymap.set("n", "<leader>1", "<C-w>o")

-- Escape / cancel
vim.keymap.set({ "n", "i", "v" }, "<Esc>", "<Esc>")




local keys = { "h", "j", "k", "l", "i", "o", "H", "K", "L" }
for _, key in ipairs(keys) do
	vim.keymap.set({ "n", "x", "o" }, key, "<Nop>", { noremap = true, silent = true })
end
-- local builtin = require("telescope.builtin")

vim.keymap.set({ "n", "x", "o" }, "i", "k", { desc = "Up" })
vim.keymap.set({ "n", "x", "o" }, "k", "j", { desc = "Down" })
vim.keymap.set({ "n", "x", "o" }, "j", "h", { desc = "Left" })
vim.keymap.set({ "n", "x", "o" }, "o", "l", { desc = "Right" })
vim.keymap.set({ "n", "x", "o" }, "<Space>", "i", { desc = "Insert" })
vim.keymap.set({ "n", "x", "o" }, "<leader>i", "I", { desc = "Insert at the start of line" })
vim.keymap.set({ "n", "x", "o" }, "h", "o", { desc = "Open line below" })
vim.keymap.set({ "n", "x", "o" }, "H", "O", { desc = "Open line below" })
vim.keymap.set({ "n", "x", "o" }, "<A-o>", "$", { desc = "End of line" })
vim.keymap.set({ "n", "x", "o" }, "<A-j>", "_", { desc = "Start of line" })

-- Leader Key
vim.g.mapleader = "¥"
vim.g.maplocalleader = "¥"

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

-- Window navigation (matches your Emacs logic)
vim.keymap.set("n", "<leader>wi", "<C-w>k")
vim.keymap.set("n", "<leader>wj", "<C-w>h")
vim.keymap.set("n", "<leader>wk", "<C-w>j")
vim.keymap.set("n", "<leader>wo", "<C-w>l")

-- Splits
vim.keymap.set("n", "<leader>v", ":vsplit<CR>")
vim.keymap.set("n", "<leader>t", ":split<CR>")

-- Window control
vim.keymap.set("n", "<leader>0", "<C-w>c")
vim.keymap.set("n", "<leader>1", "<C-w>o")

-- Escape / cancel
vim.keymap.set({ "n", "i", "v" }, "<leader>¥", "<Esc>")
vim.keymap.set({ "n", "i", "v" }, "<Esc>", "<Esc>")




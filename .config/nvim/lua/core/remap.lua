local keys = { "h", "j", "k", "l", "i", "o", "H", "J", "K", "L" }
for _, key in ipairs(keys) do
	vim.keymap.set({ "n", "x", "o" }, key, "<Nop>", { noremap = true, silent = true })
end

vim.keymap.set({ "n", "x", "o" }, "i", "k", { desc = "Up" })
vim.keymap.set({ "n", "x", "o" }, "k", "j", { desc = "Down" })
vim.keymap.set({ "n", "x", "o" }, "j", "h", { desc = "Left" })
vim.keymap.set({ "n", "x", "o" }, "o", "l", { desc = "Right" })
vim.keymap.set({ "n", "x", "o" }, " ", "i", { desc = "Insert" })
vim.keymap.set({ "n", "x", "o" }, "<leader>i", "I", { desc = "Insert at the start of line" })
vim.keymap.set({ "n", "x", "o" }, "h", "o", { desc = "Open line below" })
vim.keymap.set({ "n", "x", "o" }, "H", "O", { desc = "Open line below" })
vim.keymap.set({ "n", "x", "o" }, "<A-o>", "$", { desc = "End of line" })
vim.keymap.set({ "n", "x", "o" }, "<A-j>", "_", { desc = "Start of line" })

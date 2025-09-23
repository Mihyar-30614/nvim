local map = vim.keymap.set
local opts = { silent = true }

-- General
map({ "n", "v" }, "<Space>", "<Nop>", opts)
map("i", "jj", "<Esc>", { desc = "Quick escape" })
map("n", "<leader>w", ":w<CR>", { desc = "Write" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>bd", ":bd<CR>", { desc = "Close buffer" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Format files
vim.g.conform_format_on_save_enabled = true

map("n", "<leader>uF", function()
	vim.g.conform_format_on_save_enabled = not vim.g.conform_format_on_save_enabled
	vim.notify("Format on save: " .. (vim.g.conform_format_on_save_enabled and "ON" or "OFF"))
end, { desc = "Toggle format on save" })

-- Indentation utilities
map("n", "<leader>ut", function()
	vim.o.expandtab = not vim.o.expandtab
	vim.notify("expandtab = " .. tostring(vim.o.expandtab))
end, { desc = "Toggle expandtab (tabs vs spaces)" })

map("n", "<leader>u2", function()
	vim.o.tabstop = 2
	vim.o.shiftwidth = 2
	vim.notify("Indent width set to 2")
end, { desc = "Set indent width = 2" })

map("n", "<leader>u4", function()
	vim.o.tabstop = 4
	vim.o.shiftwidth = 4
	vim.notify("Indent width set to 4")
end, { desc = "Set indent width = 4" })

map("n", "<leader>u8", function()
	vim.o.tabstop = 8
	vim.o.shiftwidth = 8
	vim.notify("Indent width set to 8")
end, { desc = "Set indent width = 8" })

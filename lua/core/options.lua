local o = vim.opt
o.number = true
o.mouse = "a"
o.showmode = false
o.breakindent = true
o.undofile = true
o.ignorecase = true
o.smartcase = true
o.signcolumn = "yes"
o.updatetime = 250
o.timeoutlen = 400
o.splitright = true
o.splitbelow = true
o.list = false
-- o.list = true
-- o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
o.inccommand = "split"
o.cursorline = true
o.scrolloff = 10
o.confirm = true

-- Indentation defaults
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = false
o.smartindent = true

-- Filetype specific override
-- python -> 4 spaces
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
	end,
})

-- Makefiles → real tabs, width 8
vim.api.nvim_create_autocmd("FileType", {
	pattern = "make",
	callback = function()
		vim.opt_local.expandtab = false -- enforce real tabs
		vim.opt_local.tabstop = 8
		vim.opt_local.shiftwidth = 8
	end,
})

-- local osc52 = require("vim.ui.clipboard.osc52")
-- vim.g.clipboard = {
-- 	name = "osc52",
-- 	copy = {
-- 		["+"] = osc52.copy("+"),
-- 		["*"] = osc52.copy("*"),
-- 	},
-- 	paste = {
-- 		["+"] = osc52.paste("+"),
-- 		["*"] = osc52.paste("*"),
-- 	},
-- }
--
vim.schedule(function()
	o.clipboard = "unnamedplus"
end)

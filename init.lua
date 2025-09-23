-- Set leader early
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load plugin spec
require("lazy").setup("plugins", {
	ui = { border = "rounded" },
})

require("core.options")
require("core.keymaps")
pcall(require, "core.autocmds")

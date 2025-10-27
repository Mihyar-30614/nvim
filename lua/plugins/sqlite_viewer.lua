return {
	{
		"tpope/vim-dadbod",
		dependencies = {
			"kristijanhusak/vim-dadbod-ui",
			"kristijanhusak/vim-dadbod-completion",
			"kkharji/sqlite.lua",
		},

		cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
		keys = {
			{ "<leader>db", "<cmd>DBUIToggle<CR>", desc = "Toggle Database UI" },
		},

		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
		end,

		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "sql", "mysql", "plsql" },
				callback = function()
					pcall(vim.cmd, "DBUIFindBuffer")
				end,
			})
		end,
	},
}

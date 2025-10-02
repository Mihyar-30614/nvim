return {
	{
		"stevearc/oil.nvim",
		opts = { view_options = { show_hidden = true }, float = { max_width = 0.5, max_height = 0.5 } },
		keys = { { "<leader>tt", "<cmd>Oil --float<cr>", desc = "File browser (Oil)" } },
	},
	-- Alternative: nvim-tree (comment Oil above and uncomment below)
	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	cmd = { "NvimTreeToggle" },
	-- 	opts = {},
	-- 	keys = { { "<leader>tt", "<cmd>NvimTreeToggle<cr>", desc = "Toggle tree" } },
	-- },
}

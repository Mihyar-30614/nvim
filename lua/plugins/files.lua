return {
	{
		"stevearc/oil.nvim",
		lazy = false,
		opts = {
			default_file_explorer = true,
			view_options = { show_hidden = true },
			float = { max_width = 0.5, max_height = 0.5 },
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = { { "<leader>tt", "<cmd>Oil --float<cr>", desc = "File browser (Oil)" } },
	},
}

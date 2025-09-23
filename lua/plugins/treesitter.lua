return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"bash",
				"json",
				"yaml",
				"markdown",
				"javascript",
				"typescript",
				"python",
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}

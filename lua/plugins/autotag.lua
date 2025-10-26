return {
	"windwp/nvim-ts-autotag",
	event = "VeryLazy",
	config = function()
		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Rename paired tag when you edit opening tag
				enable_close_on_slash = true, -- Auto close when typing </
			},
		})
	end,
}

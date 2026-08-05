return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"saghen/blink.lib",
			"rafamadriz/friendly-snippets",
			"kristijanhusak/vim-dadbod-completion",
		},
		opts = {
			keymap = {
				preset = "enter",
			},
			fuzzy = {
				implementation = "lua",
				-- Keep Emmet below ts_ls so JSX props aren't buried by abbreviations
				sorts = {
					function(a, b)
						if (a.client_name == nil or b.client_name == nil) or (a.client_name == b.client_name) then
							return
						end
						return b.client_name == "emmet_language_server"
					end,
					"score",
					"sort_text",
				},
			},
			cmdline = { enabled = true },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				per_filetype = {
					sql = { "dadbod", "buffer" },
					mysql = { "dadbod", "buffer" },
					plsql = { "dadbod", "buffer" },
				},
				providers = {
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
				},
			},
		},
	},
}

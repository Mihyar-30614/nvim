-- blink.cmp v2: requires saghen/blink.lib. Lua fuzzy impl avoids cargo dep.
-- See :h blink-cmp-installation
return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"saghen/blink.lib",
			-- SQL completion source (provides a native blink module)
			"kristijanhusak/vim-dadbod-completion",
		},
		opts = {
			fuzzy = { implementation = "lua" },
			-- Native cmdline completion (replaces old nvim-cmp cmdline setup)
			cmdline = { enabled = true },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				-- SQL buffers: Dadbod first, buffer fallback
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

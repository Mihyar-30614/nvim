-- blink.cmp v2: requires saghen/blink.lib. Lua fuzzy impl avoids cargo dep.
-- See :h blink-cmp-installation
return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"saghen/blink.lib",
		},
		opts = {
			fuzzy = { implementation = "lua" },
		},
	},
}

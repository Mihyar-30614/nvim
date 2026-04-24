-- blink.cmp v2: requires saghen/blink.lib; build downloads the native fuzzy library.
-- See :h blink-cmp-installation
return {
	{
		"saghen/blink.cmp",
		dependencies = { "saghen/blink.lib" },
		build = function()
			require("blink.cmp").build():wait(60000)
		end,
		opts = {},
	},
}

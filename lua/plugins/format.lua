return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>=",
			function()
				require("conform").format({ async = true })
			end,
			mode = { "n", "v" },
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			-- (plus any others you added)
		},
		default_format_opts = { lsp_format = "fallback" },
		format_on_save = function(bufnr)
			if vim.g.conform_format_on_save_enabled == false then
				return
			end
			return { timeout_ms = 500, lsp_format = "fallback" }
		end,
		formatters = { shfmt = { append_args = { "-i", "2" } } },
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}

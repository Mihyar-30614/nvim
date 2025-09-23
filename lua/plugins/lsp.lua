return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		opts = { ensure_installed = { "lua_ls", "ts_ls", "pyright", "bashls", "jsonls", "yamlls" } },
	},
	{
		"neovim/nvim-lspconfig",
		version = "v0.1.8",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = function(_, bufnr)
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end
				map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
				map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
				map("n", "gr", vim.lsp.buf.references, "References")
				map("n", "gi", vim.lsp.buf.implementation, "Implementation")
				map("n", "K", vim.lsp.buf.hover, "Hover")
				map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
				map("n", "[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
				map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
				map("n", "<leader>e", vim.diagnostic.open_float, "Line Diagnostics")
			end

			local lspconfig = require("lspconfig")

			-- Lua
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = { Lua = { diagnostics = { globals = { "vim" } }, workspace = { checkThirdParty = false } } },
			})

			-- Use tsserver explicitly for broad compatibility
			for _, s in ipairs({ "tsserver", "pyright", "bashls", "jsonls", "yamlls" }) do
				lspconfig[s].setup({ capabilities = capabilities, on_attach = on_attach })
			end
		end,
	},
}

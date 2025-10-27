return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"onsails/lspkind.nvim",
			-- Optional here if not installed elsewhere:
			-- "kristijanhusak/vim-dadbod-completion",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				},
				formatting = {
					format = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 40 }),
				},
			})

			-- 💾 SQL-specific completion: Dadbod + buffer/path (buffer-local)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "sql", "mysql", "plsql" },
				callback = function()
					-- Use Dadbod completion + common fallbacks in SQL buffers
					cmp.setup.buffer({
						sources = cmp.config.sources({
							{ name = "vim-dadbod-completion" },
						}, {
							{ name = "buffer" },
							{ name = "path" },
						}),
						completion = { keyword_length = 1 },
					})
					-- Optional: keep omnifunc fallback for plugins/motions
					vim.bo.omnifunc = "vim_dadbod_completion#omni"
				end,
			})
		end,
	},
}

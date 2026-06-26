return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			require("nvim-treesitter").install({
				"bash",
				"diff",
				"html",
				"lua",
				"luadoc",
				"query",
				"vim",
				"vimdoc",
				"angular",
				"typescript",
				"tsx",
				"javascript",
				"json",
				"markdown",
				"markdown_inline",
				"python",
			})

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local bufnr = args.buf
					local ft = vim.bo[bufnr].filetype
					local lang = vim.treesitter.language.get_lang(ft)
					if lang and pcall(vim.treesitter.start, bufnr, lang) then
						vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
}

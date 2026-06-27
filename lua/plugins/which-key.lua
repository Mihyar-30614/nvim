return {
	{
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		opts = {
			delay = 0,
			preset = "helix",
			-- Disable operator/motion/text-object triggers.
			-- These register d/y/c as which-key triggers and re-feed the keys,
			-- causing dd/yy/cc to fire twice.
			plugins = {
				presets = {
					operators = false,
					motions = false,
					text_objects = false,
				},
			},
			win = {
				no_overlap = true,
				padding = { 1, 1 },
				title = true,
				title_pos = "center",
			},
			layout = {
				height = { min = 4, max = 25 }, -- min and max height of the columns
				width = { min = 20, max = 50 }, -- min and max width of the columns
				spacing = 3, -- spacing between columns
				align = "left", -- align columns left, center or right
			},
			icons = {
				mappings = vim.g.have_nerd_font,
				keys = vim.g.have_nerd_font and {} or {
					Up = "<Up> ",
					Down = "<Down> ",
					Left = "<Left> ",
					Right = "<Right> ",
					C = "<C-…> ",
					M = "<M-…> ",
					D = "<D-…> ",
					S = "<S-…> ",
					CR = "<CR> ",
					Esc = "<Esc> ",
					ScrollWheelDown = "<ScrollWheelDown> ",
					ScrollWheelUp = "<ScrollWheelUp> ",
					NL = "<NL> ",
					BS = "<BS> ",
					-- Space = "<Space> ",
					Tab = "<Tab> ",
					F1 = "<F1>",
					F2 = "<F2>",
					F3 = "<F3>",
					F4 = "<F4>",
					F5 = "<F5>",
					F6 = "<F6>",
					F7 = "<F7>",
					F8 = "<F8>",
					F9 = "<F9>",
					F10 = "<F10>",
					F11 = "<F11>",
					F12 = "<F12>",
				},
			},

			-- Group labels only. Leaf descriptions come from each `desc`
			-- set on the real keymaps (which-key reads those automatically),
			-- so duplicating them here is unnecessary.
			spec = {
				{ "<leader>h", group = "Harpoon", icon = { icon = "󰛢", color = "cyan" } },
				{ "<leader>s", group = "Search & Telescope", icon = { icon = "", color = "blue" } },
				{ "<leader>t", group = "File Operations", icon = { icon = "", color = "yellow" } },
				{ "<leader>u", group = "Utilities", icon = { icon = "", color = "orange" } },
				{ "<leader>d", group = "Database", icon = { icon = "", color = "green" } },
				{ "<leader>x", group = "Diagnostics & Troubleshooting", icon = { icon = "", color = "red" } },
				{ "<leader>n", group = "Noice", icon = { icon = "", color = "purple" } },
			},
		},
	},
}

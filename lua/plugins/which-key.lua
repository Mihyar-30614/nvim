return {
	{
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		opts = {
			delay = 0,
			preset = "helix",
			win = {
				no_overlap = true,
				padding = { 1, 1 },
				title = true,
				title_pos = "center",
			},
			layout = {
				height = { min = 4, max = 25 }, -- min and max height of the columns
				width = { min = 20, max = 50 }, -- min and max width of the columns
				spacing = 3,                -- spacing between columns
				align = "left",             -- align columns left, center or right
			},
			icons = {
				mappings = vim.g.have_nerd_font,
				-- keys = vim.g.have_nerd_font and {} or {
				-- 	Up = "<Up> ",
				-- 	Down = "<Down> ",
				-- 	Left = "<Left> ",
				-- 	Right = "<Right> ",
				-- 	C = "<C-…> ",
				-- 	M = "<M-…> ",
				-- 	D = "<D-…> ",
				-- 	S = "<S-…> ",
				-- 	CR = "<CR> ",
				-- 	Esc = "<Esc> ",
				-- 	ScrollWheelDown = "<ScrollWheelDown> ",
				-- 	ScrollWheelUp = "<ScrollWheelUp> ",
				-- 	NL = "<NL> ",
				-- 	BS = "<BS> ",
				-- 	Space = "<Space> ",
				-- 	Tab = "<Tab> ",
				-- 	F1 = "<F1>",
				-- 	F2 = "<F2>",
				-- 	F3 = "<F3>",
				-- 	F4 = "<F4>",
				-- 	F5 = "<F5>",
				-- 	F6 = "<F6>",
				-- 	F7 = "<F7>",
				-- 	F8 = "<F8>",
				-- 	F9 = "<F9>",
				-- 	F10 = "<F10>",
				-- 	F11 = "<F11>",
				-- 	F12 = "<F12>",
				-- },
			},

			-- Document existing key chains with comprehensive organization
			spec = {
				-- Harpoon Group
				{ "<leader>h", group = "🎯 Harpoon" },
				{ "<leader>ha", name = "Add file" },
				{ "<leader>hh", name = "Toggle menu" },
				{ "<leader>hn", name = "Next file" },
				{ "<leader>hp", name = "Previous file" },
				{ "<leader>h1", name = "Go to slot 1" },
				{ "<leader>h2", name = "Go to slot 2" },
				{ "<leader>h3", name = "Go to slot 3" },
				{ "<leader>h4", name = "Go to slot 4" },

				-- Search & Telescope Group
				{ "<leader>s", group = "🔍 Search & Telescope" },
				{ "<leader>sh", name = "Help tags" },
				{ "<leader>sk", name = "Keymaps" },
				{ "<leader>sf", name = "Files" },
				{ "<leader>ss", name = "Telescope pickers" },
				{ "<leader>sw", name = "Current word" },
				{ "<leader>sg", name = "Live grep" },
				{ "<leader>sd", name = "Diagnostics" },
				{ "<leader>sr", name = "Resume search" },
				{ "<leader>s.", name = "Recent files" },
				{ "<leader>s/", name = "Search in open files" },
				{ "<leader>sn", name = "Neovim config files" },
				{ "<leader>/", name = "Buffer search" },
				{ "<leader><leader>", name = "Find buffers" },

				-- File Operations Group
				{ "<leader>t", group = "📁 File Operations" },
				{ "<leader>tt", name = "File browser (Oil)" },
				{ "<leader>tr", name = "Floating terminal" },

				-- Utilities Group
				{ "<leader>u", group = "⚙️ Utilities" },
				{ "<leader>uF", name = "Toggle format on save" },
				{ "<leader>ut", name = "Toggle expandtab (tabs vs spaces)" },
				{ "<leader>u2", name = "Set indent width = 2" },
				{ "<leader>u4", name = "Set indent width = 4" },
				{ "<leader>u8", name = "Set indent width = 8" },

				-- Diagnostics & Troubleshooting
				{ "<leader>x", group = "🔍 Diagnostics & Troubleshooting" },
				{ "<leader>xx", name = "Diagnostics (Trouble)" },
				{ "<leader>xq", name = "Quickfix list" },

				-- Window Navigation
				{ "<C-h>", name = "Left window" },
				{ "<C-l>", name = "Right window" },
				{ "<C-j>", name = "Lower window" },
				{ "<C-k>", name = "Upper window" },

				-- Terminal
				{ "<Esc><Esc>", name = "Exit terminal", mode = "t" },
			},
		},
	},
}

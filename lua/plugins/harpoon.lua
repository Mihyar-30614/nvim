return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = function()
			local keys = {
				{
					"<leader>ha",
					function()
						require("harpoon"):list():add()
					end,
					desc = "Harpoon add",
				},
				{
					"<leader>hh",
					function()
						local h = require("harpoon")
						h.ui:toggle_quick_menu(h:list())
					end,
					desc = "Harpoon menu",
				},
				{
					"<leader>hn",
					function()
						require("harpoon"):list():next()
					end,
					desc = "Harpoon next",
				},
				{
					"<leader>hp",
					function()
						require("harpoon"):list():prev()
					end,
					desc = "Harpoon prev",
				},
			}
			for i = 1, 4 do
				table.insert(keys, {
					"<leader>h" .. i,
					function()
						require("harpoon"):list():select(i)
					end,
					desc = "Harpoon slot " .. i,
				})
			end
			return keys
		end,
		config = function()
			require("harpoon"):setup()
		end,
	},
}

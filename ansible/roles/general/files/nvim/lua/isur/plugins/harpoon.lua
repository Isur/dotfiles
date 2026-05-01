return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local map = require("isur.core.keymap").map
		local harpoon = require("harpoon")

		harpoon:setup({
			settings = {
				save_on_toggle = true,
			},
		})

		map("n", "<leader>hh", function()
			local filename = vim.fn.expand("%:t")
			print(filename .. " - added to harpoon!")
			harpoon:list():add()
		end, { desc = "Harpoon: [h]arpoon [h]old file" })
		map("n", "<leader>h", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Harpoon: [h]arpoon menu" })

		map("n", "<leader>h1", function()
			harpoon:list():select(1)
		end, { desc = "Harpoon: [h]arpoon file [1]" })
		map("n", "<leader>h2", function()
			harpoon:list():select(2)
		end, { desc = "Harpoon: [h]arpoon file [2]" })
		map("n", "<leader>h3", function()
			harpoon:list():select(3)
		end, { desc = "Harpoon: [h]arpoon file [3]" })
		map("n", "<leader>h4", function()
			harpoon:list():select(4)
		end, { desc = "Harpoon: [h]arpoon file [4]" })
		map("n", "<leader>h5", function()
			harpoon:list():select(5)
		end, { desc = "Harpoon: [h]arpoon file [5]" })

		map("n", "<leader>hp", function()
			harpoon:list():prev({ ui_nav_wrap = true })
		end, { desc = "Harpoon: [h]arpoon [p]revious" })
		map("n", "<leader>hn", function()
			harpoon:list():next({ ui_nav_wrap = true })
		end, { desc = "Harpoon: [h]arpoon [n]ext" })
	end,
}

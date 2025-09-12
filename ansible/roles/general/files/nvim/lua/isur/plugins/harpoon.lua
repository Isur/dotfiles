return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local harpoon = require("harpoon")

		harpoon:setup({
			settings = {
				save_on_toggle = true,
			},
		})

		vim.keymap.set("n", "<leader>hh", function()
			local filename = vim.fn.expand("%:t")
			print(filename .. " - added to harpoon!")
			harpoon:list():add()
		end)
		vim.keymap.set("n", "<leader>h", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		vim.keymap.set("n", "<leader>1", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<leader>2", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<leader>3", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<leader>4", function()
			harpoon:list():select(4)
		end)
		vim.keymap.set("n", "<leader>5", function()
			harpoon:list():select(5)
		end)

		vim.keymap.set("n", "<leader><S-Tab>", function()
			harpoon:list():prev({ ui_nav_wrap = true })
		end)
		vim.keymap.set("n", "<leader><Tab>", function()
			harpoon:list():next({ ui_nav_wrap = true })
		end)
	end,
}

return {
	"nvim-lua/plenary.nvim",
	{
		"nvchad/ui",
		config = function()
			require("nvchad")

			vim.keymap.set("n", "<S-TAB>", function()
				require("nvchad.tabufline").prev()
			end, { noremap = true, silent = true, desc = "Buffer previous" })
			vim.keymap.set("n", "<TAB>", function()
				require("nvchad.tabufline").next()
			end, { noremap = true, silent = true, desc = "Buffer next" })

			vim.keymap.set("n", "<leader>x", function()
				require("nvchad.tabufline").close_buffer()
			end, { noremap = true, silent = true, desc = "Close buffer" })

			vim.keymap.set("n", "<leader>X", function()
				require("nvchad.tabufline").closeAllBufs(false)
			end, { noremap = true, silent = true, desc = "Close buffer" })

			vim.keymap.set("n", "<leader>xp", function()
				require("nvchad.tabufline").closeBufs_at_direction("left")
			end, { noremap = true, silent = true, desc = "Close buffer on left" })

			vim.keymap.set("n", "<leader>xn", function()
				require("nvchad.tabufline").closeBufs_at_direction("right")
			end, { noremap = true, silent = true, desc = "Close buffer on right" })

			vim.cmd.colorscheme("nvchad")
		end,
	},
	{
		"nvchad/base46",
		lazy = true,
		build = function()
			require("base46").load_all_highlights()
		end,
	},
}

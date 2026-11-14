local keymap = require("isur.core.keymap")

return {
	{
		"MagicDuck/grug-far.nvim",
		cmd = { "GrugFar", "GrugFarWithin" },
		opts = {},
		keys = {
			keymap.lazy("<leader>S", function()
				require("grug-far").toggle_instance({ instanceName = "main", staticTitle = "Find and Replace" })
			end, { desc = "Search: [S]earch and replace toggle" }),
			keymap.lazy("<leader>sw", function()
				require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
			end, { desc = "Search: [s]earch current [w]ord" }),
			keymap.lazy("<leader>sw", function()
				require("grug-far").with_visual_selection()
			end, { mode = "x", desc = "Search: [s]earch current [w]ord" }),
			keymap.lazy("<leader>sp", function()
				require("grug-far").open({
					prefills = { search = vim.fn.expand("<cword>"), paths = vim.fn.expand("%") },
				})
			end, { desc = "Search: [s]earch current file [p]roject" }),
		},
	},
}

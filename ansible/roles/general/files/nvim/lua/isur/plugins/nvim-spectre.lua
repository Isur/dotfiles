return {
	"nvim-pack/nvim-spectre",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local map = require("isur.core.keymap").map
		if vim.loop.os_uname().sysname == "Darwin" then
			-- This will fix problem with MacOS creating -E backup files
			-- https://github.com/nvim-pack/nvim-spectre/issues/118
			require("spectre").setup({
				replace_engine = {
					["sed"] = {
						cmd = "sed",
						args = {
							"-i",
							"",
							"-E",
						},
					},
				},
			})
		end

		map("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
			desc = "Search: [S]pectre toggle",
		})
		map("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
			desc = "Search: [s]earch current [w]ord",
		})
		map("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
			desc = "Search: [s]earch current [w]ord",
		})
		map("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
			desc = "Search: [s]earch current file [p]roject",
		})
	end,
}

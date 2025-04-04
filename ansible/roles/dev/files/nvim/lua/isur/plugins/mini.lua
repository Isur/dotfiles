return {
	"echasnovski/mini.nvim",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	version = false,
	config = function()
		require("mini.ai").setup({})
		require("mini.comment").setup({
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
				end,
			},
		})
		require("mini.cursorword").setup()
		require("mini.pairs").setup()
		require("mini.surround").setup({
			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				replace = "gsr", -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`
			},
		})
		require("mini.trailspace").setup()
	end,
}

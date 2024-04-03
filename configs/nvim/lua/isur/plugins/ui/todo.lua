return {
	"folke/todo-comments.nvim",
	requires = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		-- Usage:
		-- HACK:
		-- BUG:
		-- TODO:
		-- NOTE:
		-- FIXME:
		-- FIX:
		-- FIXIT:
		-- WARN:
		-- TEST:
		require("todo-comments").setup({})
	end,
}

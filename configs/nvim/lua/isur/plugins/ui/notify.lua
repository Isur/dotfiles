return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({})

		vim.keymap.set("n", "<leader>nd", '<cmd>lua require("notify").dismiss()<CR>', {
			desc = "Dismiss notification",
		})
	end,
}

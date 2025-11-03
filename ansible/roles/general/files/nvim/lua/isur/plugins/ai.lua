return {
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({
				condition = function()
					return vim.env.NVIM_SUPERMAVEN == "off"
				end,
			})
		end,
	},
}

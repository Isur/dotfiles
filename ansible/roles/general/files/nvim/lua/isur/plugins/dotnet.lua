return {
	{
		"GustavEikaas/easy-dotnet.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap" },
		config = function()
			require("easy-dotnet").setup({
				test_runner = { neotest_integration = true },
			})
		end,
	},
}

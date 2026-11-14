return {
	{
		"GustavEikaas/easy-dotnet.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap" },
		ft = { "cs", "fsharp", "vb", "razor" },
		cmd = { "Dotnet" },
		config = function()
			require("easy-dotnet").setup({
				test_runner = { neotest_integration = true },
			})
		end,
	},
}

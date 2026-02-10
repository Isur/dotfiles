return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			{ "fredrikaverpil/neotest-golang", version = "v1.15.1" },
			{ "nsidorenco/neotest-vstest" },
		},
		config = function()
			local neotest_golang_opts = {}
			vim.g.neotest_vstest = vim.tbl_deep_extend("force", vim.g.neotest_vstest or {}, {
				dap_settings = {
					type = "netcoredbg",
				},
			})

			require("neotest").setup({
				adapters = {
					require("neotest-golang")(neotest_golang_opts),
					require("neotest-vstest"),
				},
			})
		end,
		keys = {
			{
				"<leader>tf",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "[t]est run [f]ile",
			},
			{
				"<leader>tt",
				function()
					require("neotest").run.run({ suite = false })
				end,
				desc = "[t]est run [t]est",
			},
			{
				"<leader>tS",
				function()
					require("neotest").run.run({ suite = true })
				end,
				desc = "[t]est [S]uite",
			},
			{
				"<leader>tl",
				function()
					require("neotest").run.run_last()
				end,
				desc = "[t]est [l]ast",
			},
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "[t]est [s]ummary",
			},
			{
				"<leader>to",
				function()
					require("neotest").output.open({ enter = true, auto_close = true })
				end,
				desc = "[t]est [o]utput",
			},
			{
				"<leader>tO",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "[t]est [O]utput panel",
			},
			{
				"<leader>tT",
				function()
					require("neotest").run.stop()
				end,
				desc = "[t]est [t]erminate",
			},
			{
				"<leader>td",
				function()
					require("neotest").run.run({ suite = false, strategy = "dap" })
				end,
				desc = "Debug nearest test",
			},
			{
				"<leader>tD",
				function()
					require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap", suite = false })
				end,
				desc = "Debug current file",
			},
		},
	},
}

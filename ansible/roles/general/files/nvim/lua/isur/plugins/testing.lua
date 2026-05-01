local keymap = require("isur.core.keymap")

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
			keymap.lazy("<leader>tf", function()
					require("neotest").run.run(vim.fn.expand("%"))
				end, { desc = "Test: [t]est run [f]ile" }),
			keymap.lazy("<leader>tt", function()
					require("neotest").run.run({ suite = false })
				end, { desc = "Test: [t]est run [t]est" }),
			keymap.lazy("<leader>tS", function()
					require("neotest").run.run({ suite = true })
				end, { desc = "Test: [t]est [S]uite" }),
			keymap.lazy("<leader>tl", function()
					require("neotest").run.run_last()
				end, { desc = "Test: [t]est [l]ast" }),
			keymap.lazy("<leader>ts", function()
					require("neotest").summary.toggle()
				end, { desc = "Test: [t]est [s]ummary" }),
			keymap.lazy("<leader>to", function()
					require("neotest").output.open({ enter = true, auto_close = true })
				end, { desc = "Test: [t]est [o]utput" }),
			keymap.lazy("<leader>tO", function()
					require("neotest").output_panel.toggle()
				end, { desc = "Test: [t]est [O]utput panel" }),
			keymap.lazy("<leader>tT", function()
					require("neotest").run.stop()
				end, { desc = "Test: [t]est [t]erminate" }),
			keymap.lazy("<leader>td", function()
				require("neotest").run.run({ suite = false, strategy = "dap" })
				end, { desc = "Test: [t]est [d]ebug nearest" }),
			keymap.lazy("<leader>tD", function()
				require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap", suite = false })
				end, { desc = "Test: [t]est [D]ebug file" }),
		},
	},
}

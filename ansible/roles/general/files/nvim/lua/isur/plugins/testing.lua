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
			"GustavEikaas/easy-dotnet.nvim",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-jest",
			"marilari88/neotest-vitest",
			"mfussenegger/nvim-dap",
		},
		config = function()
			local neotest_golang_opts = {}

			require("neotest").setup({
				adapters = {
					require("neotest-golang")(neotest_golang_opts),
					require("easy-dotnet.neotest"),
					require("neotest-python")({}),
					require("neotest-jest")({}),
					require("neotest-vitest")({}),
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
				-- easy-dotnet resolves a directory run only when it is a .csproj folder; any other
				-- directory (e.g. the cwd suite root) never reports completion and blocks its run queue.
				local csproj = vim.fs.find(function(name)
					return name:match("%.csproj$") ~= nil
				end, { path = vim.fn.expand("%:p:h"), upward = true })[1]
				if csproj then
					require("neotest").run.run(vim.fs.dirname(csproj))
				else
					require("neotest").run.run({ suite = true })
				end
			end, { desc = "Test: [t]est [S]uite (.NET: current project)" }),
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

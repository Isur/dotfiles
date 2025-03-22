return {
	{
		"mfussenegger/nvim-dap",
	},
	{
		"leoluz/nvim-dap-go",
		config = function()
			local dapgo = require("dap-go")
			dapgo.setup()
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup()
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set("n", "<leader>dc", function()
				require("dap").continue()
			end, { desc = "Continue execution" })
			vim.keymap.set("n", "<Leader>db", function()
				require("dap").toggle_breakpoint()
			end, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<Leader>dr", function()
				require("dap").repl.open()
			end, { desc = "Open REPL" })

			vim.keymap.set("n", "<Leader>dw", function()
				dapui.open()
			end, { desc = "Open DAP UI" })
			vim.keymap.set("n", "<Leader>dW", function()
				dapui.close()
			end, { desc = "Close DAP UI" })
		end,
	},
}

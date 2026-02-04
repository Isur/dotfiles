return {
	{
		"mfussenegger/nvim-dap",
		dependencies = { "leoluz/nvim-dap-go" },
		config = function()
			local dap = require("dap")
			local dapgo = require("dap-go")
			dapgo.setup()

			dap.adapters["pwa-node"] = {
				type = "server",
				host = "::1",
				port = "${port}",
				executable = {
					command = "js-debug-adapter",
					args = {
						"${port}",
					},
				},
			}

			dap.adapters.delve = {
				type = "server",
				port = "2345",
				executable = {
					command = "dlv",
					args = { "dap", "-l", "127.0.0.1:2345" },
				},
			}
			dap.configurations.go = {
				{
					type = "delve",
					name = "Attach to running process",
					request = "attach",
					mode = "remote",
					port = "2345",
				},
			}

			for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
				dap.configurations[language] = {
					{
						name = "Next.js: debug server-side",
						type = "pwa-node",
						request = "attach",
						port = 9230,
						skipFiles = { "<node_internals>/**", "node_modules/**" },
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach to Node app",
						address = "localhost",
						port = 9229,
						cwd = "${workspaceFolder}",
						restart = true,
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
						runtimeExecutable = "node",
					},
				}
			end
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

			vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "error" })

			vim.keymap.set("n", "<leader>dc", function()
				dap.continue()
			end, { desc = "Continue execution" })
			vim.keymap.set("n", "<Leader>db", function()
				dap.toggle_breakpoint()
			end, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<Leader>dr", function()
				dap.repl.open()
			end, { desc = "Open REPL" })
			vim.keymap.set("n", "<leader>do", function()
				dap.step_over()
			end, { desc = "Step over" })
			vim.keymap.set("n", "<leader>di", function()
				dap.step_into()
			end, { desc = "Step into" })
			vim.keymap.set("n", "<leader>du", function()
				dap.step_out()
			end, { desc = "Step out" })
			vim.keymap.set("n", "<leader>dC", function()
				dap.clear_breakpoints()
			end, { desc = "Clear breakpoints" })
			vim.keymap.set("n", "<Leader>dw", function()
				dapui.open()
			end, { desc = "Open DAP UI" })
			vim.keymap.set("n", "<Leader>dW", function()
				dapui.close()
			end, { desc = "Close DAP UI" })
		end,
	},
}

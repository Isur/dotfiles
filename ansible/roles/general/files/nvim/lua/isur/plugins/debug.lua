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

			dap.adapters["netcoredbg"] = {
				type = "executable",
				command = "netcoredbg",
				args = { "--interpreter=vscode" },
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
			local map = require("isur.core.keymap").map
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

			map("n", "<leader>dc", function()
				dap.continue()
			end, { desc = "Debug: [d]ebug [c]ontinue" })
			map("n", "<leader>db", function()
				dap.toggle_breakpoint()
			end, { desc = "Debug: [d]ebug [b]reakpoint toggle" })
			map("n", "<leader>dr", function()
				dap.repl.open()
			end, { desc = "Debug: [d]ebug [r]epl" })
			map("n", "<leader>do", function()
				dap.step_over()
			end, { desc = "Debug: [d]ebug step [o]ver" })
			map("n", "<leader>di", function()
				dap.step_into()
			end, { desc = "Debug: [d]ebug step [i]nto" })
			map("n", "<leader>du", function()
				dap.step_out()
			end, { desc = "Debug: [d]ebug step o[u]t" })
			map("n", "<leader>dC", function()
				dap.clear_breakpoints()
			end, { desc = "Debug: [d]ebug [C]lear breakpoints" })
			map("n", "<leader>dw", function()
				dapui.open()
			end, { desc = "Debug: [d]ebug ui open [w]" })
			map("n", "<leader>dW", function()
				dapui.close()
			end, { desc = "Debug: [d]ebug ui close [W]" })
		end,
	},
}

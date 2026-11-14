local keymap = require("isur.core.keymap")

---@param method string
local function dap_call(method)
	return function()
		require("dap")[method]()
	end
end

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"mfussenegger/nvim-dap-python",
			{ "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
		},
		keys = {
			keymap.lazy("<leader>dc", dap_call("continue"), { desc = "Debug: [d]ebug [c]ontinue" }),
			keymap.lazy("<leader>db", dap_call("toggle_breakpoint"), { desc = "Debug: [d]ebug [b]reakpoint toggle" }),
			keymap.lazy("<leader>dr", function()
				require("dap").repl.open()
			end, { desc = "Debug: [d]ebug [r]epl" }),
			keymap.lazy("<leader>do", dap_call("step_over"), { desc = "Debug: [d]ebug step [o]ver" }),
			keymap.lazy("<leader>di", dap_call("step_into"), { desc = "Debug: [d]ebug step [i]nto" }),
			keymap.lazy("<leader>du", dap_call("step_out"), { desc = "Debug: [d]ebug step o[u]t" }),
			keymap.lazy("<leader>dC", dap_call("clear_breakpoints"), { desc = "Debug: [d]ebug [C]lear breakpoints" }),
			keymap.lazy("<leader>dw", function()
				require("dapui").open()
			end, { desc = "Debug: [d]ebug ui open [w]" }),
			keymap.lazy("<leader>dW", function()
				require("dapui").close()
			end, { desc = "Debug: [d]ebug ui close [W]" }),
		},
		config = function()
			local dap = require("dap")
			local dapgo = require("dap-go")
			dapgo.setup()
			require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")

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

			-- Attach to an existing `dlv dap --listen=127.0.0.1:2345` server.
			dap.adapters["go-remote"] = { type = "server", host = "127.0.0.1", port = 2345 }
			table.insert(dap.configurations.go, {
				type = "go-remote",
				name = "Attach to remote Delve",
				request = "attach",
				mode = "remote",
			})

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

			local dapui = require("dapui")
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
		end,
	},
}

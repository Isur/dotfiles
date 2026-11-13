return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "Format" },
		config = function()
			local map = require("isur.core.keymap").map
			local conform = require("conform")
			local web_formatters = { "oxfmt", "prettierd", stop_after_first = true, lsp_format = "never" }

			conform.setup({
				default_format_opts = { lsp_format = "fallback" },
				formatters = {
					oxfmt_force = { inherit = "oxfmt", require_cwd = false },
					oxfmt = {
						-- A Mason installation alone must not select Oxfmt for every project.
						require_cwd = true,
					},
					prettierd = {
						require_cwd = true,
						env = {
							PRETTIERD_LOCAL_PRETTIER_ONLY = "true",
						},
					},
				},
				formatters_by_ft = {
					astro = { "prettierd", lsp_format = "never" },
					javascript = web_formatters,
					typescript = web_formatters,
					javascriptreact = web_formatters,
					typescriptreact = web_formatters,
					css = web_formatters,
					html = web_formatters,
					json = web_formatters,
					jsonc = web_formatters,
					yaml = web_formatters,
					graphql = web_formatters,
					lua = { "stylua" },
					python = { "ruff_format" },
					cpp = { "clang_format" },
					ino = { "clang_format" },
					go = { "gofmt" },
					["markdown"] = web_formatters,
					["markdown.mdx"] = web_formatters,
				},
				format_on_save = vim.env.NVIM_FORMAT ~= "off" and {
					async = false,
					timeout_ms = 500,
				} or nil,
			})

			vim.api.nvim_create_user_command("Format", function(opts)
				if not opts.bang and vim.env.NVIM_FORMAT == "off" then
					return
				end
				local formatters = conform.formatters_by_ft[vim.bo.filetype]
				local force_oxfmt = opts.bang
					and formatters == web_formatters
					and #conform.list_formatters_to_run(0) == 0
				conform.format({
					formatters = force_oxfmt and { "oxfmt_force" } or nil,
					timeout_ms = 1000,
				})
			end, { bang = true, desc = "Format buffer; ! ignores NVIM_FORMAT and allows Oxfmt fallback" })

			if vim.env.NVIM_FORMAT == "off" then
				return
			end

			map({ "n", "v" }, "<leader>cf", function()
				conform.format({
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Code: [c]ode [f]ormat" })

			vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
		end,
	},
}

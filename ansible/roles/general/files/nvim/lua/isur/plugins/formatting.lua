return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.env.ESLINT_D_PPID = vim.fn.getpid()
			local lint = require("lint")
			lint.linters_by_ft = {
				python = { "ruff" },
			}
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters = {
					prettierd = {
						env = {
							PRETTIERD_LOCAL_PRETTIER_ONLY = "true",
						},
					},
					["markdown-toc"] = {
						condition = function(_, ctx)
							for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
								if line:find("<!%-%- toc %-%->") then
									return true
								end
								return false
							end
						end,
					},
					["markdownlint-cli2"] = {
						condition = function(_, ctx)
							local diag = vim.tbl_filter(function(d)
								return d.source == "markdownlint"
							end, vim.diagnostic.get(ctx.buf))
							return #diag > 0
						end,
					},
				},
				formatters_by_ft = {
					javascript = { "prettierd" },
					typescript = { "prettierd" },
					javascriptreact = { "prettierd" },
					typescriptreact = { "prettierd" },
					css = { "prettierd" },
					html = { "prettierd" },
					json = { "jq" },
					yaml = { "prettierd" },
					graphql = { "prettierd" },
					lua = { "stylua" },
					python = { "ruff_format" },
					cpp = { "clang_format" },
					ino = { "clang_format" },
					go = { "gofmt" },
					["markdown"] = { "prettierd", "markdownlint-cli2", "markdown-toc" },
					["markdown.mdx"] = { "prettierd", "markdownlint-cli2", "markdown-toc" },
				},
				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>cf", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Format file or range in visualmode" })

			vim.bo.formatexpr = "v:lua.require’conform’.formatexpr()"
		end,
	},
}

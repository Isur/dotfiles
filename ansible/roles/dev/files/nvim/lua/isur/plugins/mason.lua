return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		opts = {},
		config = function(_, opts)
			local mason = require("mason")
			local mason_tool_installer = require("mason-tool-installer")

			mason.setup({})

			mason_tool_installer.setup({
				ensure_installed = {
					-- LSPs
					"typescript-language-server",
					"tailwindcss-language-server",
					"dockerfile-language-server",
					"bash-language-server",
					"docker-compose-language-service",
					"css-lsp",
					"html-lsp",
					"lua-language-server",
					"emmet-language-server",
					"arduino-language-server",
					"clangd",
					"ansible-language-server",
					"marksman",
					"gopls",
					"pyright",
					"json-lsp",
					"eslint-lsp",
					-- Linters
					"ruff",
					"ansible-lint",
					"markdownlint-cli2",
					-- Formatters
					"prettierd",
					"stylua",
					"clang-format",
					"jq",
					"markdown-toc",
					-- DAP
					"delve",
					"js-debug-adapter",
				},
				automatic_installation = true,
			})
		end,
	},
}

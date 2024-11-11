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
					"python-lsp-server",
					"tailwindcss-language-server",
					"dockerfile-language-server",
					"bash-language-server",
					"docker-compose-language-service",
					"css-lsp",
					"html-lsp",
					"lua-language-server",
					"emmet-language-server",
					"eslint-lsp",
					"arduino-language-server",
					"clangd",
					"ansible-language-server",
					"marksman",
					-- Linters
					"eslint_d",
					"flake8",
					"ruff",
					"ansible-lint",
					"markdownlint-cli2",
					-- Formatters
					"black",
					"prettierd",
					"stylua",
					"isort",
					"clang-format",
					"jq",
					"markdown-toc",
				},
				automatic_installation = true,
			})
		end,
	},
}
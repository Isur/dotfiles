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
					"docker-compose-language-service",
					"css-lsp",
					"html-lsp",
					"lua-language-server",
					"emmet-language-server",
					-- Linters
					"eslint_d",
					"flake8",
					-- Formatters
					"black",
					"prettierd",
					"stylua",
					"isort",
				},
				automatic_installation = true,
			})
		end,
	},
}

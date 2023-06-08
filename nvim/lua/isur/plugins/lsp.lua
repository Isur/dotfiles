return {
	"jose-elias-alvarez/null-ls.nvim",
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{
				'williamboman/mason.nvim',
				cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
				opts = {
					ensure_installed = {
						"black",
						"mypy",
						"ruff",
						"debugpy",
						"typescript-language-server",
						"css-lsp",
						"eslint-lsp",
						"lua-language-server",
						"python-lsp-server",
					},
				},
				config = function(_, opts)
				require("mason").setup(opts)
					vim.api.nvim_create_user_command("MasonInstallAll", function()
						vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
					end, {})
					vim.g.mason_binaries_list = opts.ensure_installed
				end
			},
			'williamboman/mason-lspconfig.nvim',

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ 'j-hui/fidget.nvim', opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			'folke/neodev.nvim',
		},
	}
}

vim.lsp.enable({
	"gopls",
	"lua_ls",
	"arduino_language_server",
	"tailwindcss",
	"cssls",
	"dockerls",
	"docker_compose_language_service",
	"bashls",
	"html",
	"ruff",
	"clangd",
	"emmet_language_server",
	"ansiblels",
	"marksman",
	"jsonls",
	"vtsls",
	"pyright",
})

if vim.env.NVIM_LINT ~= "off" then
	vim.lsp.enable("eslint")
end

vim.diagnostic.config({
	virtual_lines = false,
	float = {
		source = true,
	},
})

local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
vim.diagnostic.config({
	signs = {
		active = true,
		text = {
			[vim.diagnostic.severity.ERROR] = signs.Error,
			[vim.diagnostic.severity.WARN] = signs.Warn,
			[vim.diagnostic.severity.HINT] = signs.Hint,
			[vim.diagnostic.severity.INFO] = signs.Info,
		},
	},
})

local map = require("isur.core.keymap").map

vim.lsp.enable({
	"gopls",
	"lua_ls",
	"arduino_language_server",
	"angularls",
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

local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
vim.diagnostic.config({
	virtual_lines = false,
	float = {
		source = true,
	},
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

-- Attach to LSP
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local nmap = function(keys, func, desc)
			if desc then
				if not desc:match("^Diag:") then
					desc = "LSP: " .. desc
				end
			end

			map("n", keys, func, { buffer = event.buf, desc = desc })
		end

		nmap("<leader>la", vim.lsp.buf.code_action, "[l]sp code [a]ction")
		nmap("<leader>ld", function()
			Snacks.picker.lsp_definitions()
		end, "[l]sp [d]efinition")
		nmap("<leader>lr", function()
			Snacks.picker.lsp_references()
		end, "[l]sp [r]eferences")
		nmap("<leader>li", function()
			Snacks.picker.lsp_implementations()
		end, "[l]sp [i]mplementation")
		nmap("<leader>lD", function()
			Snacks.picker.lsp_type_definitions()
		end, "[l]sp type [D]efinition")
		nmap("<leader>dn", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, "Diag: [d]iagnostic [n]ext")
		nmap("<leader>dp", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, "Diag: [d]iagnostic [p]revious")
		nmap("<leader>df", vim.diagnostic.open_float, "Diag: [d]iagnostic [f]loat")
		nmap("<leader>lR", vim.lsp.buf.rename, "[l]sp [R]ename")

		nmap("<leader>lh", vim.lsp.buf.hover, "[l]sp [h]over")

		nmap("<leader>lq", function()
			Snacks.picker.lsp_declarations()
		end, "[l]sp declaration [q]")

		nmap("<leader>lwa", vim.lsp.buf.add_workspace_folder, "[l]sp [w]orkspace [a]dd")
		nmap("<leader>lwr", vim.lsp.buf.remove_workspace_folder, "[l]sp [w]orkspace [r]emove")
		nmap("<leader>lwl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "[l]sp [w]orkspace [l]ist")

		vim.api.nvim_buf_create_user_command(event.buf, "Format", function(_)
			vim.lsp.buf.format()
		end, { desc = "Format current buffer with LSP" })
	end,
})

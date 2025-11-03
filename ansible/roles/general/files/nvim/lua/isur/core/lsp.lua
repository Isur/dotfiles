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
				desc = "LSP: " .. desc
			end

			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
		end

		nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
		nmap("gd", function()
			Snacks.picker.lsp_definitions()
		end, "Goto Definition")
		nmap("gr", function()
			Snacks.picker.lsp_references()
		end, "Goto References")
		nmap("gI", function()
			Snacks.picker.lsp_implementations()
		end, "Goto Implementation")
		nmap("<leader>D", function()
			Snacks.picker.lsp_type_definitions()
		end, "Goto Type Definition")
		nmap("[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, "Go to previous diagnostic message")
		nmap("]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, "Go to next diagnostic message")
		nmap("dp", vim.diagnostic.open_float, "Open diagnostic message in float window")
		nmap("<leader>rn", vim.lsp.buf.rename, "Rename")

		nmap("K", vim.lsp.buf.hover, "Hover Documentation")

		nmap("gD", function()
			Snacks.picker.lsp_declarations()
		end, "Goto Declaration")

		nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
		nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
		nmap("<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "Workspace List Folders")

		vim.api.nvim_buf_create_user_command(event.buf, "Format", function(_)
			vim.lsp.buf.format()
		end, { desc = "Format current buffer with LSP" })
	end,
})

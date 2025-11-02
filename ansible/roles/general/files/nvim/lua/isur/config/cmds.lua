-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	pattern = "*",
})

vim.api.nvim_create_user_command("Spellcheck", function()
	vim.o.spell = not vim.o.spell
end, {})

local virtual_text_enabled = false
local virtual_lines_enabled = false
vim.api.nvim_create_user_command("DiagnosticVirtualText", function()
	virtual_text_enabled = not virtual_text_enabled
	vim.diagnostic.config({
		virtual_text = virtual_text_enabled,
	})
	print("Virtual Text is now " .. (virtual_text_enabled and "enabled" or "disabled"))
end, {})
vim.api.nvim_create_user_command("DiagnosticVirtualLines", function()
	virtual_lines_enabled = not virtual_lines_enabled
	vim.diagnostic.config({
		virtual_lines = virtual_lines_enabled,
	})
	print("Virtual Lines is now " .. (virtual_lines_enabled and "enabled" or "disabled"))
end, {})

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
		nmap("gd", vim.lsp.buf.definition, "Goto Definition")
		nmap("gr", vim.lsp.buf.references, "Goto References")
		nmap("gI", vim.lsp.buf.implementation, "Goto Implementation")
		nmap("<leader>D", vim.lsp.buf.type_definition, "Type Definition")
		nmap("[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, "Go to previous diagnostic message")
		nmap("]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, "Go to next diagnostic message")
		nmap("dp", vim.diagnostic.open_float, "Open diagnostic message in float window")
		nmap("<leader>rn", vim.lsp.buf.rename, "Rename")

		nmap("K", vim.lsp.buf.hover, "Hover Documentation")

		nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
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

local lint = require("lint")
if vim.env.NVIM_LINT ~= "off" then
	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		group = vim.api.nvim_create_augroup("lint", { clear = true }),
		callback = function()
			lint.try_lint()
		end,
	})
end

vim.api.nvim_buf_create_user_command(vim.api.nvim_get_current_buf(), "Lint", function()
	lint.try_lint()
end, { desc = "Trigger linting for current file" })

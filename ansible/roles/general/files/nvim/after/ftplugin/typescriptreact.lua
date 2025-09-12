local buf = vim.api.nvim_get_current_buf()
vim.api.nvim_buf_create_user_command(buf, "ImportAll", function()
	vim.lsp.buf.code_action({
		apply = true,
		context = {
			only = { "source.addMissingImports.ts" },
			diagnostics = vim.diagnostic.get(buf),
		},
	})
end, {})

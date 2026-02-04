-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	pattern = "*",
})

-- Spellcheck toggle
vim.api.nvim_create_user_command("Spellcheck", function()
	vim.o.spell = not vim.o.spell
end, {})

-- Virtual text toggle
local virtual_text_enabled = false
vim.api.nvim_create_user_command("DiagnosticVirtualText", function()
	virtual_text_enabled = not virtual_text_enabled
	vim.diagnostic.config({
		virtual_text = virtual_text_enabled,
	})
	print("Virtual Text is now " .. (virtual_text_enabled and "enabled" or "disabled"))
end, {})

-- Virtual lines toggle
local virtual_lines_enabled = false
vim.api.nvim_create_user_command("DiagnosticVirtualLines", function()
	virtual_lines_enabled = not virtual_lines_enabled
	vim.diagnostic.config({
		virtual_lines = virtual_lines_enabled,
	})
	print("Virtual Lines is now " .. (virtual_lines_enabled and "enabled" or "disabled"))
end, {})

-- Change file format to unix always
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufWritePre" }, {
	pattern = "*",
	callback = function()
		vim.bo.fileformat = "unix"
	end,
})

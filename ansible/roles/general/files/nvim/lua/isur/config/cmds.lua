-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
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

-- Virtual lines toggle: current line only (default) <-> every line
local virtual_lines_all = false
vim.api.nvim_create_user_command("DiagnosticVirtualLines", function()
	virtual_lines_all = not virtual_lines_all
	vim.diagnostic.config({
		virtual_lines = virtual_lines_all or { current_line = true },
	})
	print("Virtual Lines now shown on " .. (virtual_lines_all and "every line" or "the current line only"))
end, {})

_G.lazygit_open_file = function(filename, line)
	if not filename or filename == "" then
		return
	end

	pcall(vim.api.nvim_win_close, 0, true)
	vim.cmd.edit(vim.fn.fnameescape(filename))

	local line_number = tonumber(line)
	if line_number and line_number > 0 then
		pcall(vim.api.nvim_win_set_cursor, 0, { line_number, 0 })
	end
end

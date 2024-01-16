return {
	"github/copilot.vim",
	"ofseed/lualine-copilot",
	config = function()
		vim.api.nvim_set_keymap("i", "<C-c>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
	end,
}

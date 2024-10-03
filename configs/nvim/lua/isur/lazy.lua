-- Install Package Manager
-- Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- NVCHAD UI
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

-- Setup Lazy
require("lazy").setup({
	{ import = "isur.plugins.utils" },
	{ import = "isur.plugins.code" },
	{ import = "isur.plugins.ui" },
	{ import = "isur.plugins.mini" },
})

for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
	dofile(vim.g.base46_cache .. v)
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"windwp/nvim-ts-autotag",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		build = ":TSUpdate",
		branch = "main",
		config = function()
			local map = require("isur.core.keymap").map
			local context = require("treesitter-context")
			local install_dir = vim.fn.stdpath("data") .. "/site"
			local languages = {
				"lua",
				"python",
				"tsx",
				"typescript",
				"vimdoc",
				"vim",
				"arduino",
				"bash",
				"dockerfile",
				"gitignore",
				"graphql",
				"html",
				"json",
				"markdown",
				"prisma",
				"sql",
				"javascript",
				"cpp",
				"http",
				"go",
				"latex",
				"regex",
				"yaml",
				"css",
				"norg",
				"scss",
				"svelte",
				"typst",
				"vue",
			}

			vim.opt.rtp:prepend(install_dir)
			require("nvim-treesitter").setup({
				install_dir = install_dir,
			})
			context.setup({ enable = false })

			map("n", "[c", function()
				context.go_to_context(vim.v.count1)
			end, { silent = true, desc = "Context: [c]ontext go" })

			map("n", "]c", function()
				context.toggle()
			end, { silent = true, desc = "Context: [c]ontext toggle" })

			vim.api.nvim_create_autocmd("FileType", {
				pattern = languages,
				callback = function(args)
					vim.treesitter.start(args.buf)
					vim.api.nvim_set_option_value("foldexpr", "v:lua.vim.treesitter.foldexpr()", { win = 0 })
					vim.api.nvim_set_option_value("foldmethod", "expr", { win = 0 })
					if vim.bo[args.buf].filetype ~= "python" then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})

			require("ts_context_commentstring").setup({})
			require("nvim-ts-autotag").setup()
		end,
	},
}

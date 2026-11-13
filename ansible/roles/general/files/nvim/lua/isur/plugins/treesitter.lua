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
				"astro",
				"lua",
				"python",
				"c_sharp",
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
				"markdown_inline",
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
				"scss",
				"svelte",
				"typst",
				"vue",
			}

			vim.api.nvim_create_user_command("TSInstallAllMyLangs", function()
				require("nvim-treesitter").install(languages):wait(300000)
			end, { desc = "Install all configured treesitter languages" })

			vim.opt.rtp:prepend(install_dir)
			require("nvim-treesitter").setup({
				install_dir = install_dir,
			})
			context.setup({ enable = false })
			local aliases = {
				tsx = { "typescriptreact" },
				javascript = { "javascriptreact" },
				c_sharp = { "cs" },
				bash = { "sh" },
				latex = { "tex", "plaintex" },
				vimdoc = { "help" },
			}
			for language, filetypes in pairs(aliases) do
				vim.treesitter.language.register(language, filetypes)
			end

			map("n", "[c", function()
				context.go_to_context(vim.v.count1)
			end, { silent = true, desc = "Context: [c]ontext go" })

			map("n", "]c", function()
				context.toggle()
			end, { silent = true, desc = "Context: [c]ontext toggle" })

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function(args)
					local language = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
					if not vim.tbl_contains(languages, language) then
						return
					end
					-- Missing parsers must not abort FileType hooks on a fresh install.
					if not pcall(vim.treesitter.start, args.buf) then
						return
					end
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

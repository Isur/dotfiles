return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
			"windwp/nvim-ts-autotag",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter.configs")
			local context = require("treesitter-context")
			context.setup({ enable = false })

			vim.keymap.set("n", "[c", function()
				context.go_to_context(vim.v.count1)
			end, { silent = true, desc = "Go to context" })

			vim.keymap.set("n", "]c", function()
				context.toggle()
			end, { silent = true, desc = "Go to context" })

			treesitter.setup({
				ignore_install = {},
				modules = {},
				sync_install = false,
				ensure_installed = {
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
				},
				auto_install = false,
				highlight = { enable = true },
				indent = { enable = true, disable = { "python" } },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = "<C-s>",
						node_decremental = "<M-space>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
				},
			})
			require("ts_context_commentstring").setup({})
			require("nvim-ts-autotag").setup()
		end,
	},
}

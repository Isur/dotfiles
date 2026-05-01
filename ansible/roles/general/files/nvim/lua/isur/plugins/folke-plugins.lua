local keymap = require("isur.core.keymap")

return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			keymap.lazy("s", function()
				require("flash").jump()
			end, {
				mode = { "n", "x", "o" },
				desc = "Motion: fla[s]h jump",
			}),
			keymap.lazy("S", function()
				require("flash").treesitter()
			end, {
				mode = { "n", "x", "o" },
				desc = "Motion: fla[S]h treesitter",
			}),
		},
	},
	{
		"folke/trouble.nvim",
		dependencies = {
			"folke/todo-comments.nvim",
		},
		opts = {
			max_items = 5000,
			modes = {
				symbols = {
					win = {
						size = 0.3,
					},
				},
			},
		}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			keymap.lazy(
				"<leader>dd",
				"<cmd>Trouble diagnostics toggle focus=true<cr>",
				{ desc = "Diag: [d]iagnostics [d]ashboard" }
			),
			keymap.lazy(
				"<leader>dx",
				"<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
				{ desc = "Diag: [d]iagnostics buffer [x]" }
			),
			keymap.lazy(
				"<leader>ds",
				"<cmd>Trouble symbols toggle fold_close_all focus=true<cr>",
				{ desc = "Diag: [d]iagnostics [s]ymbols" }
			),
			keymap.lazy(
				"<leader>dt",
				"<cmd>Trouble todo toggle focus=true<cr>",
				{ desc = "Diag: [d]iagnostics [t]odos" }
			),
		},
	},
	{
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({
				preset = "helix",
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			-- Usage:
			-- HACK:
			-- BUG:
			-- TODO:
			-- NOTE:
			-- FIXME:
			-- FIX:
			-- FIXIT:
			-- WARN:
			-- TEST:
			require("todo-comments").setup({})
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
				{ path = "lazy.nvim", words = { "Lazy" } },
			},
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				lsp_doc_border = true,
			},
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			picker = {
				enabled = true,
			},
			gh = { enabled = true },
			lazygit = { enabled = true },
			statuscolumn = { enabled = true },
			indent = { enabled = true },
			words = { enabled = true },
			input = { enabled = true },
			notify = { enabled = true },
			notifier = { enabled = true },
			scope = { enabled = true },
		},
		keys = {
			keymap.lazy("<leader>sS", function()
				Snacks.picker()
			end, { desc = "Search: [s]earch picker[S]" }),
			keymap.lazy("<leader>gg", function()
				Snacks.lazygit()
			end, { desc = "Git: [g]it lazy[G]it" }),
			keymap.lazy("<leader><space>", function()
				Snacks.picker.buffers({ focus = "list" })
			end, { desc = "Search: [s]earch buffers" }),
			keymap.lazy("<leader>/", function()
				Snacks.picker.lines()
			end, { desc = "Search: [s]earch current buffer" }),
			keymap.lazy("<leader>sf", function()
				Snacks.picker.smart()
			end, { desc = "Search: [s]earch [f]iles" }),
			keymap.lazy("<leader>sh", function()
				Snacks.picker.help()
			end, { desc = "Search: [s]earch [h]elp" }),
			keymap.lazy("<leader>sk", function()
				Snacks.picker.keymaps()
			end, { desc = "Search: [s]earch [k]eymaps" }),
			keymap.lazy("<leader>so", function()
				Snacks.picker.recent({ focus = "list", filter = { cwd = true } })
			end, { desc = "Search: [s]earch [o]ld files" }),
			keymap.lazy("<leader>sg", function()
				Snacks.picker.grep()
			end, { desc = "Search: [s]earch [g]rep" }),
			keymap.lazy("<leader>ss", function()
				Snacks.picker.git_status({ focus = "list" })
			end, { desc = "Search: [s]earch git [s]tatus" }),
			keymap.lazy("<leader>sc", function()
				Snacks.picker.spelling()
			end, { desc = "Search: [s]earch spell [c]heck" }),
			keymap.lazy("<leader>st", function()
				Snacks.picker.todo_comments({ focus = "list" })
			end, { desc = "Search: [s]earch [t]odos" }),
			keymap.lazy("<leader>si", function()
				Snacks.picker.icons()
			end, { desc = "Search: [s]earch [i]cons" }),
			keymap.lazy("<leader>su", function()
				Snacks.picker.undo({ focus = "list" })
			end, { desc = "Search: [s]earch [u]ndo" }),
			keymap.lazy("<leader>sr", function()
				Snacks.picker.gh_pr()
			end, { desc = "Search: [s]earch github p[r]" }),
			keymap.lazy("<leader>gf", function()
				Snacks.picker.git_log_file()
			end, { desc = "Git: [g]it [f]ile history" }),
			keymap.lazy("<leader>sC", function()
				Snacks.picker.colorschemes()
			end, { desc = "Search: [s]earch [C]olorschemes" }),
		},
	},
}

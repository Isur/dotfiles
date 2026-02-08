return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
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
			{
				"<leader>dd",
				"<cmd>Trouble diagnostics toggle focus=true<cr>",
				desc = "Trouble Diagnostics",
			},
			{
				"<leader>dx",
				"<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
				desc = "Trouble Buffer Diagnostics",
			},
			{
				"<leader>ds",
				"<cmd>Trouble symbols toggle fold_close_all focus=true<cr>",
				desc = "Trouble Symbols",
			},
			{
				"<leader>dt",
				"<cmd>Trouble todo toggle focus=true<cr>",
				desc = "Trouble Todos",
			},
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
			{
				"<leader>sS",
				function()
					Snacks.picker()
				end,
				desc = "Picker pickers",
			},
			{
				"<leader>gg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazy Git",
			},
			{
				"<leader><space>",
				function()
					Snacks.picker.buffers({ focus = "list" })
				end,
				desc = "Picker Buffers",
			},
			{
				"<leader>/",
				function()
					Snacks.picker.lines()
				end,
				desc = "Picker Lines",
			},
			{
				"<leader>sf",
				function()
					Snacks.picker.smart()
				end,
				desc = "Picker Files",
			},
			{
				"<leader>sh",
				function()
					Snacks.picker.help()
				end,
				desc = "Picker Help",
			},
			{
				"<leader>sk",
				function()
					Snacks.picker.keymaps()
				end,
				desc = "Picker Keymaps",
			},
			{
				"<leader>so",
				function()
					Snacks.picker.recent({ focus = "list", filter = { cwd = true } })
				end,
				desc = "Picker Oldfiles",
			},
			{
				"<leader>sg",
				function()
					Snacks.picker.grep()
				end,
				desc = "Picker Grep",
			},
			{
				"<leader>ss",
				function()
					Snacks.picker.git_status({ focus = "list" })
				end,
				desc = "Picker Git Status",
			},
			{
				"<leader>sc",
				function()
					Snacks.picker.spelling()
				end,
				desc = "Picker Spell Suggest",
			},
			{
				"<leader>st",
				function()
					Snacks.picker.todo_comments({ focus = "list" })
				end,
				desc = "Picker Todo",
			},
			{
				"<leader>si",
				function()
					Snacks.picker.icons()
				end,
				desc = "Picker Icons",
			},
			{
				"<leader>su",
				function()
					Snacks.picker.undo({ focus = "list" })
				end,
				desc = "Picker Undo",
			},
			{
				"<leader>sr",
				function()
					Snacks.picker.gh_pr()
				end,
				desc = "GitHub",
			},
			{
				"<leader>gf",
				function()
					Snacks.picker.git_log_file()
				end,
				desc = "Git file history",
			},
			{
				"<leader>sC",
				function()
					Snacks.picker.colorschemes()
				end,
				desc = "Picker color schemes",
			},
		},
	},
}

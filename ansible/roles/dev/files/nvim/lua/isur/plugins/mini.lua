return {
	"echasnovski/mini.nvim",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	version = false,
	config = function()
		require("mini.ai").setup({})
		require("mini.comment").setup({
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
				end,
			},
		})
		require("mini.cursorword").setup()
		require("mini.pairs").setup()
		require("mini.surround").setup({
			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				replace = "gsr", -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`
			},
		})
		require("mini.trailspace").setup()
		require("mini.notify").setup()
		require("mini.indentscope").setup({
			draw = {
				animation = require("mini.indentscope").gen_animation.none(),
			},
		})
		require("mini.statusline").setup({
			content = {
				active = function()
					local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
					local git = MiniStatusline.section_git({ trunc_width = 75 })
					local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
					local filename = MiniStatusline.section_filename({ trunc_width = 140 })
					local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
					local location = MiniStatusline.section_location({ trunc_width = 75 })
					local serachCount = MiniStatusline.section_searchcount({ trunc_width = 75 })
					local diff = MiniStatusline.section_diff({ trunc_width = 75 })

					-- Check if the supermaven is running
					local supermaven = require("supermaven-nvim.api").is_running() and "[SM]" or ""

					return MiniStatusline.combine_groups({
						{ hl = "MiniStatuslineDevinfo", strings = { serachCount } },
						{ hl = "MiniStatuslineDevinfo", strings = { supermaven } },
						{ hl = mode_hl, strings = { mode } },
						{ hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
						"%<", -- Mark general truncate point
						{ hl = "MiniStatuslineFilename", strings = { filename, diff } },
						"%=", -- End left alignment
						{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
						{ hl = mode_hl, strings = { location } },
					})
				end,
				inactive = function()
					local filename = MiniStatusline.section_filename({ trunc_width = 140 })

					return MiniStatusline.combine_groups({
						{ hl = "", strings = { filename } },
					})
				end,
			},
		})
	end,
}

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
				add = "sa", -- Add surrounding in Normal and Visual modes
				delete = "sd", -- Delete surrounding
				find = "sf", -- Find surrounding (to the right)
				find_left = "sF", -- Find surrounding (to the left)
				highlight = "sh", -- Highlight surrounding
				replace = "sr", -- Replace surrounding
				update_n_lines = "sn", -- Update `n_lines`
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
					local modified = vim.bo.modified and "●" or ""

					-- Check if the supermaven is running
					local supermaven = require("supermaven-nvim.api").is_running() and "[SM]" or ""

					return MiniStatusline.combine_groups({
						{ hl = "MiniStatuslineDevinfo", strings = { serachCount } },
						{ hl = "MiniIconsPurple", strings = { supermaven } },
						{ hl = mode_hl, strings = { mode } },
						{ hl = "MiniIconsYellow", strings = { modified } },
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

		if vim.g.colors_name == "NeoSolarized" then
			-- Solarized colorscheme changes
			vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { fg = "#268bd2", bg = "#073642", bold = false })

			-- Subtle underline for non-current word
			vim.api.nvim_set_hl(0, "MiniCursorword", { underline = true, sp = "#b58900" }) -- underline color = yellow

			-- High-contrast but theme-matching for current word
			vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", {
				bg = "#b58900", -- Solarized yellow background
				fg = "#002b36", -- Base03 foreground (dark)
				bold = true,
				underline = true,
			})
		end
	end,
}

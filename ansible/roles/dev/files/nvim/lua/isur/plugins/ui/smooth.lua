return {
	{
		"sphamba/smear-cursor.nvim",
		config = function()
			require("smear_cursor").setup({
				stiffness = 0.8, -- 0.6      [0, 1]
				trailing_stiffness = 0.6, -- 0.3      [0, 1]
				trailing_exponent = 0, -- 0.1      >= 0
				distance_stop_animating = 0.5, -- 0.1      > 0
				hide_target_hack = false, -- true     boolean
			})
		end,
	},
}

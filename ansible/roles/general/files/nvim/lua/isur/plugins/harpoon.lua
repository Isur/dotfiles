local keymap = require("isur.core.keymap")

---@param fn fun(harpoon: table)
local function with_harpoon(fn)
	return function()
		fn(require("harpoon"))
	end
end

local keys = {
	keymap.lazy(
		"<leader>hh",
		with_harpoon(function(harpoon)
			harpoon:list():add()
			vim.notify(vim.fn.expand("%:t") .. " - added to harpoon!")
		end),
		{ desc = "Harpoon: [h]arpoon [h]old file" }
	),
	keymap.lazy(
		"<leader>hm",
		with_harpoon(function(harpoon)
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end),
		{ desc = "Harpoon: [h]arpoon [m]enu" }
	),
	keymap.lazy(
		"<leader>hp",
		with_harpoon(function(harpoon)
			harpoon:list():prev({ ui_nav_wrap = true })
		end),
		{ desc = "Harpoon: [h]arpoon [p]revious" }
	),
	keymap.lazy(
		"<leader>hn",
		with_harpoon(function(harpoon)
			harpoon:list():next({ ui_nav_wrap = true })
		end),
		{ desc = "Harpoon: [h]arpoon [n]ext" }
	),
}

for i = 1, 5 do
	table.insert(
		keys,
		keymap.lazy(
			"<leader>h" .. i,
			with_harpoon(function(harpoon)
				harpoon:list():select(i)
			end),
			{ desc = "Harpoon: [h]arpoon file [" .. i .. "]" }
		)
	)
end

return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = keys,
	config = function()
		require("harpoon"):setup({
			settings = {
				save_on_toggle = true,
			},
		})
	end,
}

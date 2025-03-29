return {
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		dependencies = {
			{
				"rafamadriz/friendly-snippets",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
					require("luasnip.loaders.from_vscode").lazy_load({
						paths = { vim.fn.stdpath("config") .. "/snippets" },
					})
				end,
			},
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
	},
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },

		-- use a release tag to download pre-built binaries
		version = "1.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "default",
				["<C-s>"] = { "show", "show_documentation", "hide_documentation", "fallback" },
				["<C-space>"] = {
					function(cmp)
						cmp.show({ providers = { "snippets" } })
					end,
				},
			},

			snippets = {
				preset = "luasnip",
			},

			completion = {
				documentation = {
					auto_show = true,
				},
			},

			appearance = {
				nerd_font_variant = "mono",
			},

			sources = {
				default = { "lsp", "path", "buffer", "snippets" },
				providers = {
					lsp = {
						score_offset = 1,
					},
					path = {
						score_offset = 2,
					},
					buffer = {
						score_offset = 3,
					},
					snippets = {
						score_offset = 4,
					},
				},
			},

			signature = {
				enabled = true,
			},

			fuzzy = {
				sorts = {
					"exact",
					"score",
					"sort_text",
				},
				implementation = "prefer_rust_with_warning",
			},

			cmdline = {
				enabled = true,
				completion = {
					menu = {
						auto_show = true,
					},
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}

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
	-- {
	-- 	"saghen/blink.cmp",
	-- 	dependencies = { "rafamadriz/friendly-snippets" },
	--
	-- 	-- use a release tag to download pre-built binaries
	-- 	version = "1.*",
	-- 	---@module 'blink.cmp'
	-- 	---@type blink.cmp.Config
	-- 	opts = {
	-- 		keymap = {
	-- 			preset = "default",
	-- 			["<C-s>"] = { "show", "show_documentation", "hide_documentation", "fallback" },
	-- 			["<C-space>"] = {
	-- 				function(cmp)
	-- 					cmp.show({ sources = { "snippets" } })
	-- 				end,
	-- 			},
	-- 		},
	--
	-- 		snippets = {
	-- 			preset = "luasnip",
	-- 		},
	--
	-- 		completion = {
	-- 			documentation = {
	-- 				auto_show = true,
	-- 			},
	-- 		},
	--
	-- 		appearance = {
	-- 			nerd_font_variant = "mono",
	-- 		},
	--
	-- 		sources = {
	-- 			default = { "lsp", "path", "buffer", "snippets" },
	-- 			providers = {
	-- 				lsp = {
	-- 					score_offset = 5,
	-- 				},
	-- 				path = {
	-- 					score_offset = 4,
	-- 				},
	-- 				buffer = {
	-- 					score_offset = 3,
	-- 				},
	-- 				snippets = {
	-- 					score_offset = -1,
	-- 				},
	-- 			},
	-- 		},
	--
	-- 		signature = {
	-- 			enabled = true,
	-- 		},
	--
	-- 		fuzzy = {
	-- 			use_frecency = true,
	-- 			sorts = {
	-- 				"exact",
	-- 				"score",
	-- 				"sort_text",
	-- 			},
	-- 			implementation = "prefer_rust_with_warning",
	-- 		},
	--
	-- 		cmdline = {
	-- 			enabled = true,
	-- 			completion = {
	-- 				menu = {
	-- 					auto_show = true,
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- },
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer", -- source for text in buffer
			"hrsh7th/cmp-path", -- source for file system paths
			"hrsh7th/cmp-cmdline", -- source for command line
			"hrsh7th/cmp-nvim-lsp-signature-help", -- source for signature help
			"L3MON4D3/LuaSnip", -- snippet engine
			"saadparwaiz1/cmp_luasnip", -- for autocompletion
			"rafamadriz/friendly-snippets", -- useful snippets
			"onsails/lspkind.nvim", -- vs-code like pictograms
		},

		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			cmp.setup.filetype({ "sql" }, {
				sources = {
					{ name = "vim-dadbod-completion" },
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})

			local options = {
				completion = {
					completeopt = "menu,menuone,preview,noselect",
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-s>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = {
					-- { name = "nvim_lsp_signature_help" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = lspkind.cmp_format({ with_text = true }),
				},
				sorting = {
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						cmp.config.compare.kind,
					},
				},
			}
			options = vim.tbl_deep_extend("force", options, require("nvchad.cmp"))
			cmp.setup(options)
		end,
	},
}

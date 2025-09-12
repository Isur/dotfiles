return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"ray-x/lsp_signature.nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		require("lsp_signature").setup({
			toggle_key = "<c-k>",
		})
		local lspconfig = require("lspconfig")
		local util = require("lspconfig.util")
		local builtins = require("telescope.builtin")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		vim.diagnostic.config({
			float = {
				source = true,
			},
			virtual_text = {
				prefix = "■ ", -- Could be '●', '▎', 'x', '■', , 
			},
		})

		local virtual_text_enabled = true

		vim.api.nvim_create_user_command("ToggleVirtualText", function()
			virtual_text_enabled = not virtual_text_enabled
			vim.diagnostic.config({
				virtual_text = virtual_text_enabled,
			})
			print("Virtual Text is now " .. (virtual_text_enabled and "enabled" or "disabled"))
		end, {})

		local on_attach = function(_, bufnr)
			local nmap = function(keys, func, desc)
				if desc then
					desc = "LSP: " .. desc
				end

				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
			end
			nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")

			nmap("gd", builtins.lsp_definitions, "Goto Definition")
			nmap("gr", builtins.lsp_references, "Goto References")
			nmap("gI", vim.lsp.buf.implementation, "Goto Implementation")
			nmap("<leader>D", vim.lsp.buf.type_definition, "Type Definition")
			nmap("[d", function()
				vim.diagnostic.jump({ count = -1, float = true })
			end, "Go to previous diagnostic message")
			nmap("]d", function()
				vim.diagnostic.jump({ count = 1, float = true })
			end, "Go to next diagnostic message")
			nmap("dp", vim.diagnostic.open_float, "Open diagnostic message in float window")
			nmap("<leader>rn", vim.lsp.buf.rename, "Rename")

			nmap("K", vim.lsp.buf.hover, "Hover Documentation")

			nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
			nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
			nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
			nmap("<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, "Workspace List Folders")

			vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
				vim.lsp.buf.format()
			end, { desc = "Format current buffer with LSP" })
		end

		-- local capabilities = blink.get_lsp_capabilities()
		local capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		vim.diagnostic.config({
			signs = {
				active = true,
				text = {
					[vim.diagnostic.severity.ERROR] = signs.Error,
					[vim.diagnostic.severity.WARN] = signs.Warn,
					[vim.diagnostic.severity.HINT] = signs.Hint,
					[vim.diagnostic.severity.INFO] = signs.Info,
				},
			},
		})

		if vim.env.NVIM_LINT ~= "off" then
			lspconfig["eslint"].setup({
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
				end,
				capabilities = capabilities,
			})
		end

		lspconfig["vtsls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		lspconfig["arduino_language_server"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		lspconfig["tailwindcss"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		lspconfig["cssls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		lspconfig["dockerls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		lspconfig["docker_compose_language_service"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		lspconfig["bashls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		lspconfig["html"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		lspconfig["pyright"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				pyright = {
					disableOrganizeImports = true,
				},
				python = {
					analysis = {
						ignore = { "*" },
					},
				},
			},
		})

		lspconfig["ruff"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		lspconfig["clangd"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		lspconfig["emmet_language_server"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		lspconfig["ansiblels"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		lspconfig["marksman"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		lspconfig["jsonls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		lspconfig["gopls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			cmd = { "gopls" },
			root_dir = util.root_pattern("go.work", "go.mod", ".git"),
			settings = {
				gopls = {
					completeUnimported = true,
				},
			},
		})

		lspconfig["lua_ls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostic = {
						globals = { "vim" },
					},
					workspace = {
						checkThirdParty = false,
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
					telemetry = { enable = false },
				},
			},
		})
	end,
}

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
		require("lsp_signature").setup()
		local lspconfig = require("lspconfig")
		local util = require("lspconfig.util")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local builtins = require("telescope.builtin")
		local border = "rounded"

		-- Add the border on hover and on signature help popup window
		local handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
			["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
		}

		vim.diagnostic.config({
			virtual_text = {
				prefix = "■ ", -- Could be '●', '▎', 'x', '■', , 
			},
			float = { border = border },
		})

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
			nmap("<leader>ds", builtins.lsp_document_symbols, "Document Symbols")
			nmap("<leader>ws", builtins.lsp_dynamic_workspace_symbols, "Workspace Symbols")
			nmap("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
			nmap("]d", vim.diagnostic.goto_next, "Go to next diagnostic message")
			nmap("dp", vim.diagnostic.open_float, "Open diagnostic message in float window")

			nmap("K", vim.lsp.buf.hover, "Hover Documentation")

			nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
			nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
			nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
			nmap("<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, "Workspace List Folders")

			vim.keymap.set("i", "<c-s>", vim.lsp.buf.signature_help)

			vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
				vim.lsp.buf.format()
			end, { desc = "Format current buffer with LSP" })
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		lspconfig["ts_ls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			handlers = handlers,
		})

		lspconfig["arduino_language_server"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			handlers = handlers,
		})

		lspconfig["tailwindcss"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			handlers = handlers,
		})

		lspconfig["cssls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			handlers = handlers,
		})

		lspconfig["dockerls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			handlers = handlers,
		})

		lspconfig["docker_compose_language_service"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			handlers = handlers,
		})

		lspconfig["bashls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			handlers = handlers,
		})

		lspconfig["html"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			handlers = handlers,
		})

		lspconfig["pylsp"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			handlers = handlers,
		})

		lspconfig["clangd"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			handlers = handlers,
		})

		lspconfig["emmet_language_server"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			handlers = handlers,
		})

		lspconfig["ansiblels"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			handlers = handlers,
		})

		lspconfig["marksman"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			handlers = handlers,
		})

		lspconfig["gopls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			handlers = handlers,
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
			handlers = handlers,
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

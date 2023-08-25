local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')

  nmap('gd', vim.lsp.buf.definition, 'Goto Definition')
  nmap('gr', require('telescope.builtin').lsp_references, 'Goto References')
  nmap('gI', vim.lsp.buf.implementation, 'Goto Implementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, 'Workspace List Folders')

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

require("neodev").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup()


local lsp = require("lspconfig")
lsp["pylsp"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          maxLineLength = 100,
          ignore = { "E712" },
        }
      }
    }
  }
})
lsp["tsserver"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lsp["eslint"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lsp["cssls"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lsp["lua_ls"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  }
})
lsp["tailwindcss"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    -- Python
    null_ls.builtins.formatting.black,
    -- null_ls.builtins.diagnostics.mypy,
    -- null_ls.builtins.diagnostics.ruff,
    -- JS/TS
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.formatting.prettierd,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})

local goto = require("goto-preview")
goto.setup({})

vim.keymap.set({ 'n' }, '<leader>kk', function()
  goto.goto_preview_definition()
end, { silent = true, noremap = true, desc = 'Show preview definition window' })

vim.keymap.set({ 'n' }, '<leader>kq', function()
  goto.close_all_win()
end, { silent = true, noremap = true, desc = 'Close all preview windows' })

vim.keymap.set({ 'n' }, '<leader>kt', function()
  goto.goto_preview_type_definition()
end, { silent = true, noremap = true, desc = 'Show preview type window' })

vim.keymap.set({ 'n' }, '<leader>kr', function()
  goto.goto_preview_references()
end, { silent = true, noremap = true, desc = 'Show preview references window' })

vim.keymap.set({ 'n' }, '<leader>ki', function()
  goto.goto_preview_implementation()
end, { silent = true, noremap = true, desc = 'Show preview implementation window' })

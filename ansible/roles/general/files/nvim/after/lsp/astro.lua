return {
	before_init = function(_, config)
		local tsdk = require("lspconfig.util").get_typescript_server_path(config.root_dir)
		if tsdk == "" then
			tsdk = vim.fn.stdpath("data")
				.. "/mason/packages/vtsls/node_modules/@vtsls/language-server/node_modules/typescript/lib"
		end
		config.init_options.typescript = { tsdk = tsdk }
	end,
}

local inlay_hints = {
	parameterNames = { enabled = "literals" },
	parameterTypes = { enabled = true },
	variableTypes = { enabled = false },
	propertyDeclarationTypes = { enabled = true },
	functionLikeReturnTypes = { enabled = true },
	enumMemberValues = { enabled = true },
}

return {
	settings = {
		vtsls = {
			-- Use the project's own TypeScript from node_modules when present.
			autoUseWorkspaceTsdk = true,
			experimental = {
				completion = {
					-- Let the server filter large completion lists before sending them.
					enableServerSideFuzzyMatch = true,
				},
			},
		},
		typescript = {
			tsserver = {
				maxTsServerMemory = 8192, -- in MB, e.g. 8192 = 8GB
			},
			inlayHints = inlay_hints,
		},
		javascript = {
			inlayHints = inlay_hints,
		},
	},
}

-- Compound YAML filetypes let ansiblels and docker_compose_language_service attach only
-- where they apply. Treesitter, conform and ftplugins still treat these buffers as yaml.
vim.filetype.add({
	filename = {
		["compose.yml"] = "yaml.docker-compose",
		["compose.yaml"] = "yaml.docker-compose",
		["docker-compose.yml"] = "yaml.docker-compose",
		["docker-compose.yaml"] = "yaml.docker-compose",
	},
	pattern = {
		["compose%..+%.ya?ml"] = "yaml.docker-compose",
		["docker%-compose%..+%.ya?ml"] = "yaml.docker-compose",
		[".*/roles/[^/]+/tasks/.+%.ya?ml"] = "yaml.ansible",
		[".*/roles/[^/]+/handlers/.+%.ya?ml"] = "yaml.ansible",
		[".*/playbooks/.+%.ya?ml"] = "yaml.ansible",
		[".*/group_vars/.+%.ya?ml"] = "yaml.ansible",
		[".*/host_vars/.+%.ya?ml"] = "yaml.ansible",
		[".*/ansible/[^/]+%.ya?ml"] = "yaml.ansible",
	},
})

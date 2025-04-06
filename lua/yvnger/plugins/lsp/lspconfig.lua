return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local capabilities = cmp_nvim_lsp.default_capabilities()

		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["intelephense"] = function()
				lspconfig["intelephense"].setup({
					capabilities = capabilities,
					settings = {
						intelephense = {
							environment = {
								includePaths = { "/var/www/html/wp-core" },
							},
						},
					},
				})
			end,
			["sqlls"] = function()
				lspconfig["sqlls"].setup({
					capabilities = capabilities,
				})
			end,
		})

		-- Formatting settings
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "php" },
			command = "setlocal tabstop=4 shiftwidth=4",
		})
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "html", "css", "javascript" },
			command = "setlocal tabstop=2 shiftwidth=2",
		})
	end,
}

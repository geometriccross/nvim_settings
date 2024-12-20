

require('mason').setup {
	ensure_installed = {
		'bashls',
		'lua-language-server',
		'shfmt',
		'shellcheck'
	},
	ui = {
		check_outdated_packages_on_open = false,
		border = 'single',
	},
}

require('mason-lspconfig').setup_handlers {
	function(server_name)
		require('lspconfig')[server_name].setup {
			capabilities = require('cmp_nvim_lsp').default_capabilities(),
		}
	end
}

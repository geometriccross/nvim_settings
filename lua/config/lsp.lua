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
		-- powershell_es setting
		-- Please check this issue https://github.com/PowerShell/PowerShellEditorServices/issues/2092
		if server_name == 'powershell_es' then
			require("lspconfig").powershell_es.setup {
				filetypes = { "ps1", "psm1", "psd1" },
				bundle_path = "~/AppData/Local/nvim-data/mason/packages/powershell-editor-services",
				settings = { powershell = { codeFormatting = { Preset = 'OTBS' } } },
				init_options = {
					enableProfileLoading = false,
				},
			}
		else
			require('lspconfig')[server_name].setup {
				capabilities = require('cmp_nvim_lsp').default_capabilities(),
			}
		end
	end
}

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
	end,
	-- please refer this, https://medium.com/@kacpermichta33/powershell-development-in-neovim-23ed44d453b4
	powershell_es = function()
		require("lspconfig").powershell_es.setup {
			on_attach = function(_, bufnr)
				vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
			end,

			filetypes = { "ps1", "psm1", "psd1" },
			-- powershell_es is not provide binaly, so it need to provide the path of the script files
			bundle_path = vim.fn.expand(vim.fn.stdpath('data') .. '/mason/packages/powershell-editor-services'),
			settings = { powershell = { codeFormatting = { Preset = 'OTBS' } } },
		}
	end
}

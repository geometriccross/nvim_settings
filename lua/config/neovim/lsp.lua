require('mason').setup()

local ensure_installed = {
	'bashls',
	'lua_ls',
	'powershell_es',
	'shfmt',
}

require('mason-lspconfig').setup {
	automatic_installation = true,
	ensure_installed = ensure_installed,
}


vim.lsp.config('powershell_es', {
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
	on_attach = function(_, bufnr)
		vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	end,
	filetypes = { "ps1", "psm1", "psd1" },
	bundle_path = vim.fn.expand(vim.fn.stdpath('data') .. '/mason/packages/powershell-editor-services'),
	settings = { powershell = { codeFormatting = { Preset = 'OTBS' } } },
})


vim.lsp.config('racket_langserver', {
	cmd = { "racket", "--lib", "racket-langserver" },
	filetypes = { "racket", "rkt" },
	root_dir = util.root_pattern("info.rkt", ".git") or util.path.dirname,
	settings = {},
})

vim.lsp.enable(ensure_installed)

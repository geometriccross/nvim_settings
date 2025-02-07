local lspconfig = require('lspconfig')
local util = require('lspconfig.util')

local configs = require('lspconfig.configs')
if not configs.racket_langserver then
	configs.racket_langserver = {
		default_config = {
			-- racket-langserver run on racket runtime, so I run racket with --lib option
			cmd = { "racket", "--lib", "racket-langserver" },
			filetypes = { "racket", "rkt" },
			root_dir = util.root_pattern("info.rkt", ".git") or util.path.dirname,
			settings = {},
		},
	}
end

lspconfig.racket_langserver.setup {
	-- langserver common settings
	on_attach = function(_, bufnr)
		-- set omnifunc
		vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
		local opts = { noremap = true, silent = true }

		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts) -- hover
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts) -- jump to definition
	end,
	-- for complemention
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
}

-- troubleshooting
-- https://chatgpt.com/c/67a07a6c-f344-8010-92c4-96fca6b9e0a6

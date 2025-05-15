local cmp = require 'cmp'
local luasnip = require 'luasnip'

local map = cmp.mapping

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

cmp.setup {
	mapping = map.preset.insert {
		-- nvim-cmp mappings
		['<C-d>'] = map.scroll_docs(-4),
		['<C-f>'] = map.scroll_docs(4),
		['<C-Space>'] = map.complete(),
		['<C-e>'] = map.abort(),
		['<CR>'] = map.confirm { select = false },

		-- These mappings are for <Tab> and <S-Tab> in insert mode
		-- LuaSnip setup
		['<Tab>'] = map(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
				-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
				-- they way you will only jump inside the snippet region
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { 'i', 's' }),

		['<S-Tab>'] = map(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	},

	sources = cmp.config.sources {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'copilot' }
	},

	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
}

if not vim.fn.has('win32') then
	require('luasnip.loaders.from_vscode').lazy_load({
		paths = {
			os.getenv('HOME') .. '/.local/share/nvim/lazy/friendly-snippets'
		}
	})
end

return {
	-- cmp settings are in lua/config/cmp.lua
	'hrsh7th/nvim-cmp',
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		{
			'L3MON4D3/LuaSnip',
			version = "v2.*",
			dependencies = {
				'saadparwaiz1/cmp_luasnip',
				-- add pre configured snippets
				'rafamadriz/friendly-snippets',
			},
		},
	}
}

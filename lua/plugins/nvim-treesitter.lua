return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		{
			'RRethy/nvim-treesitter-endwise',
			config = function()
				require('nvim-treesitter.configs').setup {
					endwise = {
						enable = true,
					},
				}
			end
		}
	},
	opts = {
		sync_install = true,
		ensure_installed = {
			"lua",
			"bash",
		}
	},
}

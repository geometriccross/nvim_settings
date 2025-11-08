return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		{
			"RRethy/nvim-treesitter-endwise",
			config = function()
				require("nvim-treesitter.configs").setup({
					endwise = {
						enable = true,
					},
				})
			end,
		},
		{
			"theHamsta/nvim-treesitter-pairs",
			config = function()
				require("nvim-treesitter.configs").setup({
					pairs = {
						enable = true,
						keymaps = {
							goto_partner = "F",
							delete_balanced = "X",
						},
					},
				})
			end,
		},
	},
	opts = {
		sync_install = true,
		ensure_installed = {
			"lua",
			"bash",
		},
	},
}

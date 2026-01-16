return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	dependencies = { "RRethy/nvim-treesitter-endwise" },
	config = function()
		require 'nvim-treesitter'.install {
			"lua",
			"vim",
			"vimdoc",
			"query",
			"markdown",
			"markdown_inline",
			"css",
			"html",
			"javascript",
			"latex",
			"norg",
			"scss",
			"svelte",
			"tsx",
			"typst",
			"vue",
			"python",
			"bash",
			"zsh"
		}
	end,
}

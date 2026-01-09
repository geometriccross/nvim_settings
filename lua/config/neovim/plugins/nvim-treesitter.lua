return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	dependencies = { "RRethy/nvim-treesitter-endwise" },
	config = function()
		require 'nvim-treesitter'.install { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" }
	end,
}

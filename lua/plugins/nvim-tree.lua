return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{
			mode = "n",
			"<leader>t",
			"<cmd>NvimTreeToggle<CR>",
			desc = "Toggle Tree"
		}
	},
	config = function()
		require("nvim-tree").setup {
			filters = {
				git_ignored = false,
				custom = {
					"^\\.git$",
					"^node_modules",
				},
			},
		}
	end,
}

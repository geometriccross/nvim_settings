return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	dependencies = {
		"RRethy/nvim-treesitter-endwise",
		"theHamsta/nvim-treesitter-pairs",
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
			sync_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
			disable = function(lang, buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
			endwise = { enable = true }, -- Enable nvim-treesitter-endwise
			-- Enable nvim-treesitter-pairs
			pairs = {
				enable = true,
				keymaps = {
					goto_partner = "F",
					delete_balanced = "X",
				},
			},
		})
	end,
}

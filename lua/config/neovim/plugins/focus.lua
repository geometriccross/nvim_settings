return {
	"nvim-focus/focus.nvim",
	config = function()
		require("focus").setup()
		local ignore_buftypes = { "nofile", "prompt", "popup" }
		local ignore_filetypes = { "CodeCompanion", "NvimTree" }

		local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

		vim.api.nvim_create_autocmd("WinEnter", {
			group = augroup,
			callback = function(_)
				local buftype_match = vim.tbl_contains(ignore_buftypes, vim.bo.buftype)
				local filetype_match = vim.tbl_contains(ignore_filetypes, vim.bo.filetype)
				vim.w.focus_disable = buftype_match or filetype_match
			end,
			desc = "Disable focus autoresize for BufType and FileType",
		})
	end,
}

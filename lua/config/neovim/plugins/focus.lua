return {
	"nvim-focus/focus.nvim",
	config = function()
		require("focus").setup()
		local ignore_buftypes = { "nofile", "prompt", "popup", "CodeCompanion", "NvimTree" }

		local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

		vim.api.nvim_create_autocmd("WinEnter", {
			group = augroup,
			callback = function(_)
				vim.w.focus_disable = vim.tbl_contains(ignore_buftypes, vim.bo.buftype)
			end,
			desc = "Disable focus autoresize for BufType",
		})
	end,
}

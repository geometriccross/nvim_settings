-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Run shellspec on save
local term_size = 40
local Terminal = require("toggleterm.terminal").Terminal
local term = Terminal:new({
	direction = "vertical",
	size = term_size
})

vim.api.nvim_create_autocmd('BufWritePost', {
	desc = 'run shellspec if spec folder exists',
	pattern = '*.sh',
	callback = function()
		if not vim.fn.isdirectory('spec') then
			return
		end

		if not term:is_open() then
			term:open()
			term:resize(term_size)
		end

		term:clear()
		term:send('shellspec')
	end,
})

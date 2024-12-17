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
vim.api.nvim_create_autocmd('BufWrite', {
desc = 'run shellspec if spec folder exists',
pattern = '*.sh',
callback = function()
    -- get a current dir
    local cwd = vim.fn.getcwd()
    -- check that the specific spec folder is exists
    if vim.fn.isdirectory(cwd .. '/' .. 'spec') == 1 then
	local term_bufs = GetTerminalBuffer()
	if #term_bufs == 0 then
	    vim.cmd.vsplit()
	end
	
	-- select first terminal buffers
	local target_buf = term_bufs[1]
	SendToTerminal(target_buf, 'shellspec')
    end
end,
})

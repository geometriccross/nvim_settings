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

--- Check if a file or directory exists in this path
local function exists(file)
	local ok, err, code = os.rename(file, file)
	if not ok then
		if code == 13 then
			-- Permission denied, but it exists
			return true
		end
	end
	return ok, err
end

--- Check if a directory exists in this path
local function isdir(path)
	-- "/" works on both Unix and Windows
	return exists(path .. "/")
end

vim.api.nvim_create_autocmd('BufWritePost', {
	desc = 'run shellspec if spec folder exists',
	pattern = '*.sh',
	callback = function()
		-- check current directory has spec folder
		if isdir(vim.fn.getcwd() .. '/spec') then
			if not term:is_open() then
				term:open()
				term:resize(term_size)
			end

			term:clear()
			term:send('shellspec')
		end
	end,
})

-- get dir path that has mason, lazy dir
-- and you can appended passed path

function LibPath(path)
	-- if passed like this 'hoge/aaa', it need to add / in top of string
	if string.sub(path, 1, 1) ~= '/' then
		path = '/' .. path
	end

	return vim.fn.expand(vim.fn.stdpath('data') .. path)
end

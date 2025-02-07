-- get dir path that has mason, lazy dir
-- and you can appended passed path

function LibPath(stdpath, path)
	-- if passed like this 'hoge/aaa', it need to add / in top of string
	if string.sub(path, 1, 1) ~= '/' then
		path = '/' .. path
	end

	return vim.fn.expand(vim.fn.stdpath(stdpath) .. path)
end

function FileExists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

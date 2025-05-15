local function scandir(directory)
    local handle = vim.loop.fs_scandir(directory)
    if not handle then
        return {}
    end

    local result = {}
    while true do
        local name, type = vim.loop.fs_scandir_next(handle)
        if not name then break end
        table.insert(result, { name = name, type = type })
    end
    return result
end

if vim.g.vscode then
    print("Running in VSCode")
    return {}
else
    print("Running in Neovim")
    local pathes = vim.split(vim.fn.stdpath('config') .. 'plugins')
    local module_table = {}
    for _, path in ipairs(pathes) do
        module_table.insert(require(path))
    end

    return module_table
end


local function remove_extension(filename)
    -- 最後のドットから末尾までを除去
    return filename:match("(.+)%.[^%.]+$") or filename
end

local function scandir(directory, disable_postfix)
    disable_postfix = disable_postfix or false
    local handle = vim.loop.fs_scandir(directory)
    if not handle then
        return {}
    end

    local result = {}
    while true do
        local name, type = vim.loop.fs_scandir_next(handle)
        if not name then break end
        if disable_postfix then
            name = remove_extension(name)
        end
        table.insert(result, { name = name, type = type })
    end
    return result
end

local function get_plugins()
    local plugin_path = vim.fn.stdpath("config") .. "/lua/plugins/"
    local module_table = {}
    for _, entry in ipairs(scandir(plugin_path)) do
        table.insert(module_table, require("plugins." .. remove_extension(entry.name)))
    end

    return module_table
end

if vim.g.vscode then
    print("Running in VSCode")
    return {}
else
    print("Running in Neovim")
    return get_plugins()
end


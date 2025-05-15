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

local function plugin_path()
    return vim.fn.stdpath("config") .. "/lua/plugins/"
end

local function get_plugins()
    local module_table = {}
    for _, entry in ipairs(scandir(plugin_path())) do
        local plugin_name = remove_extension(entry.name)
        local plugin = require("plugins." .. plugin_name)
        
        -- name プロパティがないなら追加する
        plugin.name = plugin.name or plugin_name
        
        table.insert(module_table, plugin)
    end

    return module_table
end

local function ignore_plugin(name, tbl)
    local result = {}
    for _, v in ipairs(tbl) do
        if v.name ~= name then
            return table.insert(result, v)
        end
    end
    return result
end

local function ignore_plugins(names, tbl)
local result = {}
    for _, value in ipairs(tbl) do
local should_include = true
        for _, name in ipairs(names) do
            if value.name == name then
                should_include = false
                break
            end
        end
if should_include then
            table.insert(result, value)
        end
    end
    return result
end

if vim.g.vscode then
    print("Running in VSCode")
    local plg = get_plugins()
    -- specify the file name of plugin
    local ignore_list = {
        "avante",
        "gitsigns",
        "lualine"
        "conraahau",
        "mason",
        "nvim-autopairs",
        "nvim-cmp",
        "nvim-lspconfig",
        "nvim-parinfer",
        "nvim-tree",
        "nvim-treesitter",
        "nvim-treesitter-endwise",
        "telescope",
        "toggleterm",
        "which_key",
    }

    print("Ignoring plugins: " .. ignore_plugins(ignore_list, plg))
    return ignore_plugins(ignore_list, plg)
else
    print("Running in Neovim")
    return get_plugins()
end


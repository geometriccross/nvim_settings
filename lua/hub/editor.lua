
if vim.g.vscode then
    print("Running in VSCode")
    local plg = get_plugins()
    -- specify the file name of plugin
    local ignore_list = {
        "avante",
        "gitsigns",
        "lualine",
        "conjur",
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

    -- プラグイン一覧をログに出力
    print("All plugins:")
    for i, plugin in ipairs(plg) do
        print(i, plugin.name)
    end
    
    -- 除外後のプラグイン一覧
    local filtered_plugins = ignore_plugins(ignore_list, plg)
    print("After filtering, plugins remaining:")
    for i, plugin in ipairs(filtered_plugins) do
        print(i, plugin.name)
    end
    
    return filtered_plugins
else
    print("Running in Neovim")
    return get_plugins()
end


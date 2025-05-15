require 'config.common.settings'
require 'config.common.keymaps'
require 'config.common.autocmd'

if not vim.g.vscode then
    require 'config.cmp'
    require 'lsp.mason'
    require 'lsp.racket'
end
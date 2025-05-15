require 'config.settings'
require 'config.keymaps'
require 'config.autocmd'

if not vim.g.vscode then
    require 'config.cmp'
    require 'lsp.mason'
    require 'lsp.racket'
end
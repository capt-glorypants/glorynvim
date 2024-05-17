vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.roc' },
  callback = function()
    vim.api.nvim_command 'set filetype=roc'
    vim.api.nvim_command 'TSDisable indent roc'
    require('Comment.ft').set('roc', '#%s')

    vim.lsp.start {
      name = 'roc_lsp',
      cmd = { '/home/thor/Programming/Roc/Roc/roc_language_server' },
      root_dir = '.',
    }

    vim.api.nvim_command 'hi link @constructor.roc @number.roc'
  end,
})

-- disable LSP syntax highlighting
vim.api.nvim_create_autocmd('LspAttach', {
  pattern = { '*.roc' },
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

local parsers = require('nvim-treesitter.parsers').get_parser_configs()
parsers.roc = {
  install_info = {
    url = 'https://github.com/faldor20/tree-sitter-roc',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
}

return {
  'https://github.com/ChrisWellsWood/roc.vim',
}

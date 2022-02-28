lua << EOF
  local nvim_lsp = require('lspconfig')

  nvim_lsp.elmls.setup {
    root_dir = function()
      return vim.fn.getcwd()
    end
  }
EOF

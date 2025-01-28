return {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
  init_options = {
    enabledFeatures = {
      diagnostics = false,
    },
  },
  on_attach = function(client)
    -- Do not let the LSP affect vim highlight groups
    client.server_capabilities.semanticTokensProvider = nil

    print'attached to typescript-language-server'
  end
}

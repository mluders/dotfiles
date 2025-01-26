return {
  cmd = { 'ruby-lsp' },
  filetypes = { 'ruby', 'eruby' },
  root_markers = {'Gemfile', '.git'},
  init_options = {
    enabledFeatures = {
      diagnostics = false,
    },
  },
  on_attach = function(client)
    print'attached to ruby-lsp'
  end
}

return {
  cmd = { 'ruby-lsp' },
  filetypes = { 'ruby', 'eruby' },
  root_markers = {'Gemfile', '.git'},
  on_attach = function()
    print'attached to ruby-lsp'
  end
}

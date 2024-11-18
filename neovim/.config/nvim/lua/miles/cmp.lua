local cmp = require('cmp')

cmp.setup({
  sources = {
    { name = 'buffer' },
    { name = 'nvim_lsp' },
    { name = 'path' }
  },
  mapping = cmp.mapping.preset.insert({
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<Up>'] = cmp.mapping.select_prev_item(),
    -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),

  -- mapping = cmp.mapping.preset.insert({
  --   -- Enter key confirms completion item
  --   ['<CR>'] = cmp.mapping.confirm({select = false}),
  --
  --   -- Ctrl + space triggers completion menu
  --   ['<C-Space>'] = cmp.mapping.complete(),
  -- }),
})

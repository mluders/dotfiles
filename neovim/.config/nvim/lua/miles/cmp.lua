local cmp = require('cmp')

cmp.setup({
  sources = {
    { name = 'nvim_lsp', group_index = 1 },
    { name = 'copilot',  group_index = 2 },
    { name = 'buffer',   group_index = 3 },
    { name = 'path',     group_index = 3 }
  },

  mapping = cmp.mapping.preset.insert({
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
  }),

  experimental = {
    ghost_text = true
  }

  -- mapping = cmp.mapping.preset.insert({
  --   -- Enter key confirms completion item
  --   ['<CR>'] = cmp.mapping.confirm({select = false}),
  --
  --   -- Ctrl + space triggers completion menu
  --   ['<C-Space>'] = cmp.mapping.complete(),
  -- }),
})

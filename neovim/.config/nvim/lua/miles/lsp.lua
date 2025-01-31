vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(args)
    local opts = { buffer = args.buf }
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- These will be buffer-local keybindings because they only work if you
    -- have an active language server

    -- TODO: Do these keymaps need to be cleaned up using LspDetach?

    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    -- vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    -- vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    -- vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    -- vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    -- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    -- vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    -- vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    -- vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    -- vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

    -- Asynchronous saving
    if client:supports_method('textDocument/formatting') then
      vim.keymap.set('n', '<leader>s', function()
        local params = vim.lsp.util.make_formatting_params({})

        local handler = function(err, result)
          if err then
            print('[textDocument/formatting] Error: ' .. err)
            return
          end

          if result then
            print('[textDocument/formatting] Applying')
            vim.lsp.util.apply_text_edits(result, args.buf, client.offset_encoding)
          else
            print('[textDocument/formatting] Nothing to format')
          end

          vim.cmd('write')
          print('[textDocument/formatting] Saved')
        end

        print('[textDocument/formatting] Requesting')
        client:request('textDocument/formatting', params, handler, args.buf)
      end, { buffer = args.buf })
    end

    -- Synchronous saving
    -- if client:supports_method('textDocument/formatting') then
    --   -- Format the current buffer on save
    --   vim.api.nvim_create_autocmd('BufWritePre', {
    --     buffer = args.buf,
    --     callback = function()
    --       vim.lsp.buf.format({bufnr = args.buf, id = client.id})
    --     end,
    --   })
    -- end
  end
})

vim.lsp.enable('luals')
vim.lsp.enable('ruby_lsp')
vim.lsp.enable('ts_ls')

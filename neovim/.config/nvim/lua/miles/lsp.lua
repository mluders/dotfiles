-- Good article for understand how LSP functionality works
-- https://dx13.co.uk/articles/2023/04/24/neovim-lsp-without-plugins/

-- Make comfy lines play nicely with LSP and diagnostic signs
vim.diagnostic.config({ signs = { priority = 11 }})
-- vim.diagnostic.disable()
-- function print_current_line_signs()
--   local current_line = vim.api.nvim_win_get_cursor(0)[1]
--   local current_line_signs = vim.fn.sign_getplaced('%', {group = '*', lnum = current_line})
--   print(vim.inspect(current_line_signs, {indent = '  ', newline = '\n  '}))
-- end

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

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
  end
})

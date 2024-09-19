-- Ruby Tests
vim.keymap.set("n", "<leader>t", function()
  local current_file = vim.fn.expand('%')
  local current_line = vim.fn.line('.')
  local command = "terminal test_launcher " .. current_file .. ":" .. current_line
  vim.cmd('w')
  vim.cmd(command)
end, { silent = true, buffer = true })

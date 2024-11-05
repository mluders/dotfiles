-- Ruby Tests
vim.keymap.set("n", "<leader>t", function()
  local current_file = vim.fn.expand('%')
  local current_line = vim.fn.line('.')
  local command = "terminal test_launcher " .. current_file .. ":" .. current_line
  vim.cmd('w')
  vim.cmd(command)
end, { silent = true, buffer = true })

-- local actions = {
--   ["Run Test"] = function()
--     local current_file = vim.fn.expand('%')
--     local current_line = vim.fn.line('.')
--     local command = "terminal test_launcher " .. current_file .. ":" .. current_line
--     vim.cmd('w')
--     vim.cmd(command)
--   end
-- }
--
-- local action_names = {}
-- for name, _ in pairs(actions) do
--   table.insert(action_names, name)
-- end
--
-- function list_ft_commands()
--   require'fzf-lua'.fzf_exec(action_names, {
--     actions = {
--       ['default'] = function(selected, opts)
--         actions[selected[1]]()
--       end
--     }
--   })
-- end

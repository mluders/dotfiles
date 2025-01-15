-- Ruby Tests
vim.keymap.set("n", "<leader>t", function()
  local current_file = vim.fn.expand('%')
  local current_line = vim.fn.line('.')
  local command = "terminal test_launcher " .. current_file .. ":" .. current_line
  vim.cmd('w')
  vim.cmd(command)
end, { silent = true, buffer = true })

function open_alt_file()
  local current_path = vim.api.nvim_buf_get_name(0)
  local alt_path

  if current_path:find("/test/") then
    -- Replace "/test/" with "/app/" and "_test.rb" with ".rb"
    alt_path = current_path
      :gsub("/test/", "/app/")
      :gsub("_test%.rb$", ".rb")
  else
    -- Replace "/app/" with "/test/" and ".rb" with "_test.rb"
    alt_path = current_path
      :gsub("/app/", "/test/")
      :gsub("%.rb$", "_test.rb")
  end

  if current_path == alt_path then
    print("Could not generate alternate path. Are you sure this is a ruby file?")
    return
  end

  if vim.fn.filereadable(alt_path) ~= 1 then
    print("Cannot locate alternate file: " .. alt_path)
    return
  end

  vim.cmd("edit " .. alt_path)
end

vim.keymap.set("n", "ga", open_alt_file)

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


-- vim.lsp.start {
--   name = "rubocop",
--   cmd = { "bundle", "exec", "rubocop", "--lsp" },
-- }

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.rb",
--   callback = function()
--     vim.lsp.buf.format()
--   end,
-- })

require('fzf-lua').setup({
  "hide",
  files = {
    cmd = "rg --files --hidden",
    cwd_prompt = false,
    actions = {
      ["ctrl-g"] = false -- I never want to search ignored files
    },
    fzf_opts = {
      ['-i'] = '', -- ignore case
      ['--layout'] = 'default' -- move search bar to bottom
    },
    git_icons = false
  },
  grep = {
    rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
  },
  winopts = {
    preview = {
      layout = "vertical",
      vertical = "up:50%",
    },
    backdrop = 100
  },
  hls = {
    border = "TelescopeBorder",
    preview_border = "TelescopeBorder",
  },
})

vim.keymap.set('n', '<leader>f', require('fzf-lua').files)
vim.keymap.set('n', '<leader>g', require('fzf-lua').grep)
vim.keymap.set('n', '<leader>r', require('fzf-lua').resume)
vim.keymap.set('n', '<leader>t', function()
  if list_ft_commands then
    list_ft_commands()
  else
    print("No commands for this file")
  end
end)
-- vim.keymap.set('n', '<leader>;', require('fzf-lua').command_history, { desc = "Fzf Grep" })
-- vim.keymap.set('n', '<leader>z', ":FzfLua<CR>", { desc = "Fzf Grep" })

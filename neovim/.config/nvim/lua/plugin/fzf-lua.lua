require('fzf-lua').setup({
  files = {
    cmd = [[
      if [ -f .fd-priority ]; then
        # Prioritize directories defined in .fd-priority
        (fd . $(awk '{print $0 }' .fd-priority) --hidden --type f; fd . $(awk '{print "--exclude " $0}' .fd-priority) --hidden --type f)
      else
        fd . --hidden --type f
      fi
    ]],
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

vim.keymap.set('n', '<leader>f', require('fzf-lua').files, { desc = "Fzf Files" })
vim.keymap.set('n', '<leader>g', require('fzf-lua').grep, { desc = "Fzf Grep" })
vim.keymap.set('n', '<leader>r', require('fzf-lua').resume, { desc = "Fzf Grep" })

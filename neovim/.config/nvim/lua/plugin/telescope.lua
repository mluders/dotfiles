local builtin = require('telescope.builtin')
local lga_actions = require("telescope-live-grep-args.actions")

vim.keymap.set(
  'n',
  '<leader>f',
  function ()
    builtin.find_files {
      find_command = { 'rg', '--files', '--hidden' }
    }
  end,
  {}
)

vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>g', require('telescope').extensions.live_grep_args.live_grep_args, {})
vim.keymap.set('n', '<leader>r', require('telescope.builtin').resume, {
  noremap = true,
  silent = true,
  desc = "Resume",
})

local actions = require("telescope.actions")

require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-k>"] = lga_actions.quote_prompt(),
        ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        ["<C-space>"] = actions.to_fuzzy_refine, -- freeze the current list and start a fuzzy search in the frozen list
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
      },
    },
  },
  extensions = {
    undo = {
      -- telescope-undo.nvim config, see below
    },
    fzf = {
      case_mode = "ignore_case",        -- or "ignore_case" or "respect_case"
    }
    -- other extensions:
    -- file_browser = { ... }
  },
}

require("telescope").load_extension("undo")
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")

require('telescope').load_extension('fzf')
require('telescope').load_extension('live_grep_args')

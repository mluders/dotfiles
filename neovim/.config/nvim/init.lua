-- Swap directional keys to make them more comfortable with Colemak
vim.cmd('set langmap=jh,kl,lk,hj')

-- Colors
vim.cmd('set termguicolors')

-- Increase sign column width (for comfy-line-numbers plugin)
vim.cmd('set signcolumn=yes:2')

-- Ignore case if search pattern contains lowercase letters only
vim.cmd('set ignorecase')
vim.cmd('set smartcase')

-- Disable line wrap
vim.opt.wrap = false

-- I write a lot of Ruby and JS
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Better search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Make line numbers default
vim.opt.number = false
vim.opt.relativenumber = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Right margin
vim.opt.colorcolumn = '80'

-- Map leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Better saving
vim.keymap.set("n", "<leader>s", ":w<CR>")

-- Move lines up/down
vim.keymap.set("v", "L", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "H", ":m '>+1<CR>gv=gv")

-- Remap semicolon to colon
vim.keymap.set('n', ';', ':', { silent = false, noremap = true })
vim.keymap.set('n', ':', ';', { silent = false, noremap = true })

-- Shortcut to open the explorer
vim.keymap.set("n", "<leader>b", vim.cmd.Ex)

-- Keep cursor in the middle when paging up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep search terms in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Make paste better
vim.keymap.set({ "n", "v" }, "<leader>p", [["0p]])
vim.keymap.set({ "n", "v" }, "<leader>P", [["0P]])

-- Copy file path
vim.keymap.set("n", "<leader>c", "<cmd>let @+=@%<CR>", { silent = true })

-- Ruby Tests
vim.keymap.set("n", "<leader>t", function()
  local current_file = vim.fn.expand('%')
  local current_line = vim.fn.line('.')
  local command = "terminal test_launcher " .. current_file .. ":" .. current_line
  vim.cmd(command)
end, { silent = true })

-- Automatically change to insert mode any time a terminal is opened
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  group = vim.api.nvim_create_augroup('user_term_open', {clear = true}),
  pattern = { '*' },
  command = "startinsert"
})

-- Install lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- {
  --   'rebelot/kanagawa.nvim',
  --   config = function()
  --     vim.cmd("colorscheme kanagawa")
  --   end
  -- },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd("colorscheme tokyonight")
    end
  },
  { 'tpope/vim-sleuth' }, -- Detect tabstop and shiftwidth automatically
  {
    'kana/vim-textobj-entire',
    dependencies = {
      'kana/vim-textobj-user'
    }
  },
  { dir = "~/personal/comfy-line-numbers.nvim" },
  {
    'tpope/vim-fugitive',
    config = function()
      vim.cmd("cnoreabbrev gs G") -- TODO: Get rid of these
      vim.cmd("cnoreabbrev gl G log")
      vim.cmd("cnoreabbrev ga G add")
      vim.cmd("cnoreabbrev gd G diff")
      vim.cmd("cnoreabbrev grs G reset")
      vim.cmd("cnoreabbrev gb G branch")
      vim.cmd("cnoreabbrev gc G commit")
      vim.cmd("cnoreabbrev gcan G commit --amend --no-edit")
      vim.cmd("cnoreabbrev gpu G push")
    end
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'debugloop/telescope-undo.nvim',
      'BurntSushi/ripgrep',
      'nvim-telescope/telescope-fzf-native.nvim',
      {
        "nvim-telescope/telescope-live-grep-args.nvim" ,
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
      },
    },
    config = function()
      local builtin = require('telescope.builtin')
      local lga_actions = require("telescope-live-grep-args.actions")

      vim.keymap.set(
        'n',
        '<leader>f',
        function ()
          builtin.find_files {
            find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' }
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
              -- freeze the current list and start a fuzzy search in the frozen list
              ["<C-space>"] = actions.to_fuzzy_refine,
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
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = { "vimdoc", "javascript", "typescript", "ruby", "python", "html" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
          enable = true,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      }
    end
  },
  {
    "theprimeagen/harpoon",
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      vim.keymap.set("n", "<leader>a", mark.add_file)
      vim.keymap.set("n", "<leader>j", ui.toggle_quick_menu) -- h is langmapped to j
      vim.keymap.set("n", "<C-n>", function() ui.nav_prev() end)
      vim.keymap.set("n", "<C-e>", function() ui.nav_next() end)
      vim.keymap.set("n", "<leader>n", function() ui.nav_file(1) end)
      vim.keymap.set("n", "<leader>e", function() ui.nav_file(2) end)
      vim.keymap.set("n", "<leader>i", function() ui.nav_file(3) end)
      vim.keymap.set("n", "<leader>o", function() ui.nav_file(4) end)
    end
  },
  -- {
  --   'VonHeikemen/lsp-zero.nvim', branch = 'v3.x',
  --   config = function()
  --     local lsp_zero = require('lsp-zero')
  --
  --     lsp_zero.on_attach(function(client, bufnr)
  --       -- see :help lsp-zero-keybindings
  --       -- to learn the available actions
  --       lsp_zero.default_keymaps({buffer = bufnr})
  --     end)
  --
  --     -- to learn how to use mason.nvim
  --     -- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
  --     require('mason').setup({})
  --     require('mason-lspconfig').setup({
  --       ensure_installed = {
  --         'solargraph'
  --       },
  --       handlers = {
  --         function(server_name)
  --           require('lspconfig').solargraph.setup({})
  --         end,
  --       },
  --     })
  --   end
  -- },
  {
    'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim',
    config = function()
      require('toggle_lsp_diagnostics').init({ start_on = false })
    end
  },
  { 'neovim/nvim-lspconfig' },
  -- { 'williamboman/mason.nvim' },
  -- { 'williamboman/mason-lspconfig.nvim' } ,
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
})

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user_lsp_attach', {clear = true}),
  callback = function(event)
    local opts = {buffer = event.buf}

    print('ruby_lsp attached')

    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
    vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
  end,
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- require('mason').setup({})
-- require('mason-lspconfig').setup({
--   ensure_installed = { 'ruby_lsp' }
-- })

require'lspconfig'.ruby_lsp.setup{}

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

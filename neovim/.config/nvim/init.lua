-- Swap directional keys to make them more comfortable with Colemak
-- vim.cmd('set langmap=jh,kl,lk,hj')
vim.keymap.set({ 'n', 'v', 's', 'o' }, "j", "h", { silent = true, noremap = true })
vim.keymap.set({ 'n', 'v', 's', 'o' }, "k", "l", { silent = true, noremap = true })
vim.keymap.set({ 'n', 'v', 's', 'o' }, "l", "k", { silent = true, noremap = true })
vim.keymap.set({ 'n', 'v', 's', 'o' }, "h", "j", { silent = true, noremap = true })

-- Colors
vim.cmd('set termguicolors')

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

-- Line numbers
vim.cmd('set signcolumn=yes:2')
vim.opt.relativenumber = false
vim.opt.number = false

vim.api.nvim_create_user_command(
  'Lines',
  function(args)
    if args.args == "comfy" then
      vim.cmd('ComfyLineNumbers enable')
      vim.opt.number = false
    elseif args.args == "normal" then
      vim.cmd('ComfyLineNumbers disable')
      vim.opt.number = true
    else
      print("Invalid argument.")
    end
  end,
  { nargs = 1 }
)

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
  vim.cmd('w')
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

local lazy_opts = {
  dev = {
    path = '/Users/miles.luders/personal'
  }
}

require("lazy").setup({
  {
    'rebelot/kanagawa.nvim',
    config = function()
      vim.cmd("colorscheme kanagawa")
    end
  },
  { 'tpope/vim-sleuth' }, -- Detect tabstop and shiftwidth automatically
  {
    'kana/vim-textobj-entire',
    dependencies = {
      'kana/vim-textobj-user'
    }
  },
  { 'nvim-tree/nvim-web-devicons' },
  {
    'mluders/comfy-line-numbers.nvim',
    opts = {
      up_key = 'l',
      down_key = 'h',
      labels = {
        '1', '2', '3', '4', '5', '12', '13', '14', '15', '21',
        '23', '24', '25', '31', '32', '33', '34', '35', '41', '42', '43',
        '44', '45', '51', '52', '53', '54', '55', '91', '92', '93', '94', '95',
        '81', '82', '83', '84', '85', '10', '20', '30', '40', '50', '71', '72',
        '73', '74', '75', '61', '62', '63', '64', '65'
      }
    },
  },
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
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    name = "harpoon",
    config = function()
      local harpoon = require('harpoon')

      harpoon:setup({
        settings = {
          save_on_toggle = true
        }
      })

      -- basic telescope configuration
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
        end

        require("telescope.pickers").new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
                results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
        }):find()
      end

      vim.keymap.set("n", "<C-h>", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })
      vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
      vim.keymap.set("n", "<leader>n", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<leader>e", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<leader>i", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<leader>o", function() harpoon:list():select(4) end)
    end
  },
  -- -- {
  -- --   'VonHeikemen/lsp-zero.nvim', branch = 'v3.x',
  -- --   config = function()
  -- --     local lsp_zero = require('lsp-zero')
  -- --
  -- --     lsp_zero.on_attach(function(client, bufnr)
  -- --       -- see :help lsp-zero-keybindings
  -- --       -- to learn the available actions
  -- --       lsp_zero.default_keymaps({buffer = bufnr})
  -- --     end)
  -- --
  -- --     -- to learn how to use mason.nvim
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

  { 'neovim/nvim-lspconfig' },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' } ,
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  -- { 'hrsh7th/cmp-path' },
}, lazy_opts)

-- vim.diagnostic.config({
--   signs = { priority = 1 }
-- })

vim.diagnostic.disable()

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    -- these will be buffer-local keybindings
    -- because they only work if you have an active language server

    -- vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
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

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local default_setup = function(server)
  require('lspconfig')[server].setup({
    capabilities = lsp_capabilities,
  })
end

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    default_setup,
  },
})

local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = cmp.mapping.preset.insert({
    -- Enter key confirms completion item
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl + space triggers completion menu
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

require("set")
require("map")

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
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  "tpope/vim-fugitive",
  "nvim-tree/nvim-web-devicons",
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  { "j-hui/fidget.nvim", opts = {} },
  -- { 'hrsh7th/cmp-path' },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'kana/vim-textobj-entire', dependencies = { 'kana/vim-textobj-user' } },
  {
    'rebelot/kanagawa.nvim',
    config = function() vim.cmd("colorscheme kanagawa") end
  },
  {
    'mluders/comfy-line-numbers.nvim',
    opts = {
      up_key = 'l',
      down_key = 'h',
      labels = {
        '1', '2', '3', '4', '5', '12', '13', '14', '15', '21', '23', '24', '25',
        '31', '32', '33', '34', '35', '41', '42', '43', '44', '45', '51', '52',
        '53', '54', '55', '91', '92', '93', '94', '95', '81', '82', '83', '84',
        '85', '10', '20', '30', '40', '50', '71', '72', '73', '74', '75', '61',
        '62', '63', '64', '65'
      }
    },
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'debugloop/telescope-undo.nvim',
      'BurntSushi/ripgrep',
      'nvim-telescope/telescope-fzf-native.nvim',
      { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" }
    },
    config = function() require("plugin/telescope") end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function() require("plugin/treesitter") end
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    name = "harpoon",
    config = function() require("plugin/harpoon") end
  }
})

require("lsp")

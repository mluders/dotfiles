require("miles/set")
require("miles/map")

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
  {
    'rebelot/kanagawa.nvim',
    priority = 1000, -- load this before all the other start plugins
    lazy = false,
    config = function()
      vim.cmd("colorscheme kanagawa")
    end
  },
  "nvim-tree/nvim-web-devicons",
  "tpope/vim-sleuth", -- detect tabstop and shiftwidth automatically
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  {
    -- TODO: This is installed purely for "alternate file." Find a leaner approach.
    "tpope/vim-rails",
    config = function ()
      vim.keymap.set("n", "ga", function() vim.cmd('A') end)
    end
  },
  { 'kana/vim-textobj-entire', dependencies = { 'kana/vim-textobj-user' } },
  { 'beloglazov/vim-textobj-quotes', dependencies = { 'kana/vim-textobj-user' } },
  { "j-hui/fidget.nvim", opts = {} },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
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
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp"
    },
    config = function() require("miles/lsp") end
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function() require("miles/cmp") end
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'debugloop/telescope-undo.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
      { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" }
    },
    config = function() require("miles/telescope") end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function() require("miles/treesitter") end
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    name = "harpoon",
    config = function() require("miles/harpoon") end
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("miles/fzf-lua") end
  }
})

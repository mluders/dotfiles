-- Enable true color support
vim.opt.termguicolors = true

-- Ignore case if search pattern contains lowercase letters only
vim.opt.ignorecase = true
vim.opt.smartcase = true

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
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.cursorline = true

-- Play nicely with lualine
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Right margin
vim.opt.colorcolumn = '80'

-- Automatically change to insert mode any time a terminal is opened
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  group = vim.api.nvim_create_augroup('user_term_open', { clear = true }),
  pattern = { '*' },
  command = "startinsert"
})

vim.filetype.add({
  pattern = {
    ['.*/.*%.jack'] = 'jack',
  },
})

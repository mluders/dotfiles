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
vim.opt.relativenumber = false
vim.opt.number = false

-- Make sure relative numbers are enabled
vim.opt.number = true
vim.opt.relativenumber = true
-- vim.opt.statuscolumn = "%@SignCb@%s%=%T%@NumCb@%l│%T"
vim.cmd([[
function! GetLabel(n)
  let labels = [
  \ '1', '2', '3', '4', '5',
  \ '11', '12', '13', '14', '15',
  \ '21', '22', '23', '24', '25',
  \ '31', '32', '33', '34', '35',
  \ '41', '42', '43', '44', '45',
  \ '51', '52', '53', '54', '55'
  \ ]

  if a:n > 0 && a:n <= len(labels)
    return labels[a:n - 1]
  else
    return a:n
  endif
endfunction

  let &stc='%=%s%=%{GetLabel(v:relnum)} '
]])

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Right margin
vim.opt.colorcolumn = '80'

-- Map leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Automatically change to insert mode any time a terminal is opened
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  group = vim.api.nvim_create_augroup('user_term_open', {clear = true}),
  pattern = { '*' },
  command = "startinsert"
})

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

vim.filetype.add({
  pattern = {
    ['.*/.*%.jack'] = 'jack',
  },
})

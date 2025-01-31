-- Swap directional keys to make them more comfortable with Colemak
vim.keymap.set({ 'n', 'v', 's', 'o' }, "j", "h", { silent = true, noremap = true })
vim.keymap.set({ 'n', 'v', 's', 'o' }, "k", "l", { silent = true, noremap = true })
vim.keymap.set({ 'n', 'v', 's', 'o' }, "l", "k", { silent = true, noremap = true })
vim.keymap.set({ 'n', 'v', 's', 'o' }, "h", "j", { silent = true, noremap = true })

-- Easier saving
vim.keymap.set("n", "<leader>s", ":w<CR>")

-- Move lines up/down
vim.keymap.set("v", "L", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "H", ":m '>+1<CR>gv=gv")

-- Remap semicolon to colon
vim.keymap.set({ 'n', 'v' }, ';', ':', { silent = false, noremap = true })
vim.keymap.set({ 'n', 'v' }, ':', ';', { silent = false, noremap = true })

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
vim.keymap.set("n", "<leader>c", "<cmd>let @+=@%<CR>")

-- When I `dd` a blank line, I don't want to copy it
vim.keymap.set("n", "dd", function()
  if vim.trim(vim.fn.getline(".")) == "" then
    return '"0dd'
  else
    return 'dd'
  end
end, { expr = true, noremap = true })

-- Make single quote jump to marked character instead of marked line.  We will
-- want to do this much more often - and single quote is easier to hit than
-- backtick.
vim.keymap.set("n", "'", "`", { noremap = true })
vim.keymap.set("n", "`", "'", { noremap = true })

-- Cancel the current search highlight
vim.keymap.set("", "<Leader>/", ":nohlsearch<CR>")

-- Use tab / shift-tab to go through tabs
vim.keymap.set("n", "<TAB>", ":tabnext<CR>", { noremap = true })
vim.keymap.set("n", "<S-TAB>", ":tabprevious<CR>", { noremap = true })
vim.keymap.set("", "<Leader><TAB>", ":tabprevious<CR>")

-- Shortcuts to open / close tabs
vim.keymap.set("", "<Leader>to", ":tabnew<CR>")
vim.keymap.set("", "<Leader>tc", ":tabclose<CR>")

-- Shortcuts for horizontal and vertical split
vim.keymap.set("", "<Leader>|", ":vsplit<CR>")
vim.keymap.set("", "<Leader>-", ":split<CR>")

-- Open a terminal
vim.keymap.set("", "<Leader>tt", ":term<CR>")

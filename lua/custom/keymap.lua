-- Make single quote jump to marked character instead of marked line.  We will
-- want to do this much more often - and single quote is easier to hit than
-- backtick.
vim.keymap.set("n", "'", "`", { noremap = true })
vim.keymap.set("n", "`", "'", { noremap = true })

-- Cancel the current search highlight
vim.keymap.set("", "<Leader>/", ":nohlsearch<CR>", { desc = "Clear search term" })

-- Shortcuts to open a tab
vim.keymap.set("", "<Leader>ot", ":tabnew<CR>", { desc = "Open new tab" })

-- Use tab / shift-tab to go through tabs
vim.keymap.set("n", "<TAB>", ":tabnext<CR>", { noremap = true })
vim.keymap.set("n", "<S-TAB>", ":tabprevious<CR>", { noremap = true })

-- Shortcuts for horizontal and vertical split
vim.keymap.set("", "<Leader>|", ":vsplit<CR>", { desc = "Split vertically" })
vim.keymap.set("", "<Leader>-", ":split<CR>", { desc = "Split horizontally" })

-- Open a terminal
vim.keymap.set("", "<Leader>tt", ":term<CR>", { desc = "Open terminal" })

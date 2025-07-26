-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- Open with f key
vim.keymap.set("", "<Leader>f", ":NvimTreeOpen<CR>", { desc = "Open file browser" })

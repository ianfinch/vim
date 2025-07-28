-- Turn off colouriser by default
require("colorizer").setup({
    filetypes = {}
})

-- Provide a key to toggle it on and off
vim.keymap.set("n", "<Leader>c", ":ColorizerToggle<CR>", { desc = "Toggle colour display" })

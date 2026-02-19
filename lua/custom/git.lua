require("gitsigns").setup({
      signs = {
        add          = { text = '+' },
        change       = { text = '~' },
        delete       = { text = '-' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '?' },
      },
      signs_staged = {
        add          = { text = '+' },
        change       = { text = '~' },
        delete       = { text = '-' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '?' },
      },
      signs_staged_enable = true
})

-- For git signs
vim.keymap.set("", "<Leader>gd", ":Gitsigns preview_hunk<CR>", { desc = "Git diff current hunk" })
vim.keymap.set("", "<Leader>gb", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle inline git blame" })

-- For fugitive
vim.keymap.set("", "<Leader>gB", ":Git blame<CR>", { desc = "Git blame" })
vim.keymap.set("", "<Leader>gD", ":Gvdiffsplit<CR>", { desc = "Git diff split window" })
vim.keymap.set("", "<Leader>gg", ":Git<CR>", { desc = "Open git" })
vim.keymap.set("", "<Leader>gl", ":Gllog<CR>", { silent = true, desc = "Git log" })

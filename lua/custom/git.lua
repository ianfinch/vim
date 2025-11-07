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
vim.keymap.set("", "<Leader>gD", ":Gitsigns preview_hunk_inline<CR>", { desc = "Git diff current hunk inline" })
vim.keymap.set("", "<Leader>gb", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle inline git blame" })

-- For fugitive
vim.keymap.set("", "<Leader>gB", ":Git blame<CR>", { desc = "Git blame" })
vim.keymap.set("", "<Leader>gl", ":Git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(blue)<%an>%Creset' --abbrev-commit<CR>", { silent = true, desc = "Git log" })

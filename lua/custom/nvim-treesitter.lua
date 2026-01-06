require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "bash",
        "c",
        "css",
        "dockerfile",
        "html",
        "java",
        "javascript",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "typescript",
        "vim",
        "vimdoc"
    },
    auto_install = false,
    highlight = {
        enable = true,
    },
}

vim.keymap.set("", "<Leader>oT", ":InspectTree<CR>", { desc = "Open tree sitter" })

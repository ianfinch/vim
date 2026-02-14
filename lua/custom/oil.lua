require("oil").setup()

require("oil-git").setup({
    debounce_ms = 50,
    show_file_highlights = true,
    show_directory_highlights = true,
    show_file_symbols = true,
    show_directory_symbols = true,
    show_ignored_files = true,       -- Show ignored file status
    show_ignored_directories = true, -- Show ignored directory status
    symbol_position = "eol",  -- "eol", "signcolumn", or "none"
    ignore_gitsigns_update = false,   -- Ignore GitSignsUpdate events (fallback for flickering)
    debug = false,            -- false, "minimal", or "verbose"

    symbols = {
        file = {
            added = "+",
            modified = "~",
            renamed = "R",
            deleted = "D",
            copied = "C",
            conflict = "!",
            untracked = "?",
            ignored = "o"
        },
        directory = {
            added = "*",
            modified = "~",
            renamed = "R",
            deleted = "D",
            copied = "C",
            conflict = "!",
            untracked = "?",
            ignored = "o"
        },
    },
})

-- Minus key to open Oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

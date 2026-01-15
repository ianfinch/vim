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
            renamed = "->",
            deleted = "D",
            copied = "C",
            conflict = "!",
            untracked = "?",
            ignored = "o"
        },
        directory = {
            added = "*",
            modified = "*",
            renamed = "*",
            deleted = "*",
            copied = "*",
            conflict = "!",
            untracked = "*",
            ignored = "o"
        },
    },

    -- Colors (only applied if highlight groups don't exist)
    highlights = {
        OilGitAdded = { fg = "#a6e3a1" },
        OilGitModified = { fg = "#f9e2af" },
        OilGitRenamed = { fg = "#cba6f7" },
        OilGitDeleted = { fg = "#f38ba8" },
        OilGitCopied = { fg = "#cba6f7" },
        OilGitConflict = { fg = "#fab387" },
        OilGitUntracked = { fg = "#89b4fa" },
        OilGitIgnored = { fg = "#6c7086" },
    },
})

-- Minus key to open Oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

require("nvim-test").setup({})

require('nvim-test.runners.jest'):setup {
    command = "jest",
    args = { "--collectCoverage=true" },
    file_pattern = "\\v(__tests__/.*|(spec|test))\\.(js|jsx|coffee|ts|tsx)$",
    find_files = { "{name}.test.{ext}", "{name}.spec.{ext}" },
    filename_modifier = nil,
    working_directory = nil,
}

vim.keymap.set("n", "<Leader>ts", "<CMD>TestSuite<CR>", { desc = "Run test suite" })

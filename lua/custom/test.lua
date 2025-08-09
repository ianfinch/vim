require("nvim-test").setup({})

require('nvim-test.runners.jest'):setup {
    command = "jest",
    args = { "--collectCoverage=true" },
    file_pattern = "\\v(__tests__/.*|(spec|test))\\.(js|jsx|coffee|ts|tsx)$",
    find_files = { "{name}.test.{ext}", "{name}.spec.{ext}" },
    filename_modifier = nil,
    working_directory = nil,
}

-- Initialise the coverage data
local coverage = nil
local function initCoverage()

    coverage = require("coverage")
    coverage.setup({
        highlights = {
            covered = { bg = "#ccff99", fg = "#009900" },
            uncovered = { bg = "#ffcccc", fg = "#ff0000" },
            partial = { bg = "#ffcccc", fg = "#ff0000" },
        },
        signs = {
            covered = { text = "┃" },
            uncovered = { text = "┃" },
            partial = { text = "┃" },
        }
    })
end

-- Toggle the coverage display
local function toggleCoverage()

    if coverage == nil then
        initCoverage()
        coverage.load(true)
    else
        coverage.toggle()
    end
end

-- Display the coverage summary
local function showCoverageSummary()

    if coverage == nil then
        initCoverage()
        coverage.load()
    end
    coverage.summary()
end

vim.keymap.set("n", "<Leader>tr", "<CMD>TestSuite<CR>", { desc = "Run test suite" })
vim.keymap.set("n", "<Leader>tc", toggleCoverage, { desc = "Show/hide test coverage" })
vim.keymap.set("n", "<Leader>ts", showCoverageSummary, { desc = "Show test summary" })

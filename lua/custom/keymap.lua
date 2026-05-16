-- My utility functions
local utils = require("custom.utils")

-- Use popup a couple of times
local popup = require("plenary.popup")

-- Make single quote jump to marked character instead of marked line.  We will
-- want to do this much more often - and single quote is easier to hit than
-- backtick.
vim.keymap.set("n", "'", "`", { noremap = true })
vim.keymap.set("n", "`", "'", { noremap = true })

-- Cancel the current search highlight
vim.keymap.set("", "<Leader>/", ":nohlsearch<CR>", { desc = "Clear search term" })

-- Shortcuts to open and close a tab
vim.keymap.set("", "<Leader>ot", ":tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("", "<Leader>xt", ":tabclose<CR>", { desc = "Close current tab" })

-- Use tab / shift-tab to go through tabs
vim.keymap.set("n", "<TAB>", ":tabnext<CR>", { noremap = true })
vim.keymap.set("n", "<S-TAB>", ":tabprevious<CR>", { noremap = true })

-- In insert mode, insert a tab unless we're inserting a snippet
vim.keymap.set({ "i", "s" }, "<Tab>", function()
    if vim.snippet.active({ direction = 1 }) then
        return "<Cmd>lua vim.snippet.jump(1)<CR>"
    else
        return "<Tab>"
    end
end, { expr = true })

-- Shortcuts for horizontal and vertical split
vim.keymap.set("", "<Leader>|", ":vsplit<CR>", { desc = "Split vertically" })
vim.keymap.set("", "<Leader>-", ":split<CR>", { desc = "Split horizontally" })

-- Toggle between splits being equal or not
vim.keymap.set("", "<Leader>%", function()
    if vim.opt.equalalways._value == false then
        vim.opt.equalalways = true
    else
        vim.opt.equalalways = false
    end
end, { desc = "Toggle equal window splits" })

-- Open a terminal
vim.keymap.set("", "<Leader>tt", ":term<CR>", { desc = "Open terminal" })

-- Add a new buffer
local function createBuffer()

    local newBuffer = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_win_set_buf(0, newBuffer)
end

vim.keymap.set("", "<Leader>+b", createBuffer, { desc = "Add a new buffer" })

-- Add a new scratch buffer
local function createScratch()

    local newBuffer = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_win_set_buf(0, newBuffer)
end

vim.keymap.set("", "<Leader>+s", createScratch, { desc = "Add a scratch buffer" })

-- Insert a random character
local function insertRandomCharacter()

    -- The set of characters to choose from
    local chars = "abcdefghijklmnopqrstuvwxyz0123456789"

    -- We might have a numeric prefix, so we need somewhere to build up a string of that length
    local stringToInsert = ""

    -- Choose a random character
    math.randomseed(os.time())
    for n = 1, math.max(1, vim.v.count) do
        local randomOffset = math.random(string.len(chars))
        local randomChar = string.sub(chars, randomOffset, randomOffset)
        stringToInsert = stringToInsert .. randomChar
    end

    -- Insert at the cursor position
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_buf_set_text(0, row - 1, col, row -1, col, { stringToInsert })
end
vim.keymap.set("", "<Leader>ir", insertRandomCharacter, { desc = "Insert a random character from [0-9a-z]" })

-- Easy access to unicode characters
local function displayUnicodeCharacters()

    -- Open a popup to select a character
    local chars = "– — … ¼ ½ ¾ © ® │ ─ ┌ ┬ ┐ └ ┴ ┘ ├ ┼ ┤"
    local height = 1
    local width = string.len(chars)
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    local unicodePopupId = popup.create(chars, {
        title = "Unicode",
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        minwidth = width,
        minheight = height,
        borderchars = borderchars
    })

    -- Insert a character from the popup
    function insertUnicodeCharacter()

        -- Find the character
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local char = vim.api.nvim_get_current_line():sub(col + 1, col + 4)

        -- Close the popup
        vim.api.nvim_win_close(unicodePopupId, true)

        -- Insert the character
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { char })
    end

    local buff = vim.api.nvim_win_get_buf(unicodePopupId)
    vim.api.nvim_buf_set_keymap(buff, "n", "<CR>", ":lua insertUnicodeCharacter()<CR>", { silent = true })
    vim.api.nvim_buf_set_keymap(buff, "n", "q", ":lua vim.api.nvim_win_close(0, true)<CR>", { silent = true })

end
vim.keymap.set("", "<Leader>u", displayUnicodeCharacters, { desc = "Insert unicode characters" })

-- Enable our ripgrep keymaps
vim.keymap.del("", "<Leader>rg")
vim.keymap.del("", "<Leader>rw")
vim.keymap.set("", "<Leader>o/", ":Rg<CR>", { desc = "Find using ripgrep" })
vim.keymap.set("", "<Leader>o?", ":Rg <cword><CR>", { desc = "Find current word" })

-- Run a curl command via Resty
vim.keymap.set({ "n", "v" }, "<Leader>oc", ":Resty run<CR>", { desc = "Curl using Resty" })

-- Set the working directory to the current directory
local function setWorkingDirectory()
    local wd = vim.fn.expand("%:p:h")

    -- Make sure we've got a file to work with
    if wd == "" then
        vim.print("ERROR: No file open in vim")
        return
    end

    -- Handle if we're in an oil file selector
    if string.sub(wd, 1, 6) == "oil://" then

        -- Remove the oil prefix
        wd = string.sub(wd, 7)

        -- Oil seems to always return a unix path, which we will need to
        -- convert if we are running on Windows
        wd = utils.toUnixPath(wd)
    end

    -- Set the directory
    vim.cmd.cd(wd)
    vim.print("INFO: Directory has been set to " .. wd)
end
vim.keymap.set("", "<Leader>d", setWorkingDirectory, { desc = "Set working directory" })

-- Toggle custom formatting based on file extension
local function toggleCustomFormat()

    local ext = vim.bo.filetype

    if ext == "csv" and vim.fn.exists(":CsvViewToggle") > 0 then
        vim.cmd("CsvViewToggle")
    elseif ext == "markdown" and vim.fn.exists(":TableTidy") > 0 then
        vim.cmd("TableTidy")
    else
        vim.notify("No format defined for filetype: " .. ext, vim.log.levels.WARN, {})
    end
end
vim.keymap.set("", "<Leader>f", toggleCustomFormat, { desc = "Toggle custom formatting" })

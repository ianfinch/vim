-- Make single quote jump to marked character instead of marked line.  We will
-- want to do this much more often - and single quote is easier to hit than
-- backtick.
vim.keymap.set("n", "'", "`", { noremap = true })
vim.keymap.set("n", "`", "'", { noremap = true })

-- Cancel the current search highlight
vim.keymap.set("", "<Leader>/", ":nohlsearch<CR>", { desc = "Clear search term" })

-- Shortcuts to open a tab
vim.keymap.set("", "<Leader>ot", ":tabnew<CR>", { desc = "Open new tab" })

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

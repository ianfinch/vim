--
-- Quick way to select recent files, using vim's built-in "oldfiles" variable
--

-- Use Plenary for our popup
local popup = require("plenary.popup")

-- The ID for the current window
local originalWindow

-- The ID for our window
local winId

-- Function to close the recent menu
function closeRecentMenu()

    vim.api.nvim_win_close(winId, true)
end

-- Function to open the recent files popup
local function showRecentMenu(options, callback)

    -- Grab the current window id
    originalWindow = vim.api.nvim_get_current_win()

    -- Create the popup window for the file list
    local height = 20
    local width = 60
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    winId = popup.create(options, {
        title = "Recent Files",
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        minwidth = width,
        maxwidth = width,
        minheight = height,
        maxheight = height,
        borderchars = borderchars,
        callback = callback,
    })
    vim.wo[winId].wrap = false

    -- Set up q to close the file list
    local buff = vim.api.nvim_win_get_buf(winId)
    vim.api.nvim_buf_set_keymap(buff, "n", "q", "<cmd>lua closeRecentMenu()<CR>", { silent = false })
end

-- Function to get the recent files and open the popup
local function openRecents()

    -- Function to open the selected file
    local openSelectedFile = function(_, selected)

        local newBuffer = vim.fn.bufadd(selected)
        vim.api.nvim_win_set_buf(originalWindow, newBuffer)
    end

    -- Get the recent files
    local recentFiles = vim.api.nvim_get_vvar("oldfiles")

    -- Display the file list
    showRecentMenu(recentFiles, openSelectedFile)
end

-- Function to stop entering a snippet
local function exitSnippet()

    vim.snippet.stop()
end

-- Set up the key to open the recent list
vim.keymap.set("", "<Leader>or", openRecents, { desc = "Open recent file list" })

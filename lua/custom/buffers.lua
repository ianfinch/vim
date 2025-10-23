--
-- Buffer utility
--

-- Use Plenary for our popup
local popup = require("plenary.popup")

-- The ID for our window
local winId

-- Function to close the buffer menu
function closeBufferList()

    vim.api.nvim_win_close(winId, true)
end

-- Find the buffer number from the current line in the popup
function getBufferNumber()

    -- Get the current line from the popup
    local lineUnderCursor = vim.api.nvim_get_current_line()

    -- Extract the buffer number
    local parts = vim.fn.split(lineUnderCursor, "]")
    parts = vim.fn.split(parts[1], "[")
    bufferNumber = tonumber(parts[1])

    return bufferNumber
end

-- Function to delete a buffer
function deleteBuffer()

    bufferNumber = getBufferNumber()

    -- Delete the buffer
    vim.bo[bufferNumber].buflisted = false
    vim.api.nvim_buf_delete(bufferNumber, { unload = true })

    -- Close the popup window
    vim.api.nvim_win_close(winId, true)
end

-- Function to toggle read-only on a buffer
function readonlyBuffer()

    bufferNumber = getBufferNumber()

    if vim.bo[bufferNumber].readonly then
        vim.bo[bufferNumber].readonly = false
    else
        vim.bo[bufferNumber].readonly = true
    end

    vim.api.nvim_win_close(winId, true)
end

-- Function to open the buffer list
local function showBufferList(options, callback)

    local height = 20
    local width = 50
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    winId = popup.create(options, {
        title = "Buffers",
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        minwidth = width,
        minheight = height,
        borderchars = borderchars,
        callback = callback,
    })

    -- Press q to quit
    local buff = vim.api.nvim_win_get_buf(winId)
    vim.api.nvim_buf_set_keymap(buff, "n", "q", "<cmd>lua closeBufferList()<CR>", { silent = false })

    -- Press d to delete a buffer
    vim.api.nvim_buf_set_keymap(buff, "n", "d", "<cmd>lua deleteBuffer()<CR>", { silent = false })

    -- Press r to toggle read-only
    vim.api.nvim_buf_set_keymap(buff, "n", "r", "<cmd>lua readonlyBuffer()<CR>", { silent = false })
end

-- Function to start buffer interaction
local function openBufferList()

    -- Store the window we are in
    local originalWindow = vim.fn.win_getid()

    -- Get a list of all windows and their buffers
    local windowIds = vim.api.nvim_list_wins()
    local windowsByBuffer = {}
    for _, windowId in ipairs(windowIds) do

        -- Get the buffer for this window
        local bufferInWindow = vim.api.nvim_win_get_buf(windowId)

        -- Get the window's number
        local windowNumber = vim.api.nvim_win_get_number(windowId)

        -- Store the info
        windowsByBuffer[bufferInWindow] = windowNumber
    end

    -- Get a list of all current buffers
    local bufferIds = vim.api.nvim_list_bufs()
    local buffers = {}
    local bufferLookup = {}
    local n = 0
    for _, bufferId in ipairs(bufferIds) do

        -- Check the buffer is loaded
        if vim.api.nvim_buf_is_loaded(bufferId) then

            -- Update our array index
            n = n + 1

            -- Get the buffer name and take it down to the file name
            local bufferName = vim.api.nvim_buf_get_name(bufferId)
            bufferName = bufferName:gsub("^.*/", "")

            -- If the buffer doesn't have a name, create a placeholder
            if bufferName == "" then

                bufferName = "Unnamed buffer"
            end

            -- Add the buffer name to our array and also store the reverse mapping
            buffers[n] = "[" .. string.format("%02d", bufferId) .. "] " .. bufferName

            -- If the buffer is modified, add that
            if vim.bo[bufferId].modified then

                buffers[n] = buffers[n] .. "+"
            end

            -- If the buffer is read-only, add that
            if vim.bo[bufferId].readonly then

                buffers[n] = buffers[n] .. " R"
            end

            -- If this has a window, add that
            if windowsByBuffer[bufferId] then

                buffers[n] = buffers[n] .. " (win #" .. windowsByBuffer[bufferId] .. ")"
            end

            -- Store the buffer info
            bufferLookup[buffers[n]] = bufferId
        end
    end

    -- Function to map the buffer
    local mapBuffer = function(_, selected)

        vim.api.nvim_win_set_buf(originalWindow, bufferLookup[selected])
    end

    -- Display the list of snippets
    showBufferList(buffers, mapBuffer)
end

-- Set up the keys to manage buffers
vim.keymap.set("", "<Leader>ob", openBufferList, { desc = "Map a buffer (experimental)" })

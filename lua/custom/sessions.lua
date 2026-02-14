--
-- Simple approach to saving and loading sessions
--

-- Use Plenary for our popup
local popup = require("plenary.popup")
--
-- The ID for our plenary popup
local popupId

-- Directory for our sessions
local sessionDir = vim.fn.stdpath("data") .. "/sessions"

-- Derive a session filename, based on the current directory
function getSessionFile()

    local cwd = vim.fn.getcwd()
    local removedNonAlphanumeric = string.gsub(cwd, "[^A-Za-z0-9]", "_")
    local removedMultiples = string.gsub(removedNonAlphanumeric, "__*", "_")
    local removedLeading = string.gsub(removedMultiples, "^_", "")

    return sessionDir .. "/" .. removedLeading
end

-- Function to save a session
function saveSession()

    -- Create the session directory if we don't have one
    if vim.fn.isdirectory(sessionDir) == 0 then
        vim.fn.mkdir(sessionDir, "p")
    end

    -- Create the session file
    local sessionFile = getSessionFile()
    local success, _ = pcall(vim.cmd, "mksession! " .. sessionFile)
    if success then
        print("INFO: Session file created: " .. sessionFile)
        vim.cmd("redraw")
    else
        print("ERROR: Unable to make session: " .. sessionFile)
    end
end

-- Function to load a session with the file passed as a parameter
function loadSessionFile(sessionFile)

    if vim.fn.filereadable(sessionFile) == 1 then
        vim.cmd("source " .. sessionFile)
        vim.cmd("redraw")
    else
        vim.print("ERROR: No session file exists for this directory")
    end
end

-- Function to load a session
function loadSession()

    local sessionFile = getSessionFile()
    loadSessionFile(sessionFile)
end

-- Function to close our popup listing sessions
function closeSessionList()

    vim.api.nvim_win_close(popupId, true)
end

-- Function to list our saved sessions
function listSessions()

    -- Get the list of sessions to display
    function getSavedSessions()

        local sessionPaths = vim.split(vim.fn.glob(sessionDir .. "/*"), "\n", { trimempty=true })
        local sessions = {}
        for _, session in ipairs(sessionPaths) do
            local sessionName, _ = string.gsub(session, "^" .. sessionDir .. "/", "")
            table.insert(sessions, sessionName)
        end

        return sessions
    end
    local sessions = getSavedSessions()

    -- Function to select a session
    function selectSession()

        local selected, _ = unpack(vim.api.nvim_win_get_cursor(popupId))
        vim.api.nvim_win_close(popupId, true)
        if selected <= #sessions then
            loadSessionFile(sessionDir .. "/" .. sessions[selected])
        end
    end

    -- Function to delete a session
    function deleteSession()

        -- Delete the session
        local selected, _ = unpack(vim.api.nvim_win_get_cursor(popupId))
        local confirm = vim.fn.confirm("Delete session: " .. sessions[selected] .. "?", "&Yes\n&No", 2)
        if confirm == 1 then
            os.remove(sessionDir .. "/" .. sessions[selected])
        end

        -- Update the session list in the popup
        local buff = vim.api.nvim_win_get_buf(popupId)
        sessions = getSavedSessions()
        vim.api.nvim_buf_set_lines(buff, 0, -1, true, sessions)
    end

    -- Display the session menu
    local height = 20
    local width = 30
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    popupId = popup.create(sessions, {
        title = "Sessions",
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        minwidth = width,
        minheight = height,
        borderchars = borderchars
    })
    local buff = vim.api.nvim_win_get_buf(popupId)
    vim.api.nvim_buf_set_keymap(buff, "n", "<CR>", "<cmd>lua selectSession()<CR>", { silent = false })
    vim.api.nvim_buf_set_keymap(buff, "n", "d", "<cmd>lua deleteSession()<CR>", { silent = false })
    vim.api.nvim_buf_set_keymap(buff, "n", "q", "<cmd>lua closeSessionList()<CR>", { silent = false })
end

-- Set up keys to save and load sessions
vim.keymap.set("", "<Leader>ss", saveSession, { desc = "Save the current session" })
vim.keymap.set("", "<Leader>sl", loadSession, { desc = "Load a saved session" })
vim.keymap.set("", "<Leader>s?", listSessions, { desc = "List saved sessions" })

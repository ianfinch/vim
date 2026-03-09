--
-- Shortcuts to run npm commands
--

-- My utility functions
local utils = require("custom.utils")

-- Variables to interact with an npm command
local jobId = false
local bufferId = false
local channelId = false

-- Run a command and send the output to a buffer
local function runCommand(cmd)

    -- Handle return in the npm buffer
    function npmHandleReturn()
        local arg = vim.fn.expand("<cword>")
        runCommand("npm run " .. arg)
    end

    -- Utility function to write output to buffer
    local function writeOutput(msg)

        vim.api.nvim_chan_send(channelId, msg)
        vim.api.nvim_chan_send(channelId, "\n")
    end

    -- We want to do this in a new tab
    vim.cmd("tabnew")

    -- We need an output buffer
    if not bufferId then

        bufferId = vim.api.nvim_create_buf(true, true)
        channelId = vim.api.nvim_open_term(bufferId, {})
        vim.api.nvim_buf_set_keymap(bufferId, "n", "<CR>", ":lua npmHandleReturn()<CR>", { silent = true })
    end

    -- Add a timestamp to the buffer
    local timestamp = "Timestamp: " .. utils.timestamp()
    local cmdString = "Command: " .. cmd
    local maxLength = math.max(string.len(timestamp), string.len(cmdString))
    local fmt = "[30;103m ┃ %-" .. maxLength .. "s ┃ [0m"
    writeOutput("[30;103m ┏" .. string.rep("━", maxLength + 2) .. "┓ [0m")
    writeOutput(string.format(fmt, timestamp))
    writeOutput(string.format(fmt, cmdString))
    writeOutput("[30;103m ┗" .. string.rep("━", maxLength + 2) .. "┛ [0m")

    -- Use the current window to display the buffer
    vim.api.nvim_win_set_buf(0, bufferId)

    -- Now we can run the command
    jobId = vim.fn.jobstart(cmd .. " --color always", {

        on_stdout = function(_, data)
            writeOutput(data[1])
        end,

        on_stderr = function(_, data)
            writeOutput(data[1])
        end,

        on_exit = function(_, exitCode)
            writeOutput(string.format("Command exited with code %s", exitCode))
            if not exitCode == 0 then
                vim.api.nvim_err_writeln(string.format("Command exited with code %s", exitCode))
            end
        end
    })
end

-- This gets our available npm commands to run
function getNpmCommands()

    -- Get a list of available commands
    runCommand("npm run")
end

-- Define a key to start our npm process
vim.keymap.set("", "<Leader>on", getNpmCommands, { desc = "Run npm commands" })

-- Create an Npm command within neovim
local function handleNpmCommand(passedIn)

    runCommand("npm " .. passedIn.args)
end
vim.api.nvim_create_user_command("Npm", handleNpmCommand, { nargs = "*", desc = "Allow npm commands direct from neovim" })

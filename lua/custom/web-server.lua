-- Start and stop a web server (needs live-server installed)

-- Somewhere for the job ID, so we can track status
local jobId = false

-- A buffer to write output to
local bufferId = false

-- Check if a job is running
function serverIsRunning()

    -- If there's no jobId, then nothing is running
    if not jobId then
        return false

    end

    -- Otherwise use job control to check status
    return vim.fn.jobwait({ jobId }, 0)[1] == -1
end

-- Add output to the log buffer
function log(level, msg)

    vim.api.nvim_buf_set_lines(bufferId, -1, -1, true, { level .. " " .. msg })
end

-- Start the server
function startServer()

    -- Our web server command
    local cmd = { "live-server", "--verbose" }

    -- Only start a server if we don't already have one running
    if serverIsRunning() then

        vim.api.nvim_err_writeln("ERROR: A web server is already running")
        return
    end

    -- If we don't have an output buffer, create one
    if not bufferId then

        bufferId = vim.api.nvim_create_buf(true, true)
        vim.api.nvim_open_win(bufferId, false, { win = 0, split = "below" })
    end

    -- Actually start the server
    jobId = vim.fn.jobstart(cmd, {

        on_stdout = function(_, data)

            log("INFO", data[1])
        end,

        on_stderr = function(_, data)

            log("ERROR", data[1])
        end,

        on_exit = function(_, exitCode)

            log("INFO", string.format("Web server stopped with code %s", exitCode))

            if not exitCode == 0 then
                vim.api.nvim_err_writeln(string.format("Web server stopped with code %s", exitCode))
            end
        end
  })
end

-- Stop the server (if it's running)
function stopServer()

    -- Check we've got a server running
    if not serverIsRunning() then

        vim.api.nvim_err_writeln("ERROR: No web server is running")
        return
    end

    -- Stop it
    local status = vim.fn.jobstop(jobId)
    if status == 0 then

        vim.api.nvim_err_writeln("ERROR: Invalid job id")
        return
    end

    -- Reset the job ID
    if not serverIsRunning() then

        jobId = false
    end
end

-- Set up keys to start and stop the server
vim.keymap.set("", "<Leader>ow", startServer, { desc = "Start web server" })
vim.keymap.set("", "<Leader>xw", stopServer, { desc = "Stop web server" })

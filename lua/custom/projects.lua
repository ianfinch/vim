--
-- Set up directory structure and files for different types of project
--

-- We want to display icons
local devicons = require"nvim-web-devicons"

-- Use Plenary for our popup
local popup = require("plenary.popup")

-- Somewhere to store our projects
local projects = {}

-- The ID for our window
local popupId

-- The ID for our file listing buffer
local fileListBuffer = nil

-- Function to close the project menu
function closeProjectsMenu()

    vim.api.nvim_win_close(popupId, true)
end

-- Function to open a project list
local function showProjectsMenu(options, callback)

    local height = 20
    local width = 30
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    popupId = popup.create(options, {
        title = "Projects",
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        minwidth = width,
        minheight = height,
        borderchars = borderchars,
        callback = callback,
    })
    local buff = vim.api.nvim_win_get_buf(popupId)
    vim.api.nvim_buf_set_keymap(buff, "n", "q", "<cmd>lua closeProjectsMenu()<CR>", { silent = false })
end

-- Function to open a project files window
local function openProjectFilesWindow(files)

    -- Create a buffer if we don't have one
    if fileListBuffer == nil then
        fileListBuffer = vim.api.nvim_create_buf(true, true)
    end

    -- Clear the buffer
    vim.api.nvim_buf_set_lines(fileListBuffer, 0, -1, true, {})

    -- Get or reuse a namespace for highlighting
    local namespace = vim.api.nvim_create_namespace("projectFileList")

    -- Display the files in the buffer, formatting into a file tree
    for idx, filename in pairs(files) do

        -- Somewhere to store the display version
        local filenameDisplay = filename

        -- If it's a directory, hide the trailing slash to prevent it being replaced by spaces
        filenameDisplay = string.gsub(filenameDisplay, "/$", "TRAILING_SLASH")

        -- Now replace all directories with spaces
        filenameDisplay = string.gsub(filenameDisplay, "[^/]*/", "  ")

        -- Put the trailing slash back
        filenameDisplay = string.gsub(filenameDisplay, "TRAILING_SLASH$", "/")

        -- Add an icon
        local extension, icon, highlight
        if string.match(filename, "/$") then
            icon = ""
            highlight = "NvimTreeFolderName"
        else
            extension = string.gsub(filename, "^[^.]*%.", "")
            icon, highlight = devicons.get_icon(filename, extension, { default = true })
        end
        filenameDisplay = string.gsub(filenameDisplay, "^( *)", "%1" .. icon .. "  ")

        -- Add this to our list of files to display
        vim.api.nvim_buf_set_lines(fileListBuffer, idx - 1, idx - 1, true, { filenameDisplay })
        vim.api.nvim_buf_set_extmark(fileListBuffer, namespace, idx - 1, 0, { hl_group = highlight, end_col = string.len(filenameDisplay) })
    end

    -- Open a window to display the file list
--    vim.api.nvim_open_win(fileListBuffer, true, {win=-1, split="left", width=40, style="minimal"})
    vim.api.nvim_open_win(fileListBuffer, true, {win=-1, split="left", width=40})
end

-- Function to start projects interaction
local function openProjects()

    -- Store the buffer number we are in
    local originalBuffer = vim.fn.bufnr()

    -- Get the list of projects
    local projectNames = {}
    local n = 0
    for k, v in pairs(projects) do

        n = n + 1
        projectNames[n] = k
    end
    table.sort(projectNames)

    -- Function to insert project
    local insertProjects = function(_, selected)

        openProjectFilesWindow(projects[selected])
    end

    -- Display the list of projects
    showProjectsMenu(projectNames, insertProjects)
end

-- Set up the keys to manage projects
vim.keymap.set("", "<Leader>op", openProjects, { desc = "Open projects" })

projects["Node"] = {
    "package.json",
    "index.js",
    "src/",
    "src/main.js",
    "src/main.spec.js",
}

projects["Web"] = {
    "public/",
    "public/index.html",
    "public/js/",
    "public/js/app.js",
    "public/js/app.spec.js",
    "public/css/",
    "public/css/app.css",
}
-- Javascript package.json starter file
--snippets["package.json"] = [[{
--    "devDependencies": {
--        "babel-jest": "^29.7.0",
--        "jest": "^29.7.0",
--        "jsdom": "^26.1.0",
--        "serve": "^14.2.4"
--    },
--    "scripts": {
--        "test": "node --experimental-vm-modules node_modules/jest/bin/jest.js --coverage",
--        "start": "npx serve"
--    },
--    "type": "module",
--    "jest": {
--        "transform": {}
--    }
--}]]

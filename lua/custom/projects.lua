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

-- Want to work on Linux and Windows, so use an OS-specific filepath separator
local pathSeparator = package.config:sub(1, 1)

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

-- Split a string into a table on newlines
local function split(phrase)

	local delimiter = "\n"
	local result = {}
	local i = 1
    for str in string.gmatch(phrase .. delimiter, "([^" .. delimiter .. "]*)" .. delimiter) do
		result[i] = str
		i = i + 1
	end

	return result
end

-- Remove one string from the front of another
local function removeStringFromStart(haystack, needle)

    -- Check the start of the string matches what we are looking for
    if string.sub(haystack, 0, string.len(needle)) == needle then

        -- Return the remainder of the string
        return string.sub(haystack, string.len(needle) + 1, -1)
    end

    -- If no match, return the original string
    return haystack
end

-- Find a buffer number from its name
local function getBufferByName(bufferName)

    local result = nil
    local cwd = vim.fn.getcwd() .. pathSeparator
    local bufferIds = vim.api.nvim_list_bufs()
    for _, bufferId in ipairs(bufferIds) do

        local shortName = removeStringFromStart(vim.api.nvim_buf_get_name(bufferId), cwd)
        shortName = string.gsub(shortName, "^%." .. pathSeparator, "")

        if bufferName == shortName then
            result = bufferId
        end
    end

    return result
end

-- Find the first window in this tab we can use
local function getOpenWindow(currentBuffer)

    -- Somewhere to store our result
    local result = nil

    -- Go through all the windows, looking for one which isn't our file listing window
    local windowIds = vim.api.nvim_list_wins()
    for _, windowId in ipairs(windowIds) do

        -- Make sure this window isn't our file listing window, by checking the buffers
        local windowBuffer = vim.api.nvim_win_get_buf(windowId)
        if (currentBuffer ~= windowBuffer) then

            -- Use the first successful window as our result
            if not result then
                result = windowId
            end
        end
    end

    return result
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

    -- Open the buffer for what is under the cursor
    local displayToFileMap = {}
    function openProjectFileBuffer()

        local targetBuffer = getBufferByName(displayToFileMap[vim.api.nvim_get_current_line()])
        if targetBuffer then

            local targetWindow = getOpenWindow(fileListBuffer)
            vim.api.nvim_win_set_buf(targetWindow, targetBuffer)
        end
    end

    -- Display the files in the buffer, formatting into a file tree
    for idx, projectFile in pairs(files) do

        -- Somewhere to store the display version
        local filenameDisplay = projectFile.filepath

        -- If it's a directory, hide the trailing slash to prevent it being replaced by spaces
        filenameDisplay = string.gsub(filenameDisplay, "/$", "TRAILING_SLASH")

        -- Now replace all directories with spaces
        filenameDisplay = string.gsub(filenameDisplay, "[^/]*/", "  ")

        -- Put the trailing slash back
        filenameDisplay = string.gsub(filenameDisplay, "TRAILING_SLASH$", "/")

        -- Add an icon
        local extension, icon, highlight
        if string.match(projectFile.filepath, "/$") then

            icon = ""
            highlight = "NvimTreeFolderName"
        else

            -- Get the icon and colour details
            extension = string.gsub(projectFile.filepath, "^[^.]*%.", "")
            icon, highlight = devicons.get_icon(projectFile.filepath, extension, { default = true })

            -- Create a buffer for this file
            local fileBuffer = vim.api.nvim_create_buf(true, false)
            vim.api.nvim_buf_set_name(fileBuffer, projectFile.filepath)

            -- Load the template into the buffer
            vim.api.nvim_buf_set_lines(fileBuffer, -2, -1, true, split(projectFile.content))
        end
        filenameDisplay = string.gsub(filenameDisplay, "^( *)", "%1" .. icon .. "  ")

        -- Store the mapping back to the original file
        displayToFileMap[filenameDisplay] = projectFile.filepath

        -- Add this to our list of files to display
        vim.api.nvim_buf_set_lines(fileListBuffer, idx - 1, idx - 1, true, { filenameDisplay })
        vim.api.nvim_buf_set_extmark(fileListBuffer, namespace, idx - 1, 0, { hl_group = highlight, end_col = string.len(filenameDisplay) })
    end

    -- Use the return key to open the buffer for the file under the cursor
    vim.api.nvim_buf_set_keymap(fileListBuffer, "n", "<CR>", "<cmd>lua openProjectFileBuffer()<CR>", { silent = false })

    -- Open a window to display the file list
    vim.api.nvim_open_win(fileListBuffer, true, { win=-1, split="left", width=40 })
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
    { filepath = "package.json", content = [[{
    "devDependencies": {
        "babel-jest": "^29.7.0",
        "jest": "^29.7.0",
        "jsdom": "^26.1.0",
        "serve": "^14.2.4"
    },
    "scripts": {
        "test": "node --experimental-vm-modules node_modules/jest/bin/jest.js --coverage",
        "start": "npx serve"
    },
    "type": "module",
    "jest": {
        "transform": {}
    }
}]] },
    { filepath = "index.js", content = "" },
    { filepath = "src/" },
    { filepath = "src/main.js", content = "" },
    { filepath = "src/main.spec.js", content = "" },
}

projects["Web"] = {
    { filepath = "package.json", content = [[{
    "devDependencies": {
        "babel-jest": "^29.7.0",
        "jest": "^29.7.0",
        "jsdom": "^26.1.0",
        "serve": "^14.2.4"
    },
    "scripts": {
        "test": "node --experimental-vm-modules node_modules/jest/bin/jest.js --coverage",
        "start": "npx serve"
    },
    "type": "module",
    "jest": {
        "transform": {}
    }
}]]},
    { filepath = "public/" },
    { filepath = "src/" },
    { filepath = "src/index.html", content = [[<!doctype html>
<html lang="en-GB">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Web App</title>

        <link rel="icon" href="favicon.ico" sizes="any">
        <link rel="icon" href="icon.svg" type="image/svg+xml">
        <link rel="apple-touch-icon" href="icon.png">

        <link rel="manifest" href="site.webmanifest">

        <script src="./js/app.js" type="text/javascript" charset="utf-8"></script>
        <link href="./css/app.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <!-- Add your site or application content here -->
        <p>Hello world! This is HTML5 Boilerplate.</p>
    </body>
</html>]] },
    { filepath = "src/js/" },
    { filepath = "src/js/app.js", content = [[const app = () => {
    return true
};

export default { app };]] },
    { filepath = "src/js/app.spec.js", content = [[import { jest } from "@jest/globals";
import { JSDOM } from "jsdom";
import fs from "fs";
const html = fs.readFileSync("../index.html").toString();

// Load our script to be tested
import app from "./app.js";

// Initialise the page into jsdom
const loadPage = () => {

    const dom = new JSDOM(html);
    global.document = dom.window.document;
    global.window = dom.window;
};

// Tests
describe("test group", () => {

    beforeAll(() => {
        loadPage();
    });

    it("tests a thing", () => {
        expect(true).toBe(false);
    });
});]] },
    { filepath = "src/css/" },
    { filepath = "src/css/app.css", content = "" },
}

--
-- Custom snippets
--

-- Use Plenary for our popup
local popup = require("plenary.popup")

-- Somewhere to store our snippets
local snippets = {}

-- The ID for our window
local winId

-- Function to close the snippet menu
function closeSnippetMenu()

    vim.api.nvim_win_close(winId, true)
end

-- Function to open a snippet list
local function showSnippetMenu(options, callback)

    local height = 20
    local width = 30
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    winId = popup.create(options, {
        title = "Snippets",
--        highlight = "Snippet Menu",
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        minwidth = width,
        minheight = height,
        borderchars = borderchars,
        callback = callback,
    })
    local buff = vim.api.nvim_win_get_buf(winId)
    vim.api.nvim_buf_set_keymap(buff, "n", "q", "<cmd>lua closeSnippetMenu()<CR>", { silent = false })
end

-- Function to start snippets interaction
local function openSnippets()

    -- Store the buffer number we are in
    local originalBuffer = vim.fn.bufnr()
    local originalLine = vim.api.nvim_win_get_cursor(0)[1]

    -- Get the list of snippets
    local snippetNames = {}
    local n = 0
    for k, v in pairs(snippets) do

        n = n + 1
        snippetNames[n] = k
    end
    table.sort(snippetNames)

    -- Function to insert snippet
    local insertSnippet = function(_, selected)

        -- Convert snippet to a table
        local snippetLines = {}
        for chunk in string.gmatch(snippets[selected], "[^\n]+") do
            snippetLines[#snippetLines + 1] = chunk
        end

        -- Insert the snippet
        vim.api.nvim_buf_set_lines(originalBuffer, originalLine, originalLine, false, snippetLines)
    end

    -- Display the list of snippets
    showSnippetMenu(snippetNames, insertSnippet)
end

-- Set up the key to open snippets
vim.keymap.set("", "<Leader>os", openSnippets, { desc = "Open snippets" })

-- HTML5 boilerplate
snippets["HTML boilerplate"] = [[<!doctype html>
<html lang="">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title></title>
        <link rel="stylesheet" href="css/style.css">
        <meta name="description" content="">

        <meta property="og:title" content="">
        <meta property="og:type" content="">
        <meta property="og:url" content="">
        <meta property="og:image" content="">
        <meta property="og:image:alt" content="">

        <link rel="icon" href="/favicon.ico" sizes="any">
        <link rel="icon" href="/icon.svg" type="image/svg+xml">
        <link rel="apple-touch-icon" href="icon.png">

        <link rel="manifest" href="site.webmanifest">
        <meta name="theme-color" content="#fafafa">
    </head>
    <body>

        <!-- Add your site or application content here -->
        <p>Hello world! This is HTML5 Boilerplate.</p>
        <script src="js/app.js"></script>

    </body>
</html>]]

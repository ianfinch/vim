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

        vim.api.nvim_buf_call(originalBuffer, function() vim.snippet.expand(snippets[selected]) end)
    end

    -- Display the list of snippets
    showSnippetMenu(snippetNames, insertSnippet)
end

-- Function to stop entering a snippet
local function exitSnippet()

    vim.snippet.stop()
end

-- Set up the keys to manage snippets
vim.keymap.set("", "<Leader>os", openSnippets, { desc = "Open snippets" })
vim.keymap.set("", "<Leader>xs", exitSnippet, { desc = "Exit a snippet" })

-- HTML5 boilerplate
snippets["HTML boilerplate"] = [[<!doctype html>
<html lang="en-GB">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>${1:title}</title>

        <link rel="icon" href="favicon.ico" sizes="any">
        <link rel="icon" href="icon.svg" type="image/svg+xml">
        <link rel="apple-touch-icon" href="icon.png">

        <link rel="manifest" href="site.webmanifest">

        <script src="${2:script}.js" type="text/javascript" charset="utf-8"></script>
        <link href="${3:style}.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <!-- Add your site or application content here -->
        <p>Hello world! This is HTML5 Boilerplate.</p>
    </body>
</html>]]

-- Standard HTML tags
snippets["HTML script tag"] = [[        <script src="${1:script}.js" type="text/javascript" charset="utf-8"></script>]]
snippets["HTML CSS tag"] = [[        <link href="${1:style}.css" rel="stylesheet" type="text/css" />]]

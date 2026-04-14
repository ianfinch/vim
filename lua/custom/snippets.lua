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

-- Module-based script tag
snippets["HTML module script tag"] = [[        <script type="module">
            import ${1:component} from "./${2:component file}.js";
            window.addEventListener("load", () => { ${1:component}.${3:initialise}(); });
        </script>]]

-- Markdown boilerplate
snippets["Markdown boilerplate"] = [[<!doctype html>
<html lang="en-GB">
    <head>
        <meta charset="utf-8">
        <title>Markdown Page</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/showdown/2.1.0/showdown.min.js" type="text/javascript" charset="utf-8"></script>
    </head>
    <body>

        <pre class="markdown">
# First section of markdown

A paragraph of text
        </pre>

        <pre class="markdown">
# Second section of markdown

- List item one
- List item two
- List item three
        </pre>

        <script type="text/javascript">
            var converter = new showdown.Converter();
            converter.setOption("tables", true);
            [...document.getElementsByClassName("markdown")].forEach(elem => {
                const html = converter.makeHtml(elem.textContent);
                elem.insertAdjacentHTML("afterend", html);
                elem.style.display = "none";
            });
        </script>
    </body>
</html>]]

-- Mermaid boilerplate
snippets["Mermaid boilerplate"] = [[<!doctype html>
<html lang="en-GB">
    <head>
        <meta charset="utf-8">
        <title>Mermaid Diagram</title>
    </head>
    <body>

        <pre class="mermaid">
graph TD
A[Client] --> B[Load Balancer]
B --> C[Server1]
B --> D[Server2]
        </pre>

        <pre class="mermaid">
graph TD
A[Client] -->|tcp_123| B
B(Load Balancer)
B -->|tcp_456| C[Server1]
B -->|tcp_456| D[Server2]
        </pre>

        <script type="module">
            import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs';
            mermaid.initialize({ startOnLoad: true });
        </script>
    </body>
</html>]]

-- Mermaid state transition diagram
snippets["Mermaid state diagram"] = [=[stateDiagram-v2
    [*] --> Still
    Still --> [*]: parked

    Still --> Moving: accelerate
    Moving --> Still: brake
    Moving --> Crash
    Crash --> [*]]=]

-- Javascript package.json starter file
snippets["package.json"] = [[{
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
}]]

-- Javascript one liners
snippets["JS export default"] = [[export default { ${1:component} };]]

-- Javascript spec file template
snippets["JS spec file"] = [[import { jest } from "@jest/globals";
import { JSDOM } from "jsdom";
import fs from "fs";
const html = fs.readFileSync("${1:page}.html").toString();

// Load our script to be tested
import ${2:component} from "./${3:component file}.js";

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
});]]

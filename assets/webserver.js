/**
 * Middleware so I can use non-web files from live-server
 */

// List of file extensions to pass through unchanged
const passThrough = [
    "gif",
    "htm",
    "html",
    "jpg",
    "pdf",
    "png"
];

// We need to manipulate file paths
const fs = require("fs");
const path = require("node:path");

// Actual middleware function
module.exports = function(req, res, next) {

    // Where are we running
    const cwd = process.cwd();

    // Get the file extension
    const parsedUrl = path.parse(req.url);
    const extension = parsedUrl.ext.replace(/^\./, "");

    // Check whether we just pass this through as is
    const lastChar = req.url.substring(req.url.length - 1, req.url.length);
    const filepath = cwd + (path.sep === "/" ? req.url : req.url.replace(/\//g, path.sep));
    const isDir = fs.lstatSync(filepath).isDirectory();
    if (isDir || passThrough.includes(extension)) {

        next();
        return
    }

    // Work out the name of this page and get the content
    const filename = parsedUrl.base;
    const fileContent = fs.readFileSync(filepath, { encoding: "utf8", flag: "r" });

    // Render as HTML and embed the file contents
    res.write('<!doctype html>');
    res.write('<html lang="en-GB">');
    res.write('    <head>');
    res.write('        <meta charset="utf-8">');
    res.write("        <title>" + filename + "</title>");
    res.write('        <script src="https://cdnjs.cloudflare.com/ajax/libs/showdown/2.1.0/showdown.min.js" type="text/javascript" charset="utf-8"></script>');
    res.write('    </head>');
    res.write('    <body>');
    res.write('        <pre class="markdown">');

    // If it's markdown, we render it
    if (extension === "md") {
        res.write(fileContent);

    // Anything else we display as text
    } else {

        res.write("# " + filename + "\n");
        res.write("```\n");
        res.write(fileContent);
        res.write("```\n");
    }

    // Remainder of the HTML we need
    res.write('        </pre>');
    res.write('        <script type="text/javascript">');
    res.write('            var converter = new showdown.Converter();');
    res.write('            converter.setOption("tables", true);');
    res.write('            [...document.getElementsByClassName("markdown")].forEach(elem => {');
    res.write('                const html = converter.makeHtml(elem.textContent);');
    res.write('                elem.insertAdjacentHTML("afterend", html);');
    res.write('                elem.style.display = "none";');
    res.write('            });');
    res.write('        </script>');
    res.write('    </body>');
    res.write('</html>');
    res.end();
}

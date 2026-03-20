/**
 * Middleware so I can use non-web files from live-server
 */

// Our neovim data directory?
// let systemDir = /* INJECTED BY MAKEFILE */;

// Handle situation where Makefile injects a Unix path, but we need a Windows one
if (systemDir.match(/^\/c\//)) {
    systemDir = systemDir.replace(/^\/c/, "C:").replace(/\//g, "\\\\");
}

// List of file extensions to pass through unchanged
const passThrough = [
    "css",
    "gif",
    "htm",
    "html",
    "jpg",
    "js",
    "pdf",
    "png",
    "svg"
];

// We need to manipulate file paths
const fs = require("fs");
const path = require("node:path");

// Read in our HTML template
const html = fs.readFileSync(systemDir + path.sep + "webserver.html").toString().split("<!-- CONTENT -->");

// Actual middleware function
module.exports = function(req, res, next) {

    // Where are we running
    const cwd = process.cwd();

    // Check whether this is a system file
    if (req.url.match(/^\/system\//)) {

        const filepath = systemDir + path.sep + req.url.replace(/^\/system\//, "");
        const fileContent = fs.readFileSync(filepath, { encoding: "utf8", flag: "r" });
        res.write(fileContent);
        res.end();
        return;
    }

    // Check for favicon
    if (req.url === "/favicon.ico") {
        const filepath = systemDir + path.sep + "favicon.ico";
        const fileContent = fs.readFileSync(filepath, { flag: "r" });
        res.write(fileContent);
        res.end();
        return;
    }

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

    // From here on down, we are treating as markdown
    // Work out the name of this page and get the content
    const filename = parsedUrl.base;
    const fileContent = fs.readFileSync(filepath, { encoding: "utf8", flag: "r" });
    const escapedContent = fileContent.replace(/&/g, "&amp;")
                                      .replace(/</g, "&lt;")
                                      .replace(/>/g, "&gt;");

    // Render as HTML and embed the file contents
    res.write(html[0].replace(/<!-- TITLE -->/g, parsedUrl.dir + path.sep + filename));

    // If it's markdown, we render it
    if (extension === "md") {
        res.write(escapedContent);

    // Anything else we display as text
    } else {

        res.write("```\n");
        res.write(escapedContent);
        res.write("```\n");
    }

    // Remainder of the HTML we need
    res.write(html[1]);
    res.end();
}

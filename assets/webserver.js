/**
 * Middleware so I can use non-web files from live-server
 */

// List of file extensions to pass through unchanged
const passThrough = [
    "css",
    "gif",
    "htm",
    "html",
    "jpg",
    "js",
    "pdf",
    "png"
];

// We need to manipulate file paths
const fs = require("fs");
const path = require("node:path");

// Read in our HTML template
const html = fs.readFileSync(systemDir + path.sep + "webserver.html").toString().split("<!-- CONTENT -->");
console.log(html);

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
    res.write(html[0].replace("<!-- TITLE -->", filename));

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
    res.write(html[1]);
    res.end();
}

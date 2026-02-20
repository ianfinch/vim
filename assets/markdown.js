/**
 * Middleware so I can use markdown from live-server
 */
module.exports = function(req, res, next) {

    res.write('<!doctype html>');
    res.write('<html lang="en-GB">');
    res.write('    <head>');
    res.write('        <meta charset="utf-8">');
    res.write('        <title>Markdown Preview</title>');
    res.write('        <script src="https://cdnjs.cloudflare.com/ajax/libs/showdown/2.1.0/showdown.min.js" type="text/javascript" charset="utf-8"></script>');
    res.write('    </head>');
    res.write('    <body>');
    res.write('        <pre class="markdown">');
res.write('# Markdown Preview Test');
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

/* Set up our markdown converter */
var converter = new showdown.Converter();
converter.setOption("literalMidWordUnderscores", true);
converter.setOption("tables", true);
converter.setOption("tasklists", true);
converter.setOption("metadata", true);

/* Convert any markdown blocks to HTML */
[...document.getElementsByClassName("markdown")].forEach(elem => {
    const text = elem.textContent.replace(/(```[a-z]+) +/g, "$1");
    const html = converter.makeHtml(text);
    elem.insertAdjacentHTML("afterend", "<article>" + html + "</article>");
    elem.style.display = "none";
});

/* If we have mermaid diagrams, render them */
import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs';
mermaid.initialize({ startOnLoad: false });
await mermaid.run({
    querySelector: ".mermaid",
    postRenderCallback: (id) => {
        const diagram = document.getElementById(id);
        const classes = diagram.parentElement.parentElement.classList;
        diagram.style.width = diagram.style["max-width"];
        diagram.style["max-width"] = "100%";
        diagram.addEventListener("click", () => {
            if (classes.contains("expanded")) {
                classes.remove("expanded");
            } else {
                classes.add("expanded");
            }
        });
    }
});

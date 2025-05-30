// convert.js
const json2md = require("json2md");
const fs = require("fs");

const json = JSON.parse(fs.readFileSync("resume.json", "utf8"));
const markdown = json2md(json);
fs.writeFileSync("output.md", markdown);

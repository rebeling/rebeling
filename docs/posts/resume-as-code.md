---
date: 2025-05-27
title: Resume as Code
categories:
  - Dev Life

links:
  - JSON Resume: https://jsonresume.org
  - JSON Resume registry: https://registry.jsonresume.org
  - JSON Resume Gist: https://gist.github.com/rebeling
  - HackMyResume: https://github.com/hacksalot/HackMyResume
---

# Resume as Code

Resumes are often treated as static documents, but over time I found that approach limiting. I was looking for a way to keep my CV reliable, easy to update, and flexible enough to handle different formats and languages—especially when clarity and consistency across contexts mattered.

<!-- more -->

Traditional tools like Google Docs and PDF exports often introduced small but persistent issues: formatting quirks, inconsistent layout, or extra effort when translating.

What I needed was a more structured approach—something I could version, reuse, and export cleanly to web, print, or even machine-readable formats.


## JSON Resume: Great Concept, Mixed Execution

[JSON Resume](https://jsonresume.org) looked promising. It defines your resume in a single JSON file and lets you apply themes for HTML, PDF, and other outputs.

``` json title="resume.json" linenums="1"
{
  "basics": {
    "name": "Matthias Rebel",
    "label": "Senior Software Engineer",
    "image": "images/portrait.png",
    "summary": "A passionate ...",
```

It worked well inside their ecosystem: I published my resume as a GitHub Gist, connected it to their [live registry](https://registry.jsonresume.org), and instantly had shareable links with themes like:

https://registry.jsonresume.org/rebeling?theme={theme}

**[professional](https://registry.jsonresume.org/rebeling?theme=professional)**,
**[kendall](https://registry.jsonresume.org/rebeling?theme=kendall)**,
**[paper-plus-plus](https://registry.jsonresume.org/rebeling?theme=paper-plus-plus)**,
**[elegant](https://registry.jsonresume.org/rebeling?theme=elegant)**, ...

But the command-line tools were less reliable. Rendering didn’t always match what I saw online. And for a CV—where layout, clarity, and precision matter—that’s a problem.

## HackMyResume: CLI That Works
While the JSON Resume ecosystem showed a lot of promise, the command-line tooling didn’t quite hold up in day-to-day use. That’s where [HackMyResume](https://github.com/hackmyresume/hackmyresume) came in—it picked up where the official CLI fell short and delivered exactly what I needed: reliable, multi-format exports from a single JSON source.

Setup was straightforward. Installation took just a few seconds, and I was able to generate all major formats with a single command. No tweaking, no layout surprises—just consistent results.

Supported outputs include:

<link
  rel="stylesheet"
  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.0/css/all.min.css"
/>

https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/css/all.min.css
<div style="display:flex; gap:1.25rem; align-items:center; font-size:1.15rem;">

<i class="fa-solid fa-file-pdf" style="color: #74C0FC;"></i>
<i class="fa-solid fa-file-word" style="color: #74C0FC;"></i>
<i class="fa-brands fa-html5" style="color: #74C0FC;"></i>
<i class="fa-brands fa-markdown" style="color: #74C0FC;"></i>
<i class="fa-solid fa-code" style="color: #74C0FC;"></i>

</div>


HackMyResume also supports custom themes, allowing you to control layout and styling across formats without duplicating effort. Once configured, it provided a reproducible, flexible resume pipeline that fits naturally into a developer workflow.

It’s a simple tool—but it solved the problem completely.

## Conclusion

I now maintain one resume file in JSON, versioned in Git, with scripted outputs for any channel. If you're a developer, this approach gives you automation, repeatability, and full control over presentation.

**Treat your resume like code—it scales better.**

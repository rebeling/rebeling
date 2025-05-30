<link
  rel="stylesheet"
  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.0/css/all.min.css"
/>

<h1 class="text-center" >
  <i class="fa-solid fa-book-open-reader"></i> <b>Agent Rebel</b>
</h1>

<p class="text-center">
    <em>shim to use agent rebel with LLMs</i></em>
</p>
<p class="text-center">
    <a
        href="https://github.com/pydantic/pydantic-ai/actions/workflows/ci.yml?query=branch%3Amain"
    >
        <img
            src="https://github.com/pydantic/pydantic-ai/actions/workflows/ci.yml/badge.svg?event=push"
            alt="CI"
        />
    </a>
    <a
        href="https://coverage-badge.samuelcolvin.workers.dev/redirect/pydantic/pydantic-ai"
    >
        <img
            src="https://coverage-badge.samuelcolvin.workers.dev/pydantic/pydantic-ai.svg"
            alt="Coverage"
        />
    </a>
    <a href="https://pypi.python.org/pypi/pydantic-ai">
        <img src="https://img.shields.io/pypi/v/pydantic-ai.svg" alt="PyPI" />
    </a>
    <a href="https://github.com/pydantic/pydantic-ai">
        <img
            src="https://img.shields.io/pypi/pyversions/pydantic-ai.svg"
            alt="versions"
        />
    </a>
    <a href="https://github.com/pydantic/pydantic-ai/blob/main/LICENSE">
        <img
            src="https://img.shields.io/github/license/pydantic/pydantic-ai.svg"
            alt="license"
        />
    </a>
    <a href="mailto:m.rebel@gmx.net">
      <img src="https://img.shields.io/badge/Email-m.rebel@gmx.net-blue?logo=gmail" alt="Email Badge">
    </a>
</p>


<p align="left"> <a href="https://yourdomain.com/resume.pdf"> <img src="https://img.shields.io/badge/PDF--red?logo=adobeacrobatreader" alt="PDF" style="margin-right: 10px;" />
</a> <a href="https://yourdomain.com/resume.doc"> <img src="https://img.shields.io/badge/DOC--blue?logo=microsoftword" alt="DOC" style="margin-right: 10px;" /> </a>
<a href="https://yourdomain.com/resume.html"> <img src="https://img.shields.io/badge/HTML--orange?logo=html5" alt="HTML" style="margin-right: 10px;" /> </a>
<a href="https://yourdomain.com/resume.md"> <img src="https://img.shields.io/badge/Markdown--lightgrey?logo=markdown" alt="Markdown" style="margin-right: 10px;" /> </a>
<a href="https://yourdomain.com/resume.json"> <img src="https://img.shields.io/badge/JSON--brightgreen?logo=json" alt="JSON" style="margin-right: 10px;" /> </a>
<a href="https://yourdomain.com/resume.png"> <img src="https://img.shields.io/badge/PNG--yellow?logo=image" alt="PNG" style="margin-right: 10px;" /> </a>
<a href="https://yourdomain.com/resume.png"> <img src="https://img.shields.io/badge/YAML--silver?logo=yaml" alt="YAML" style="margin-right: 10px;" /> </a>
</p>


<p class="text-emphasis">
    Python agent to make it less painful to
    build production grade applications with Generative AI.
</p>


```py
from rebel import Agent

agent = Agent(
    name="Matthias",
    description="Processes chat messages and replies using LLM",
    instructions=(
        "Respond in a helpful, friendly tone. If someone says 'hello world', "
        "greet them. Otherwise, clarify politely.",
    )
)

def process_chat_message(message: str) -> str:
    response = agent.run(message)
    return response
```

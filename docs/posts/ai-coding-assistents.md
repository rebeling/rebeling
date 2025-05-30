---
draft: true
date: 2025-05-05
title: AI Coding Assistants
categories:
  - Dev Life

links:
  - Nested section:
    - External link: https://example.com
---

# Hello world!

<!-- more -->


  <div class="ai-grid" id="card-container"></div>
  <script>
    function flip(cardElement) {
      const inner = cardElement.querySelector('.card-inner');
      inner.classList.toggle('flipped');
    }

    const assistants = [
      { name: "GitHub Copilot", company: "GitHub (Microsoft)", model: "OpenAI Codex", features: "Real-time IDE code completions.", url: "https://github.com/features/copilot", icon: "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png" },
      { name: "OpenAI Codex", company: "OpenAI", model: "Codex-1", features: "Translates natural language into code.", url: "https://openai.com/codex/", icon: "https://openai.com/favicon.ico" },
      { name: "Tabnine", company: "Tabnine", model: "Proprietary", features: "Privacy-focused AI completions.", url: "https://www.tabnine.com/", icon: "https://www.tabnine.com/favicon.ico" },
      { name: "Amazon CodeWhisperer", company: "Amazon Web Services (AWS)", model: "AWS ML Models", features: "Code suggestions and security scans.", url: "https://aws.amazon.com/de/q/developer", icon: "https://a0.awsstatic.com/libra-css/images/site/fav/favicon.ico" },
      { name: "Sourcegraph Cody", company: "Sourcegraph", model: "Claude, GPT-4", features: "Codebase search and explanation.", url: "https://sourcegraph.com/cody", icon: "https://sourcegraph.com/favicon.ico" },
      { name: "Cursor", company: "Cursor", model: "Claude, GPT-4", features: "AI-first VS Code fork with chat agent.", url: "https://www.cursor.com/", icon: "https://www.cursor.com/favicon.ico" },
      { name: "Qodo", company: "Qodo", model: "Advanced embeddings", features: "Testing, documentation, RAG features.", url: "https://www.qodo.ai/", icon: "https://www.qodo.ai/wp-content/uploads/2025/03/qodo-logo.svg" },
      { name: "JetBrains AI Assistant", company: "JetBrains", model: "Mellum", features: "Integrated in JetBrains IDEs.", url: "https://www.jetbrains.com/ai/", icon: "https://resources.jetbrains.com/storage/products/company/brand/logos/jb_beam.svg" },
      { name: "Codeium (Windsurf)", company: "Codeium", model: "LLaMA 3.1 70B", features: "Free, fast autocomplete & chat.", url: "https://codeium.com/", icon: "https://cdn2.futurepedia.io/2025-04-30T17-10-20.890Z-EAut2MPS5absm7BJwy6uWTEUTmjj_f4oK.png?w=256" },
      { name: "Google Jules", company: "Google", model: "Gemini", features: "Asynchronous agent for code analysis.", url: "https://jules.google/", icon: "https://jules.google/jules-pixelated.png" },
      { name: "Claude Code", company: "Anthropic", model: "Claude 3.7 Sonnet", features: "Terminal agent with safe reasoning.", url: "https://www.anthropic.com/claude-code", icon: "https://www.anthropic.com/favicon.ico" },
      { name: "Vercel v0", company: "Vercel", model: "OpenAI GPT-4", features: "Generate UI from natural language.", url: "https://v0.dev/", icon: "https://registry.npmmirror.com/@lobehub/icons-static-png/1.46.0/files/light/v0.png" }
    ];

    const container = document.getElementById("card-container");
    for (const a of assistants) {
      container.innerHTML += `
        <div class="card" onclick="flip(this)">
          <div class="card-inner">
            <div class="card-front">
              <img src="${a.icon}" alt="${a.name}">
              <a href="${a.url}" target="_blank">${a.name.includes(a.company) ? a.name : a.name + ' (' + a.company + ')'}</a>
            </div>
            <div class="card-back">
              <div>
                <strong>Company:</strong> ${a.company}<br>
                <strong>Model:</strong> ${a.model}<br>
                <strong>Features:</strong> ${a.features}
              </div>
              <a href="${a.url}" target="_blank">Visit Website</a>
            </div>
          </div>
        </div>`;
    }
  </script>

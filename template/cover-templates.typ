// Cover letter templates — fixed body in Matthias's voice, role-framed.
//
// Each template is a function (name, company, role, why, focus) -> dict with
// opening / body-paragraphs / closing, matching what cover-letter-content() expects.
//
//   name    : applicant name (string)
//   company : company name (string)
//   role    : role title being applied for (string)
//   why      : one sentence on why this company (string)
//   focus   : 2-3 focus skills (array of strings)
//
// The per-company YAML carries only company/role/why/focus + a `template:` key.

// Join a focus array into "a, b, and c".
#let join-focus(focus) = {
  let n = focus.len()
  if n == 0 { "" }
  else if n == 1 { focus.at(0) }
  else if n == 2 { focus.at(0) + " and " + focus.at(1) }
  else { focus.slice(0, n - 1).join(", ") + ", and " + focus.at(n - 1) }
}

#let _closing(name) = [
  I'd welcome the chance to discuss how I can contribute. Thank you for your consideration.

  Sincerely, \
  #name
]

// --- AI Engineer ---------------------------------------------------------
#let cover-ai(name: none, company: none, role: none, why: none, focus: ()) = (
  opening: [
    I'm writing to express my strong interest in the #role position at #company. I'm a software engineer with a computational-linguistics background and 13+ years building production language technology, and I approach every project with curiosity, empathy, and a bias for action.
  ],
  body-paragraphs: (
    [At Universum I built an AI assistant integrating ChatGPT with a company knowledge base serving 60,000+ users, and I've shipped RAG pipelines, chatbots, and agentic workflows that connect machine learning to real product value. I'm currently focused on multi-agent systems — how autonomous agents cooperate to solve problems.],
    [What draws me to #company: #why I'd bring depth in #join-focus(focus) to that work.],
  ),
  closing: _closing(name),
)

// --- Lead AI / Architect -------------------------------------------------
#let cover-lead(name: none, company: none, role: none, why: none, focus: ()) = (
  opening: [
    I'm writing to express my strong interest in the #role position at #company. I'm a software architect and technical lead with 13+ years owning core architecture for real-time, high-performance systems, and I approach every project with curiosity, empathy, and a bias for action.
  ],
  body-paragraphs: (
    [At Retresco I led the refactoring of legacy monoliths into containerised microservices with CI/CD automation; at Universum I drove full-stack architecture and AI integration for mission-critical products while optimising team workflows and deployment pipelines. I pair hands-on engineering depth with a strategic lens on business goals.],
    [What draws me to #company: #why I'd bring depth in #join-focus(focus) to that work.],
  ),
  closing: _closing(name),
)

// --- Consulting / Solution Architect ------------------------------------
#let cover-consulting(name: none, company: none, role: none, why: none, focus: ()) = (
  opening: [
    I'm writing to express my strong interest in the #role position at #company. I'm a software engineer and architect with 13+ years across consulting and product delivery, and I approach every engagement with curiosity, empathy, and a bias for action.
  ],
  body-paragraphs: (
    [At Retresco I provided technical consultancy to enterprise clients, guiding architecture decisions and best practices across projects while delivering robust microservices and real-time data pipelines. I'm comfortable translating ambiguous requirements into scalable, maintainable solutions — and explaining the trade-offs to both engineers and stakeholders.],
    [What draws me to #company: #why I'd bring depth in #join-focus(focus) to that work.],
  ),
  closing: _closing(name),
)

// --- Senior Fullstack ----------------------------------------------------
#let cover-fullstack(name: none, company: none, role: none, why: none, focus: ()) = (
  opening: [
    I'm writing to express my strong interest in the #role position at #company. I'm a senior full-stack engineer with 13+ years shipping end-to-end products, and I approach every project with curiosity, empathy, and a bias for action.
  ],
  body-paragraphs: (
    [At Universum I led full-stack development across Python, FastAPI, Vue.js, Elasticsearch, and CI/CD — from AI-powered tools to scalable content pipelines and secure APIs serving tens of thousands of users. I keep one eye on the technical detail and the other on the bigger business goal.],
    [What draws me to #company: #why I'd bring depth in #join-focus(focus) to that work.],
  ),
  closing: _closing(name),
)

// Dispatch by template name.
#let build-cover-letter(template: none, name: none, company: none, role: none, why: none, focus: ()) = {
  let fns = (
    ai: cover-ai,
    lead: cover-lead,
    consulting: cover-consulting,
    fullstack: cover-fullstack,
  )
  assert(template in fns, message: "Unknown cover template '" + template + "'. Use: ai, lead, consulting, fullstack")
  (fns.at(template))(name: name, company: company, role: role, why: why, focus: focus)
}

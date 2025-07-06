// Layout and styling functions for resume - Following Typst best practices

#let primary-color = rgb("#1e40af")
#let secondary-color = rgb("#64748b")
#let accent-color = rgb("#0f172a")

// List rendering functions - defined early for use in other functions
#let bullet-list(items) = {
  list(..items.map(item => [#item]))
}

#let numbered-list(items) = {
  enum(..items.map(item => [#item]))
}

#let achievement-list(items) = {
  for item in items [
    ▸ #item
    #v(0.15em)
  ]
}

// Native Typst list helper
#let make-list(..items) = {
  list(..items)
}

#let make-enum(..items) = {
  enum(..items)
}

#let setup-document(name, doc) = {
  // Document-level settings
  set document(title: name + " - Resume")
  set page(
    paper: "a4",
    margin: (x: 1.5cm, y: 1.5cm),
  )

  // Text hierarchy using set rules
  set text(
    font: "Arial",
    size: 10pt,
    fill: accent-color,
  )

  set par(
    justify: true,
    leading: 0.55em,
  )

  // Show rules for consistent styling
  show heading.where(level: 1): set text(size: 13pt, weight: "bold", fill: primary-color)
  show heading.where(level: 2): set text(size: 11pt, weight: "semibold", fill: primary-color)

  // Improved list styling with no indentation
  show list: set list(indent: 0em, body-indent: 0.5em, spacing: 0.4em)
  show enum: set enum(indent: 0em, body-indent: 0.5em, spacing: 0.4em)
  show list.item: set text(size: 9.5pt)
  show enum.item: set text(size: 9.5pt)
  show list.item: set par(leading: 0.5em)
  show enum.item: set par(leading: 0.5em)

  doc
}

#let header-style(body) = {
  set text(size: 13pt, weight: "bold", fill: primary-color)
  upper(body)
}

#let subheader-style(body) = {
  set text(size: 11pt, weight: "semibold", fill: primary-color)
  body
}

#let meta-text(body) = {
  set text(size: 9pt, fill: secondary-color, style: "italic")
  body
}

#let contact-line(items) = {
  items.join(" • ")
}

#let section-divider() = {
  v(0.8em)
  line(length: 100%, stroke: 0.5pt + primary-color)
  v(0.8em)
}

#let skill-icon() = {
  let blocks = (
    box(fill: silver, width: 13pt, height: 13pt),
    box(fill: black, width: 13pt, height: 13pt),
    box(fill: black, width: 13pt, height: 13pt),
  )
  align(right)[#blocks.join(h(1.3pt))]
  v(-1.05em)
  let blocks = (
    box(fill: silver, width: 13pt, height: 13pt),
    box(fill: black, width: 13pt, height: 13pt),
  )
  align(right)[#blocks.join(h(1.3pt))]
  v(-1.05em)
  let blocks = (
    box(fill: silver, width: 13pt, height: 13pt),
  )
  align(right)[#blocks.join(h(1.3pt))]
}


#let skill-entry(skill, level) = {

  let level-mapping = (
    "Expert": 5,
    "Experienced": 4,
    "Skillful": 3,
    "Intermediate": 2,
    "Beginner": 1
  )

  let skill-level = level-mapping.at(level, default: 3)

  grid(
    columns: 1,
    [
      #text(size: 10pt, baseline: 5pt, weight: "medium")[#skill]
      #text(size: 10pt, baseline: 5pt, fill: secondary-color)[(#level)]
      #let blocks = ()
      #for i in range(5) {
        if i < skill-level {
          blocks.push(box(fill: black, width: 13pt, height: 13pt))
        } else {
          blocks.push(box(fill: gray, width: 13pt, height: 13pt))
        }
      }
      #align(left)[#blocks.join(h(1.2pt))]
    ]
  )
  v(-0.4em)
}


#let name-header(resume-data) = {

  place(
    top + right,
    dx: 0pt,
    skill-icon()
  )

  align(left)[
    #text(size: 24pt, weight: "bold", fill: primary-color)[
      #resume-data.firstname #resume-data.lastname
    ]
    #v(0.1em)
    #text(size: 11pt, fill: secondary-color)[
      #resume-data.position
    ]
  ]
  align(left)[
    #v(0em)
    #text(size: 9pt)[
      #resume-data.address #"/" #resume-data.phone #"/" #resume-data.email
    ]
  ]
}

#let contact-info(email, phone, github) = {
  align(center)[
    #v(0.4em)
    #text(size: 9pt)[
      #contact-line((email, phone, github, "LinkedIn Profile"))
    ]
  ]
}

#let job-entry(role, company, period, summary, highlights: none) = {


  subheader-style[#role#"," #company]
  v(0.1em)
  meta-text[#period]
  v(0.1em)
  summary
  v(0.3em)
  if highlights != none and highlights.len() > 0 [
    #bullet-list(highlights)
  ]

  v(0.8em)
}

#let education-entry(role, institution, location, period, summary, highlights) = {
  grid(
    columns: (1fr, auto),
    subheader-style[#role],
    if period != none { meta-text[#period] }
  )

  text(weight: "medium", size: 9.5pt)[#institution]
  if location != none [
    text(size: 9pt, fill: secondary-color)[ • #location]
  ]

  v(0.3em)
  summary

  v(0.3em)
  if highlights != none [
    #bullet-list(highlights)
  ]

  v(0.8em)
}


#let cert-entry(title, date) = {
  grid(
    columns: (1fr, auto),
    text(weight: "medium", size: 9.5pt)[#title],
    meta-text[#date]
  )
  v(0.15em)
}

#let language-entry(language, level) = {
  text(weight: "medium", size: 9.5pt)[#upper(language.first()) + language.slice(1):]
  text(size: 9pt)[#level]
  v(0.15em)
}

#let volunteer-entry(title, description) = {
  text(weight: "medium", size: 9.5pt)[#title]
  v(0.2em)
  text(size: 9pt)[#description]
  v(0.4em)
}

// Cover letter functions
#let cover-letter-header(applicant-name, applicant-address, company-address, date) = {
  align(left)[
    #text(weight: "bold", size: 11pt)[#applicant-name]
    #applicant-address

    #v(1em)
    #date

    #v(1em)
    #company-address
  ]
}

#let cover-letter-content(opening, body-paragraphs, closing) = {
  v(1.5em)

  // Opening paragraph
  opening

  v(1em)

  // Body paragraphs
  for paragraph in body-paragraphs [
    #paragraph
    #v(1em)
  ]

  // Closing
  closing
}

// Layout and styling functions for resume - Modern Typst approach

#import "elements.typ": dot-ratings

#let primary-color = rgb("#1e40af")
#let secondary-color = rgb("#64748b") 
#let accent-color = rgb("#0f172a")

// Consistent spacing system
#let spacing = (
  xs: 0.15em,
  sm: 0.3em, 
  md: 0.6em,
  lg: 1em,
  xl: 1.4em,
  section: 1.5em
)

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
    font: ("Palatino", "Times New Roman", "Arial"),
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
  body
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
  // Clean decorative icon using modern Typst approach
  align(right)[
    #stack(
      dir: ttb,
      spacing: 1pt,
      align(right)[
        #rect(fill: rgb("#374151"), width: 4pt, height: 4pt)
        #h(1pt)
        #rect(fill: rgb("#374151"), width: 4pt, height: 4pt)
        #h(1pt)
        #rect(fill: rgb("#374151"), width: 4pt, height: 4pt)
      ],
      align(right)[
        #rect(fill: rgb("#9ca3af"), width: 4pt, height: 4pt)
        #h(1pt)
        #rect(fill: rgb("#9ca3af"), width: 4pt, height: 4pt)
      ],
      align(right)[
        #rect(fill: rgb("#9ca3af"), width: 4pt, height: 4pt)
      ]
    )
  ]
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
  
stack(
    spacing: 0.3em,
    [
      #text(size: 10pt, weight: "medium")[#skill] 
      #text(size: 9pt, fill: rgb("#6b7280"))[(#level)]
    ],
    // Rectangle ratings
    dot-ratings(
      skill-level,
      5,
      size: 6pt,
      spacing: 1pt,
      color-active: rgb("#374151"),
      color-inactive: rgb("#e5e7eb")
    )
  )
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
  stack(
    spacing: spacing.xs,
    [
      #subheader-style[#role]
      #text(size: 10pt, weight: "medium")[#company] #h(1fr) #meta-text[#period]
    ],
    summary,
    if highlights != none and highlights.len() > 0 [
      #bullet-list(highlights)
    ]
  )
  v(spacing.md)
}

#let education-entry(role, institution, location, period, summary, highlights) = {
  stack(
    spacing: spacing.sm,
    [
      #grid(
        columns: (1fr, auto),
        subheader-style[#role],
        if period != none { meta-text[#period] }
      )
      #text(weight: "medium", size: 9.5pt)[#institution]
      #if location != none [
        #text(size: 9pt, fill: secondary-color)[ • #location]
      ]
    ],
    summary,
    if highlights != none [
      #bullet-list(highlights)
    ]
  )
  v(spacing.md)
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
  let level-mapping = (
    "native": 5,
    "advanced": 4,
    "intermediate": 3,
    "basic": 2,
    "beginner": 1
  )
  
  let language-level = level-mapping.at(level, default: 3)
  
  stack(
    spacing: 0.3em,
    [
      #text(size: 10pt, weight: "medium")[#language] 
      #text(size: 9pt, fill: rgb("#6b7280"))[(#level)]
    ],
    // Rectangle ratings
    dot-ratings(
      language-level,
      5,
      size: 6pt,
      spacing: 1pt,
      color-active: rgb("#374151"),
      color-inactive: rgb("#e5e7eb")
    )
  )
}

#let hobby-list(hobbies) = {
  stack(
    spacing: 0.3em,
    ..hobbies.map(hobby => [
      #text(size: 10pt)[#hobby]
    ])
  )
}

#let publication-entry(title, date, description) = {
  stack(
    spacing: spacing.xs,
    [
      #text(size: 10pt, weight: "medium")[#title]
      #meta-text[#date]
    ],
    text(size: 9pt, style: "italic")[#description]
  )
  v(spacing.sm)
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
  stack(
    spacing: spacing.lg,
    [
      #v(spacing.xl)
      #opening
    ],
    ..body-paragraphs.map(p => [#p]),
    closing
  )
}

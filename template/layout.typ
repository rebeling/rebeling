// Layout and styling functions for CV - Modern Typst approach

#import "elements.typ": dot-ratings

#let primary-color = rgb("#171717")
#let secondary-color = rgb("#737373")
#let accent-color = secondary-color

// Layout defaults (can be overridden from cv-data.layout in YAML)
#let default-page-left-pt = 30
#let default-page-right-pt = 30
#let default-page-top-pt = 30
#let default-page-bottom-pt = 30
#let default-divider-top-pt = 12
#let default-divider-bottom-pt = 8
#let default-divider-stroke-pt = 0.75
#let default-header-name-pt = 30
#let default-header-position-pt = 12
#let default-header-position-gap-pt = 2
#let default-header-contact-pt = 9
#let default-summary-body-pt = 10.5
#let default-body-pt = 10
#let default-job-title-pt = 9
#let default-meta-pt = 7
#let default-rating-square-pt = 11.25
#let default-rating-gap-pt = 1.5
#let default-icon-square-pt = 11.25
#let default-icon-gap-pt = 1.5

#let layout-section(layout-config, section-name) = {
  if layout-config != none and section-name in layout-config {
    layout-config.at(section-name)
  } else {
    none
  }
}

#let layout-number(section, key, default) = {
  if section != none and key in section {
    section.at(key, default: default)
  } else {
    default
  }
}

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
  for item in items [
    #text(size: default-body-pt * 1pt, fill: secondary-color)[• #item]
    #v(0.12em)
  ]
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

#let setup-document(name, doc, layout-config: none, lang: "en") = {
  let page-config = layout-section(layout-config, "page")
  
  // Localization for document title
  let titles = (
    en: "CV",
    de: "Lebenslauf"
  )
  let doc-title = titles.at(lang, default: "CV")

  let page-left = if page-config != none and "left_pt" in page-config {
    page-config.at("left_pt") * 1pt
  } else if page-config != none and "left_cm" in page-config {
    page-config.at("left_cm") * 1cm
  } else {
    default-page-left-pt * 1pt
  }
  let page-right = if page-config != none and "right_pt" in page-config {
    page-config.at("right_pt") * 1pt
  } else if page-config != none and "right_cm" in page-config {
    page-config.at("right_cm") * 1cm
  } else {
    default-page-right-pt * 1pt
  }
  let page-top = if page-config != none and "top_pt" in page-config {
    page-config.at("top_pt") * 1pt
  } else if page-config != none and "top_cm" in page-config {
    page-config.at("top_cm") * 1cm
  } else {
    default-page-top-pt * 1pt
  }
  let page-bottom = if page-config != none and "bottom_pt" in page-config {
    page-config.at("bottom_pt") * 1pt
  } else if page-config != none and "bottom_cm" in page-config {
    page-config.at("bottom_cm") * 1cm
  } else {
    default-page-bottom-pt * 1pt
  }
  let page-margins = (
    left: page-left,
    right: page-right,
    top: page-top,
    bottom: page-bottom,
  )

  // Document-level settings
  set document(title: name + " - " + doc-title)
  set page(
    paper: "a4",
    margin: page-margins,
  )

  // Text hierarchy using set rules
  set text(
    font: ("IBM Plex Serif", "Palatino", "Times New Roman", "Arial"),
    size: default-body-pt * 1pt,
    fill: accent-color,
  )

  set par(
    justify: false,
    leading: 0.65em,
  )

  // Show rules for consistent styling
  show heading.where(level: 1): set text(size: 12pt, weight: "medium", fill: primary-color)
  show heading.where(level: 2): set text(size: 10.5pt, weight: "medium", fill: primary-color)

  // Improved list styling with no indentation
  show list: set list(indent: 0em, body-indent: 0em, spacing: 0.35em)
  show enum: set enum(indent: 0em, body-indent: 0em, spacing: 0.35em)
  show list.item: set text(size: default-body-pt * 1pt, fill: secondary-color)
  show enum.item: set text(size: default-body-pt * 1pt, fill: secondary-color)
  show list.item: set par(leading: 0.45em)
  show enum.item: set par(leading: 0.45em)

  doc
}

#let header-style(body) = {
  set text(size: 12pt, weight: "medium", fill: primary-color)
  body
}

#let subheader-style(body) = {
  set text(size: 10.5pt, weight: "medium", fill: primary-color)
  body
}

#let meta-text(body) = {
  set text(size: default-meta-pt * 1pt, weight: "medium", fill: secondary-color)
  body
}

#let contact-line(items) = {
  items.join(" • ")
}

#let section-divider(layout-config: none) = {
  let divider-config = layout-section(layout-config, "divider")
  let divider-top-gap = if divider-config != none and "top_gap_pt" in divider-config {
    divider-config.at("top_gap_pt") * 1pt
  } else if divider-config != none and "top_gap_em" in divider-config {
    divider-config.at("top_gap_em") * 1em
  } else {
    default-divider-top-pt * 1pt
  }
  let divider-bottom-gap = if divider-config != none and "bottom_gap_pt" in divider-config {
    divider-config.at("bottom_gap_pt") * 1pt
  } else if divider-config != none and "bottom_gap_em" in divider-config {
    divider-config.at("bottom_gap_em") * 1em
  } else {
    default-divider-bottom-pt * 1pt
  }
  let divider-stroke = if divider-config != none and "stroke_pt" in divider-config {
    divider-config.at("stroke_pt") * 1pt
  } else {
    default-divider-stroke-pt * 1pt
  }

  v(divider-top-gap)
  line(length: 100%, stroke: divider-stroke + rgb("#c0c0c0"))
  v(divider-bottom-gap)
}

#let icon-square(fill-color, size) = rect(
  fill: fill-color,
  width: size,
  height: size,
)

#let skill-icon(layout-config: none) = {
  let markers-config = layout-section(layout-config, "markers")
  let icon-square-size = layout-number(markers-config, "icon_square_pt", default-icon-square-pt) * 1pt
  let icon-square-gap = layout-number(markers-config, "icon_gap_pt", default-icon-gap-pt) * 1pt
  let icon-square-empty = box(width: icon-square-size, height: icon-square-size)

  let gray-square = icon-square(rgb("#d9d9d9"), icon-square-size)
  let empty-square = box(width: icon-square-size, height: icon-square-size)
  // Row1: gray, black, black / Row2: empty, gray, black / Row3: empty, empty, gray
  align(right)[
    #grid(
      columns: 3,
      column-gutter: icon-square-gap,
      row-gutter: icon-square-gap,
      gray-square,
      icon-square(primary-color, icon-square-size),
      icon-square(primary-color, icon-square-size),
      empty-square,
      gray-square,
      icon-square(primary-color, icon-square-size),
      empty-square,
      empty-square,
      gray-square,
    )
  ]
}


#let skill-entry(skill, level, layout-config: none) = {
  let markers-config = layout-section(layout-config, "markers")
  let rating-square-size = layout-number(markers-config, "rating_square_pt", default-rating-square-pt) * 1pt
  let rating-square-gap = layout-number(markers-config, "rating_gap_pt", default-rating-gap-pt) * 1pt

  let level-mapping = (
    "Expert": 5,
    "Experte": 5,
    "Experienced": 4,
    "Erfahren": 4,
    "Proficient": 3,
    "Fortgeschritten": 3,
    "Skillful": 3,
    "Intermediate": 2,
    "Grundkenntnisse": 2,
    "Beginner": 1,
    "Anfänger": 1
  )

  let skill-level = level-mapping.at(level, default: 3)

stack(
    spacing: 0.35em,
    [
      #text(size: 9pt, weight: "medium", fill: primary-color)[#skill]
      #h(0.1em)
      #text(size: 8.5pt, fill: secondary-color)[(#level)]
    ],
    // Rectangle ratings
    dot-ratings(
      skill-level,
      5,
      size: rating-square-size,
      spacing: rating-square-gap,
      color-active: primary-color,
      color-inactive: rgb("#d9d9d9")
    )
  )
  v(0.05em)
}


#let name-header(cv-data, layout-config: none) = {
  let header-config = layout-section(layout-config, "header")
  let header-name-size = layout-number(header-config, "name_size_pt", default-header-name-pt) * 1pt
  let header-position-size = layout-number(header-config, "position_size_pt", default-header-position-pt) * 1pt
  let header-position-gap = if header-config != none and "position_gap_pt" in header-config {
    header-config.at("position_gap_pt") * 1pt
  } else if header-config != none and "position_gap_em" in header-config {
    header-config.at("position_gap_em") * 1em
  } else {
    default-header-position-gap-pt * 1pt
  }
  let header-contact-size = layout-number(header-config, "contact_size_pt", default-header-contact-pt) * 1pt

  place(
    top + right,
    dx: 0pt,
    dy: -6pt,
    skill-icon(layout-config: layout-config)
  )

  align(left)[
    #text(size: header-name-size, weight: "bold", fill: primary-color)[#cv-data.firstname #cv-data.lastname]
    #linebreak()
    #v(0.4em)
    #text(size: header-position-size, weight: "semibold", fill: primary-color)[#cv-data.position]
    #linebreak()
    #v(0.35em)
    #text(size: header-contact-size, fill: secondary-color)[#cv-data.address #"/" #link("tel:" + cv-data.phone.replace(" ", ""))[#cv-data.phone] #"/" #link("mailto:" + cv-data.email)[#cv-data.email]]
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
  text(size: 10pt, weight: "bold", fill: primary-color)[#role, #company]
  v(0.01em)
  text(size: 8.4pt, weight: "regular", fill: secondary-color)[#upper(period)]
  v(0.0001em)
  text(size: 9pt, fill: secondary-color)[#summary]
  if highlights != none and highlights.len() > 0 {
    for item in highlights [
      #v(0.01em)
      #text(size: 9pt, fill: secondary-color)[• #item]
    ]
  }
}

#let education-entry(role, institution, location, period, summary, highlights) = {
  text(size: default-job-title-pt * 1pt, weight: "bold", fill: primary-color)[#role, #institution]
  if location != none [#text(size: default-body-pt * 1pt, fill: secondary-color)[• #location]]
  if period != none {
    v(0.01em)
    text(size: 8.4pt, weight: "regular", fill: secondary-color)[#upper(period)]
    v(0.0001em)
  }
  if summary != none {
    v(0.2em)
    text(size: 8.5pt, fill: secondary-color)[#summary]
  }
  if highlights != none {
    v(0.2em)
    bullet-list(highlights)
  }
  v(0.55em)
}


#let cert-entry(title, place, date) = {
  set par(justify: false)
  text(weight: "bold", size: default-body-pt * 1pt, fill: primary-color, hyphenate: false)[#title]
  text(size: default-body-pt * 1pt, fill: secondary-color)[, #place, ]
  text(size: 8.4pt, weight: "regular", fill: secondary-color)[#upper(date)]
  v(0.2em)
}

#let language-entry(language, level, layout-config: none) = {
  let markers-config = layout-section(layout-config, "markers")
  let rating-square-size = layout-number(markers-config, "rating_square_pt", default-rating-square-pt) * 1pt
  let rating-square-gap = layout-number(markers-config, "rating_gap_pt", default-rating-gap-pt) * 1pt

  let level-mapping = (
    "native": 5,
    "Muttersprache": 5,
    "advanced": 4,
    "Verhandlungssicher": 4,
    "experienced": 4,
    "Fließend": 4,
    "intermediate": 3,
    "Gut": 3,
    "basic": 2,
    "Grundkenntnisse": 2,
    "beginner": 1
  )

  let language-level = level-mapping.at(level, default: 3)

  stack(
    spacing: 0.5em,
    [
      #text(size: 9pt, weight: "medium", fill: primary-color)[#language]
      #h(0.15em)
      #text(size: 9pt, fill: secondary-color)[(#upper(level.first())#level.slice(1))]
    ],
    // Rectangle ratings
    dot-ratings(
      language-level,
      5,
      size: rating-square-size,
      spacing: rating-square-gap,
      color-active: primary-color,
      color-inactive: rgb("#d9d9d9")
    )
  )
}

#let hobby-list(hobbies) = {
  text(size: 9pt, fill: secondary-color)[#hobbies.join(", ")]
}

#let publication-entry(title, date, description) = {
  block(breakable: false)[
    #set par(justify: false)
    #text(size: 10.5pt, weight: "medium", fill: primary-color, hyphenate: false)[#title]
    #v(0.1em)
    #meta-text[#date]
    #v(0.25em)
    #text(size: default-body-pt * 1pt, fill: secondary-color)[#description]
  ]
  v(spacing.sm)
}

#let volunteer-entry(body) = {
  set par(justify: false)
  show strong: it => text(weight: "bold", fill: primary-color)[#it.body]
  text(size: 9pt, fill: secondary-color, hyphenate: false)[#eval(body, mode: "markup")]
  v(0.5em)
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

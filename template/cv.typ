// CV template function - Modern Typst approach

#import "layout.typ": *
#import "elements.typ": *
#import "cover-templates.typ": build-cover-letter

#let cv-template(
  // Required parameters
  name: none,
  cv-data: none,

  // Cover letter parameters
  cover-letter-data: none,
  include-cover-letter: false,

  // Output mode: "full" (cover + cv), "cover" (cover only), "cv" (cv only)
  mode: "full",

  // Optional parameters
  lang: "en",

  // Document content
  doc,
) = {
  // Localization
  let translations = (
    en: (languages: "Languages", re: "Re:"),
    de: (languages: "Sprachen", re: "Betr.:")
  )
  let t = translations.at(lang)

  // Simple parameter validation
  assert(name != none, message: "Name is required for cv template")
  assert(cv-data != none, message: "CV data is required for cv template")
  let layout-config = if "layout" in cv-data { cv-data.layout } else { none }
  let columns-config = if layout-config != none and "columns" in layout-config { layout-config.columns } else { none }
  let has-fixed-columns = columns-config != none and "left_pt" in columns-config and "right_pt" in columns-config
  let main-column-ratio = if columns-config != none and "main" in columns-config { columns-config.main } else { 2.8 }
  let sidebar-column-ratio = if columns-config != none and "sidebar" in columns-config { columns-config.sidebar } else { 1.2 }
  let column-gutter = if columns-config != none and "gap_pt" in columns-config {
    columns-config.gap_pt * 1pt
  } else if columns-config != none and "gutter_em" in columns-config {
    columns-config.gutter_em * 1em
  } else {
    12pt
  }
  let content-columns = if has-fixed-columns {
    (columns-config.left_pt * 1pt, columns-config.right_pt * 1pt)
  } else {
    (main-column-ratio * 1fr, sidebar-column-ratio * 1fr)
  }

  // Apply document setup
  setup-document(name, [

    // Cover Letter Section (if included and not in cv-only mode)
    #if mode != "cv" and include-cover-letter and cover-letter-data != none [

      // Use same header as CV
      #name-header(cv-data, layout-config: layout-config)

      #section-divider(layout-config: layout-config)

      // Shared width for all cover content below the divider
      #let cover-text-width = if has-fixed-columns {
        content-columns.at(0) + column-gutter + content-columns.at(1) * 0.3
      } else { 100% }
      #block(width: cover-text-width)[
        #grid(
          columns: (1fr, auto),
          align: (left, right),
          cover-letter-data.company.address,
          text(size: 10pt)[#cover-letter-data.application.date],
        )

        #v(1em)
        #let dept-suffix = if "department" in cover-letter-data.company { " - " + cover-letter-data.company.department } else { "" }
        #header-style[#cover-letter-data.company.position#dept-suffix]
        #if "reference" in cover-letter-data.application [
          #linebreak()
          #text(size: 9pt, style: "italic")[#cover-letter-data.application.reference]
        ]
        #v(0.5em)
      ]

      #block(width: cover-text-width)[
        #set par(justify: false)
        #set text(size: default-body-pt * 1pt, fill: secondary-color)
        // If the YAML uses a `template:` key, build the letter from a role template
        // (fixed body + injected slots). Otherwise fall back to spelled-out fields.
        #let letter = if "template" in cover-letter-data.letter {
          build-cover-letter(
            template: cover-letter-data.letter.template,
            name: name,
            company: cover-letter-data.company.name,
            role: cover-letter-data.company.position,
            why: cover-letter-data.letter.why,
            focus: cover-letter-data.letter.focus,
          )
        } else {
          cover-letter-data.letter
        }
        #cover-letter-content(
          letter.opening,
          letter.body-paragraphs,
          letter.closing,
        )
      ]

      #if mode == "full" { pagebreak() }
    ]

    // CV body (skip in cover-only mode)
    #if mode != "cover" [
    // Header Section
    #name-header(cv-data, layout-config: layout-config)

    #section-divider(layout-config: layout-config)

    // Modern responsive 2-column layout — single grid, independent col paging
    #grid(
      columns: content-columns,
      gutter: column-gutter,
      // Main content column
      stack(
        // above Employment history
        spacing: 2em,
        [
          // Introduction Section
          #header-style[#cv-data.introduction.headline]
          #v(0.35em)
          #block(width: 100%)[#set par(justify: false)
          #text(size: default-body-pt * 1pt, fill: secondary-color)[#cv-data.introduction.text]]
          #v(0.5em)
          #line(length: 100%, stroke: 0.75pt + rgb("#c0c0c0"))
        ],
        [
          // Experience Section
          #header-style[#cv-data.jobs.headline]
          #v(0.4em)
          #stack(
            spacing: 1.8em,
            ..cv-data.jobs.items.pairs().map(((job-key, job-data)) => {
              let highlights = if "highlights" in job-data { job-data.highlights } else { none }
              let from-str = if "from-month" in job-data { job-data.at("from-month") + " " + str(job-data.from) } else { str(job-data.from) }
              let to-str = if "to-month" in job-data { job-data.at("to-month") + " " + str(job-data.to) } else { str(job-data.to) }
              let period = from-str + " - " + to-str
              if "location" in job-data { period = period + ", " + job-data.location }
              job-entry(job-data.role, job-data.name, period, job-data.summary, highlights: highlights)
            })
          )
        ],
        [
          // Education Section
          #header-style[#cv-data.education.headline]
          #v(0.4em)
          #stack(
            spacing: 0.6em,
            ..cv-data.education.items.pairs().map(((edu-key, edu-data)) => {
              let from-str = if "from-month" in edu-data and "from" in edu-data { edu-data.at("from-month") + " " + str(edu-data.from) } else if "from" in edu-data { str(edu-data.from) } else { none }
              let to-str = if "to-month" in edu-data and "to" in edu-data { edu-data.at("to-month") + " " + str(edu-data.to) } else if "to" in edu-data { str(edu-data.to) } else { none }
              let period = if from-str != none and to-str != none { from-str + " - " + to-str } else if from-str != none { from-str } else { none }
              let location = if "location" in edu-data { edu-data.location } else { none }
              let highlights = if "highlights" in edu-data { edu-data.highlights } else { none }
              let summary = if "summary" in edu-data { edu-data.summary } else { none }
              education-entry(edu-data.role, edu-data.name, location, period, summary, highlights)
            })
          )
        ],
        [
          // Certifications Section
          #header-style[#cv-data.certificates.headline]
          #v(0.4em)
          #for (cert-key, cert-data) in cv-data.certificates.items [
            #cert-entry(cert-data.title, cert-data.place, cert-data.date)
          ]
        ],
      ),
      // Sidebar — all sections in one continuous stack
      stack(
        spacing: 1.4em,
        [
          #header-style[#cv-data.skills.headline]
          #v(0.1em)
          #stack(
            spacing: 1.2em,
            ..cv-data.skills.name-level.pairs().map(((skill, level)) => skill-entry(skill, level, layout-config: layout-config))
          )
        ],
        [
          #if "explored" in cv-data [
            #v(-.2em)
            #header-style[#cv-data.explored.headline]
            #v(0.2em)
            #text(size: 9pt, weight: "medium", fill: primary-color)[#cv-data.explored.items.join(", ")]
          ]
        ],
        [
          // Languages Section
          #v(1em)
          #header-style[#t.languages]
          #v(0.2em)
          #for (lang, details) in cv-data.languages [
            #language-entry(lang, details.level, layout-config: layout-config)
          ]
        ],
        [
          // Hobbies Section
          #v(0.3em)
          #header-style[#cv-data.hobbies.headline]
          #v(0.2em)
          #hobby-list(cv-data.hobbies.items)
        ],
        [
          // Volunteer & Open Source Section
          #v(0.3em)
          #header-style[#cv-data.volunteer.headline]
          #v(0.2em)
          #for entry in cv-data.volunteer.entries [
            #volunteer-entry(entry.text)
          ]
        ],
        [
          #if "references" in cv-data [
            #v(0.3em)
            #header-style[#cv-data.references.headline]
            #v(0.2em)
            #for item in cv-data.references.items [
              #v(0.2em)
              #let body = [
                #text(size: 9pt, weight: "medium", fill: primary-color)[#item.name]
                #linebreak()
                #text(size: 9pt, fill: secondary-color)[#item.title]
                #if "company" in item [
                  #linebreak()
                  #text(size: 9pt, fill: secondary-color)[#item.company]
                ]
                #if "text" in item [
                  #linebreak()
                  #text(size: 8.5pt, style: "italic", fill: secondary-color)[#item.text]
                ]
              ]
              #if "linkedin" in item [
                #link(item.linkedin)[#body]
              ] else [
                #body
              ]
              #v(0.4em)
            ]
          ]
        ]
      )
    )
    ]

    // Additional content from doc parameter
    #doc
  ], layout-config: layout-config, lang: lang)
}

// Resume template function - Modern Typst approach

#import "layout.typ": *
#import "elements.typ": *

#let resume-template(
  // Required parameters
  name: none,
  resume-data: none,
  
  // Cover letter parameters
  cover-letter-data: none,
  include-cover-letter: false,

  // Document content
  doc,
) = {
  // Simple parameter validation
  assert(name != none, message: "Name is required for resume template")
  assert(resume-data != none, message: "Resume data is required for resume template")

  // Apply document setup
  setup-document(name, [

    #set page(footer: context [
      *Matthias Rebel*
      #h(1fr)
      #counter(page).display(
        "1/1",
        both: true,
      )
    ])

    // Cover Letter Section (if included)
    #if include-cover-letter and cover-letter-data != none [

      // Use same header as resume
      #name-header(resume-data)
      #v(1.5em)

      // Company and application details
      #align(left)[
        #text(size: 10pt)[#cover-letter-data.application.date]

        #v(1em)
        #cover-letter-data.company.address

        #v(1em)
        #text(weight: "medium")[
          Re: #cover-letter-data.company.position - #cover-letter-data.company.department
        ]
        #if "reference" in cover-letter-data.application [
          #linebreak()
          #text(size: 9pt, style: "italic")[#cover-letter-data.application.reference]
        ]
      ]

      #cover-letter-content(
        cover-letter-data.letter.opening,
        cover-letter-data.letter.body-paragraphs,
        cover-letter-data.letter.closing
      )

      #pagebreak()
    ]

    // Header Section
    #name-header(resume-data)

    #section-divider()

    // Modern responsive 2-column layout
    #grid(
      columns: (3fr, 1fr),
      gutter: 3em,
      // Main content column
      stack(
        spacing: 1.2em,
        [
          // Introduction Section
          #header-style[#resume-data.introduction.headline]
          #v(0.4em)
          #resume-data.introduction.text
        ],
        [
          // Experience Section  
          #header-style[#resume-data.jobs.headline]
          #v(0.4em)
          #stack(
            spacing: 0.6em,
            ..resume-data.jobs.items.pairs().map(((job-key, job-data)) => {
              let highlights = if "highlights" in job-data { job-data.highlights } else { none }
              job-entry(job-data.role, job-data.name, str(job-data.from) + " – " + str(job-data.to), job-data.summary, highlights: highlights)
            })
          )
        ]
      ),
      // Skills sidebar
      stack(
        spacing: 0.8em,
        [
          #header-style[#resume-data.skills.headline]
          #v(0.2em)
          #for (skill, level) in resume-data.skills.name-level [
            #skill-entry(skill, level)
          ]
        ]
      )
    )

    #v(1.5em)

    // Continue 2-column layout for additional sections
    #grid(
      columns: (3fr, 1fr),
      gutter: 3em,
      // Main content column - continued
      stack(
        spacing: 1.4em,
        [
          // Education Section
          #header-style[#resume-data.education.headline]
          #v(0.4em)
          #stack(
            spacing: 0.6em,
            ..resume-data.education.items.pairs().map(((edu-key, edu-data)) => {
              let period = if "from" in edu-data and "to" in edu-data { str(edu-data.from) + " – " + str(edu-data.to) } else { none }
              let location = if "location" in edu-data { edu-data.location } else { none }
              let highlights = if "highlights" in edu-data { edu-data.highlights } else { none }
              education-entry(edu-data.role, edu-data.name, location, period, edu-data.summary, highlights)
            })
          )
        ],
        [
          // Certifications Section
          #header-style[#resume-data.certificates.headline]
          #v(0.4em)
          #for (cert-key, cert-data) in resume-data.certificates.items [
            #cert-entry(cert-data.title, cert-data.date)
          ]
        ],
        [
          // Volunteer Experience Section
          #header-style[#resume-data.volunteer.headline]
          #v(0.4em)
          #volunteer-entry(resume-data.volunteer.items.title, resume-data.volunteer.items.description)
        ],
        [
          // Publications Section
          #header-style[#resume-data.publications.headline]
          #v(0.4em)
          #publication-entry(resume-data.publications.items.title, resume-data.publications.items.date, resume-data.publications.items.description)
        ]
      ),
      // Right sidebar - continued
      stack(
        spacing: 1.4em,
        [
          // Languages Section
          #header-style[Languages]
          #v(0.4em)
          #for (lang, details) in resume-data.languages [
            #language-entry(lang, details.level)
          ]
        ],
        [
          // References Section
          #if "references" in resume-data [
            #header-style[#resume-data.references.headline]
            #v(0.4em)
            #for item in resume-data.references.items [
              #v(0.2em)
              *#item.name* \
              #text(style: "italic")[#item.title] \
              #text(size: 9pt)[#item.address]
              #v(0.4em)
            ]
          ]
        ],
        [
          // Hobbies Section
          #header-style[#resume-data.hobbies.headline]
          #v(0.4em)
          #hobby-list(resume-data.hobbies.items)
        ]
      )
    )

    // Additional content from doc parameter
    #doc
  ])
}

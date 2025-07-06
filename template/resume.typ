// Resume template function - Following Typst best practices

#let resume-template(
  // Required parameters
  name: none,
  resume-data: none,

  // Optional contact information
  email: none,
  phone: none,
  github: none,
  linkedin: none,
  website: none,

  // Layout functions - passed as parameters
  layout-functions: none,

  // Cover letter parameters
  cover-letter-data: none,
  include-cover-letter: false,

  // Optional styling parameters
  theme: "professional",
  accent-color: rgb("#1e40af"),

  // Document content
  doc,
) = {
  // Parameter validation
  assert(name != none, message: "Name is required for resume template")
  assert(resume-data != none, message: "Resume data is required for resume template")
  assert(layout-functions != none, message: "Layout functions are required for resume template")

  // Extract layout functions from passed dictionary
  let setup-document = layout-functions.setup-document
  let header-style = layout-functions.header-style
  let subheader-style = layout-functions.subheader-style
  let meta-text = layout-functions.meta-text
  let section-divider = layout-functions.section-divider
  let name-header = layout-functions.name-header
  let contact-info = layout-functions.contact-info
  let job-entry = layout-functions.job-entry
  let education-entry = layout-functions.education-entry
  let skill-icon = layout-functions.skill-icon
  let skill-entry = layout-functions.skill-entry
  let cert-entry = layout-functions.cert-entry
  let language-entry = layout-functions.language-entry
  let volunteer-entry = layout-functions.volunteer-entry
  let cover-letter-content = layout-functions.cover-letter-content
  let bullet-list = layout-functions.bullet-list
  let numbered-list = layout-functions.numbered-list
  let achievement-list = layout-functions.achievement-list
  let dot-ratings = layout-functions.dot-ratings

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

    // 2 column layout, left main and right sidebar

    #grid(
      columns: (19fr, 6fr),
      column-gutter: 4.2em,
      [

        // Introduction Section
        #header-style[#resume-data.introduction.headline]
        #v(0.4em)
        #resume-data.introduction.text
        #v(1.2em)
        // Experience Section
        #header-style[#resume-data.jobs.headline]
        #v(0.4em)

      ],
      [
        // Skills Section
        #header-style[#resume-data.skills.headline]
        #v(-0.3em)
        #for (skill, level) in resume-data.skills.name-level [
          #skill-entry(skill, level)
        ]

      ],
    )

    #for (job-key, job-data) in resume-data.jobs.items [
      #let highlights = if "highlights" in job-data { job-data.highlights } else { none }
      #job-entry(job-data.role, job-data.name, str(job-data.from) + " – " + str(job-data.to), job-data.summary, highlights: highlights)
    ]

    // Education Section
    #header-style[#resume-data.education.headline]
    #v(0.4em)

    #for (edu-key, edu-data) in resume-data.education.items [
      #let period = if "from" in edu-data and "to" in edu-data { str(edu-data.from) + " – " + str(edu-data.to) } else { none }
      #let location = if "location" in edu-data { edu-data.location } else { none }
      #let highlights = if "highlights" in edu-data { edu-data.highlights } else { none }
      #education-entry(edu-data.role, edu-data.name, location, period, edu-data.summary, highlights)
    ]


    #v(0.8em)

    // Certifications Section
    #header-style[#resume-data.certificates.headline]
    #v(0.4em)

    #for (cert-key, cert-data) in resume-data.certificates.items [
      #cert-entry(cert-data.title, cert-data.date)
    ]

    #v(0.8em)

    // Languages Section
    #header-style[Languages]
    #v(0.4em)

    #for (lang, details) in resume-data.languages [
      #language-entry(lang, details.level)
    ]

    #v(0.8em)

    // Volunteer Experience Section
    #header-style[#resume-data.volunteer.headline]
    #v(0.4em)

    #volunteer-entry(resume-data.volunteer.items.title, resume-data.volunteer.items.description)

    // Additional content from doc parameter
    #doc
  ])
}

// Main entry point for resume generation - Following Typst best practices

#import "template/resume.typ": resume-template
#import "template/layout.typ" as layout
#import "template/elements.typ" as elements

// Load resume data to extract name for template
#let resume-data = yaml("data/resume.yml")

// Get the layout functions
#let layout-functions = (
  setup-document: layout.setup-document,
  header-style: layout.header-style,
  subheader-style: layout.subheader-style,
  meta-text: layout.meta-text,
  section-divider: layout.section-divider,
  name-header: layout.name-header,
  contact-info: layout.contact-info,
  job-entry: layout.job-entry,
  education-entry: layout.education-entry,
  skill-icon: layout.skill-icon,
  skill-entry: layout.skill-entry,
  cert-entry: layout.cert-entry,
  language-entry: layout.language-entry,
  volunteer-entry: layout.volunteer-entry,
  cover-letter-header: layout.cover-letter-header,
  cover-letter-content: layout.cover-letter-content,
  bullet-list: layout.bullet-list,
  numbered-list: layout.numbered-list,
  achievement-list: layout.achievement-list,
  dot-ratings: elements.dot-ratings
)

// Use the resume template with required parameters
#show: doc => resume-template(
  name: resume-data.firstname + " " + resume-data.lastname,
  resume-data: resume-data,
  layout-functions: layout-functions,
  email: resume-data.email,
  phone: resume-data.phone,
  github: resume-data.github,
  doc
)

// Any additional content can be added here
// The template will handle all the resume sections automatically

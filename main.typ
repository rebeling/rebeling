// Main entry point for resume generation - Modern Typst approach

#import "template/resume.typ": resume-template

// Load resume data
#let base-resume-data = yaml("data/resume.yml")

// Load secrets (PII)
// Warning: This file must exist. If missing, create data/secrets.yml
#let secrets-data = yaml("data/secrets.yml")

// Merge secrets into resume data
#let resume-data = base-resume-data + secrets-data

// Try to load cover letter data (if available)
#let cover-letter-data = {
  // Check for cover letter argument or default file
  if sys.inputs.at("cover", default: none) != none {
    yaml("data/cover-" + sys.inputs.cover + ".yml")
  } else {
    none
  }
}

// Use the modernized resume template
#show: doc => resume-template(
  name: resume-data.firstname + " " + resume-data.lastname,
  resume-data: resume-data,
  cover-letter-data: cover-letter-data,
  include-cover-letter: cover-letter-data != none,
  doc
)

// Any additional content can be added here
// The template will handle all the resume sections automatically

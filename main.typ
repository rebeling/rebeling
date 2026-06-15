// Main entry point for CV generation - Modern Typst approach

#import "template/cv.typ": cv-template

// Recursively deep-merge two dicts: values in `b` win, nested dicts merge.
#let deep-merge(a, b) = {
  let result = a
  for (key, b-val) in b {
    if key in result and type(result.at(key)) == dictionary and type(b-val) == dictionary {
      result.insert(key, deep-merge(result.at(key), b-val))
    } else {
      result.insert(key, b-val)
    }
  }
  result
}

// Load CV data
#let lang = sys.inputs.at("lang", default: "en")
#let cv-file = if lang == "en" { "data/cv.yml" } else { "data/cv_" + lang + ".yml" }
#let base-cv-data = yaml(cv-file)

// Load role override (if a role is selected), e.g. data/roles/ai.yml
#let role = sys.inputs.at("role", default: none)
#let role-data = if role != none { yaml("data/roles/" + role + ".yml") } else { (:) }

// Load secrets (PII)
// Warning: This file must exist. If missing, create data/secrets.yml
#let secrets-data = yaml("data/secrets.yml")

// Merge order: base CV <- role override <- secrets (PII always wins)
#let cv-data = deep-merge(deep-merge(base-cv-data, role-data), secrets-data)

// Try to load cover letter data (if available)
#let cover-letter-data = {
  // Check for cover letter argument or default file
  if sys.inputs.at("cover", default: none) != none {
    // One cover file per company. Its content language is whatever you write
    // in the YAML (incl. the date string); lang only affects CV section labels.
    yaml("data/cover-" + sys.inputs.cover + ".yml")
  } else {
    none
  }
}

// Use the modernized CV template
#show: doc => cv-template(
  name: cv-data.firstname + " " + cv-data.lastname,
  cv-data: cv-data,
  cover-letter-data: cover-letter-data,
  include-cover-letter: cover-letter-data != none,
  mode: sys.inputs.at("mode", default: "full"),
  lang: lang,
  doc
)

// Any additional content can be added here
// The template will handle all the CV sections automatically

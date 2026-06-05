# CV Generator

A Typst-based CV generator driven by YAML data. Content lives in YAML; layout and styling live in Typst template files. Supports multiple languages and per-company cover letters.

## Quick Start

```bash
# Install Typst (if not already installed)
brew install typst

# Generate the CV
./build.sh
```

`data/secrets.yml` must exist locally — it holds PII (`email`, `phone`, `address`, …) and is gitignored. Create it before building.

## Commands

```bash
./build.sh [options]
```

**Options:**
- `-l, --lang LANG` — Language (default: `en`)
- `-c, --cover COMPANY` — Include cover letter for the given company
- `-h, --help` — Show help

**Examples:**
```bash
./build.sh                          # CV only (English) → cv.pdf
./build.sh --lang de                # CV only (German)  → cv_de.pdf
./build.sh --cover companyX         # CV + cover letter → cv-with-cover-companyX.pdf
./build.sh -l de -c companyX        # German CV + cover letter
```

### Direct Typst Compilation

```bash
typst compile --font-path data/assets/fonts main.typ cv.pdf
```

## File Structure

```
main.typ                  # Entry point: merges cv.yml + secrets.yml, loads cover letter
template/
├── cv.typ                # #cv-template() — assembles all sections
├── layout.typ            # Styling functions + layout constants
└── elements.typ          # dot-ratings() component (skill/language bars)
data/
├── cv.yml                # Public CV content (no PII)
├── cv_de.yml             # German CV content
├── secrets.yml           # PII (gitignored) — must exist locally
├── cover-{company}.yml   # Per-company cover letter data
└── assets/fonts/         # Font files for compilation
build.sh                  # Build script
```

## Updating CV Content

1. Edit your professional information in `data/cv.yml` (or `data/cv_de.yml` for German).
2. Run `./build.sh` to regenerate the PDF.

## Layout Overrides via YAML

`cv.yml` supports a top-level `layout:` key to override spacing/sizing without touching Typst files. Supported sub-keys: `page` (margins), `header` (name/contact sizes), `divider` (stroke/gaps), `columns` (widths/gutter), `markers` (rating square sizes).

## Architecture

- **Data-driven** — CV content stored separately from presentation.
- **Two-column layout** — main content column + sidebar, with independent column paging.
- **Template Function Pattern** — `#cv-template()` parameterized with validation.
- **Kebab-case Naming** — consistent function naming.

## Skill / Language Levels

String labels map to 1–5 dot ratings:
- Skills: `Expert` / `Experienced` / `Skillful` / `Intermediate` / `Beginner`
- Languages: `native` / `advanced` / `intermediate` / `basic`

## Requirements

- [Typst](https://typst.app/) — `brew install typst`
- Fonts in `data/assets/fonts/` (IBM Plex Serif)

## Clean Up

```bash
rm -rf output
```

## Fonts

```bash
# Create fonts directory
mkdir -p data/assets/fonts

# IBM Plex Serif (used by the template) can be downloaded from Google Fonts:
# https://fonts.google.com/specimen/IBM+Plex+Serif
# Place the .ttf files directly in data/assets/fonts/
```

## License

MIT License.

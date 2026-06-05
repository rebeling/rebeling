# Project Status and Task List

## Repository Overview
**Project**: Typst CV Generator (`rebeling`)
**Description**: A data-driven CV and Cover Letter generator using [Typst](https://typst.app/).

### Structure
- **`data/cv.yml`**: Central source of truth for your professional profile.
- **`data/cover-*.yml`**: Data files for specific cover letters (e.g., `cover-example.yml`).
- **`template/`**: Typst styling and layout logic (`cv.typ`, `layout.typ`).
- **`main.typ`**: Entry point combining data and templates.
- **`build.sh`**: Helper script to compile PDFs.

### Usage
- **Build CV**: `./build.sh`
- **Build with Cover Letter**: `./build.sh -c [name]` (uses `data/cover-[name].yml`)

---

## Completed Tasks

- [x] **Project Analysis**
  - Investigated `rebeling` and `cv2-trash` folder structures.
  - Identified discrepency between `CV.md` and actual capabilities (layout vs content).

- [x] **Content Updates (`data/cv.yml`)**
  - **Skills**: Added "HTMX" as an Experienced skill.
  - **Professional Summary**: Updated to highlight Senior status, Open Source contributions, and HTMX/Drupal integration.
  - **Volunteer Work**: Renamed to "Open Source & Community" with specific details on module development.
  - **References**: Added contact details for Tarn Barford, Dr. Teichmann, and Daniel Schultheiss.

- [x] **Feature Implementation**
  - **Multi-Language Support**: Added support for German CVs and Cover Letters.
    - Added `--lang` argument to `build.sh`.
    - Implemented dynamic loading of localized data files (e.g., `cv_de.yml`).
    - Localized hardcoded strings and document titles.
    - Updated dot-rating mappings for translated skill levels.
  - **Reference Section**: Updated `template/cv.typ` to support rendering a "References" block in the sidebar (previously missing).
  - **Cover Letter**: Created a reusable template structure and a sample file (`data/cover-example.yml`).

- [x] **Optimization**
  - **ATS Keywords**: Enriched content with keywords like "Senior Software Engineer", "Deep Technical Expertise", "Multi-agent systems", "NLP", "Machine Learning".

## Pending / Future Ideas
- [ ] Create specialized cover letters for target companies.
- [ ] Refine "Modern" or "Classic" layout alternatives if needed (currently using a unified "Professional" layout).
- [ ] **Dynamic Cover Letters**: Create a system for generated cover letters with keyword injection and position adaptation (base template + variable injection).

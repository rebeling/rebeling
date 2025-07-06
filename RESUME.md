# Resume Generator

A flexible Typst-based resume generator that supports multiple layout styles and follows modern best practices.

## Quick Start

```bash
# Install Typst (if not already installed)
brew install typst

# Generate resume with default professional layout
./build.sh

# Generate with different layouts
./build.sh -l modern          # Modern colorful layout
./build.sh --layout classic   # Traditional black & white layout
```

## Available Layout Styles

- **professional** (default) - Clean blue accents, modern typography
- **modern** - Colorful sections, rounded corners, visual skill progress bars
- **classic** - Traditional black & white, Times New Roman, formal style

## Commands

### Build Resume
```bash
./build.sh [options]
```

**Options:**
- `-l, --layout LAYOUT` - Choose layout style (professional, modern, classic)
- `-c, --cover COMPANY` - Include cover letter for specified company
- `-h, --help` - Show help message

**Examples:**
```bash
./build.sh                          # Resume only with professional layout
./build.sh -l modern                # Resume only with modern layout
./build.sh --layout classic         # Resume only with classic layout
./build.sh --cover companyX         # Resume + cover letter for companyX
./build.sh -l modern -c companyX    # Modern layout with cover letter
./build.sh -h                       # Show help
```

### Direct Typst Compilation
```bash
typst compile main.typ resume.pdf
```

## File Structure

```
resume-project/
├── main.typ                  # Main entry point
├── template/
│   ├── layout.typ           # Professional layout (default)
│   ├── layout-modern.typ    # Modern layout with colors
│   ├── layout-classic.typ   # Classic traditional layout
│   └── resume.typ           # Template function with validation
├── data/
│   ├── resume.yml           # Resume data in YAML format
│   └── cover-companyX.yml   # Company-specific cover letter data
├── assets/                  # Directory for images/fonts
├── build.sh                 # Build script with layout options
└── README.md               # This file
```

## Updating Resume Content

1. Edit your professional information in `data/resume.yml`
2. Run `./build.sh` to regenerate the PDF
3. Use `./build.sh -l [layout]` to generate with a specific layout

## Creating Custom Layouts

1. Create a new file `template/layout-[name].typ`
2. Implement all required functions (see existing layouts as examples)
3. Add import and layout selection logic to `main.typ`
4. Update build script to include new layout option

## Requirements

- [Typst](https://typst.app/) - Modern markup-based typesetting system
- YAML data file with resume information

## Architecture

This project follows Typst best practices:

- **Modular Design** - Separation of data, layout, and template logic
- **Template Function Pattern** - Parameterized templates with validation
- **Kebab-case Naming** - Consistent function naming convention
- **Layout Flexibility** - Support for multiple styles without code duplication
- **Data-driven** - Resume content stored separately from presentation

## Output

Each layout generates its own PDF file:
- `resume-professional.pdf`
- `resume-modern.pdf`
- `resume-classic.pdf`

## License

This project is open source and available under the MIT License.


## Clean Up

```bash
rm resume*.pdf
```


## Fonts

    # Create fonts directory
    mkdir -p data/assets/fonts

    # Download Inter font from Google Fonts or GitHub
    curl -L "https://github.com/rsms/inter/releases/download/v4.0/Inter-4.0.zip" -o inter.zip
    unzip inter.zip -d data/assets/fonts/inter
    rm inter.zip

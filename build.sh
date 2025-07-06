#!/bin/bash

# Build script for Typst resume

# Default values
COVER_COMPANY=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -c|--cover)
            COVER_COMPANY="$2"
            shift 2
            ;;
        -h|--help)
            echo "Usage: $0 [options]"
            echo "Options:"
            echo "  -c, --cover COMPANY     Include cover letter for specified company"
            echo "  -h, --help             Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0                      # Resume only"
            echo "  $0 --cover companyX     # Resume + cover letter for companyX"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
    esac
done

# Check if cover letter file exists when cover letter is requested
if [[ -n "$COVER_COMPANY" ]]; then
    COVER_FILE="data/cover-${COVER_COMPANY}.yml"
    if [[ ! -f "$COVER_FILE" ]]; then
        echo "Error: Cover letter file '$COVER_FILE' not found"
        echo "Create the file with company-specific cover letter content"
        exit 1
    fi
    echo "Building resume PDF with cover letter for $COVER_COMPANY..."
else
    echo "Building resume PDF..."
fi

# Check if typst is installed
if ! command -v typst &> /dev/null; then
    echo "Error: Typst is not installed. Please install it first:"
    echo "  brew install typst"
    echo "  Or visit: https://typst.app/docs/guides/install/"
    exit 1
fi

# Determine output filename
if [[ -n "$COVER_COMPANY" ]]; then
    OUTPUT_FILE="resume-with-cover-${COVER_COMPANY}.pdf"
else
    OUTPUT_FILE="resume.pdf"
fi

# Compile the resume with font path
typst compile --font-path data/assets/fonts main.typ "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
    echo "✅ Resume compiled successfully: $OUTPUT_FILE"
    if [[ -n "$COVER_COMPANY" ]]; then
        echo "📄 Generated from: main.typ with $COVER_COMPANY cover letter"
    else
        echo "📄 Generated from: main.typ"
    fi
else
    echo "❌ Error compiling resume"
    exit 1
fi
#!/bin/bash

# Build script for Typst CV

# Default values
COVER_COMPANY=""
LANG="en"
ROLE=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -c|--cover)
            COVER_COMPANY="$2"
            shift 2
            ;;
        -l|--lang)
            LANG="$2"
            shift 2
            ;;
        -r|--role)
            ROLE="$2"
            shift 2
            ;;
        -h|--help)
            echo "Usage: $0 [options]"
            echo "Options:"
            echo "  -r, --role ROLE         Role variant (ai, lead, fullstack)"
            echo "  -c, --cover COMPANY     Include cover letter for specified company"
            echo "  -l, --lang LANG         Language (default: en)"
            echo "  -h, --help             Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0                      # Base CV (English)"
            echo "  $0 --role ai            # AI Engineer variant"
            echo "  $0 --lang de            # CV only (German)"
            echo "  $0 -r lead -c companyX  # Lead variant + cover letter for companyX"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
    esac
done

# Check if role override file exists when a role is requested
if [[ -n "$ROLE" ]]; then
    ROLE_FILE="data/roles/${ROLE}.yml"
    if [[ ! -f "$ROLE_FILE" ]]; then
        echo "Error: Role file '$ROLE_FILE' not found"
        echo "Available roles: ai, lead, fullstack"
        exit 1
    fi
fi

# Check if cover letter file exists when cover letter is requested
if [[ -n "$COVER_COMPANY" ]]; then
    COVER_FILE="data/cover-${COVER_COMPANY}.yml"
    if [[ ! -f "$COVER_FILE" ]]; then
        echo "Error: Cover letter file '$COVER_FILE' not found"
        echo "Create the file with company-specific cover letter content"
        exit 1
    fi
fi

ROLE_LABEL="${ROLE:-base}"
if [[ -n "$COVER_COMPANY" ]]; then
    echo "Building CV PDF (role: $ROLE_LABEL, $LANG) with cover letter for $COVER_COMPANY..."
else
    echo "Building CV PDF (role: $ROLE_LABEL, $LANG)..."
fi

# Check if typst is installed
if ! command -v typst &> /dev/null; then
    echo "Error: Typst is not installed. Please install it first:"
    echo "  brew install typst"
    echo "  Or visit: https://typst.app/docs/guides/install/"
    exit 1
fi

# Determine output filename
SUFFIX=""
if [[ "$LANG" != "en" ]]; then
    SUFFIX="_${LANG}"
fi

ROLE_PART=""
if [[ -n "$ROLE" ]]; then
    ROLE_PART="-${ROLE}"
fi

mkdir -p output
if [[ -n "$COVER_COMPANY" ]]; then
    OUTPUT_FILE="output/cv${ROLE_PART}${SUFFIX}-with-cover-${COVER_COMPANY}.pdf"
else
    OUTPUT_FILE="output/cv${ROLE_PART}${SUFFIX}.pdf"
fi

# Compile the CV with font path and optional parameters
INPUT_ARGS="--input lang=$LANG"
if [[ -n "$ROLE" ]]; then
    INPUT_ARGS="$INPUT_ARGS --input role=$ROLE"
fi
if [[ -n "$COVER_COMPANY" ]]; then
    INPUT_ARGS="$INPUT_ARGS --input cover=$COVER_COMPANY"
fi

typst compile --font-path data/assets/fonts $INPUT_ARGS main.typ "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
    echo "✅ CV compiled successfully: $OUTPUT_FILE"
    if [[ -n "$COVER_COMPANY" ]]; then
        echo "📄 Generated from: main.typ with $COVER_COMPANY cover letter"
    else
        echo "📄 Generated from: main.typ"
    fi
else
    echo "❌ Error compiling CV"
    exit 1
fi
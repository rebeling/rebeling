#!/bin/bash

# Build script for Typst CV

# Default values
COVER_COMPANY=""
LANG="en"
ROLE=""
NAME="matthias-rebel"
SPLIT=false
# Output filename prefix is set per-mode: cv- / cover- / cover-cv-

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
        -s|--split)
            SPLIT=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [options]"
            echo "Options:"
            echo "  -r, --role ROLE         Role variant (ai, lead, fullstack)"
            echo "  -c, --cover COMPANY     Include cover letter for specified company"
            echo "  -l, --lang LANG         Language (default: en)"
            echo "  -s, --split             Emit two separate PDFs: cover-... and cv-..."
            echo "  -h, --help             Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0                      # Base CV (English)"
            echo "  $0 --role ai            # AI Engineer variant"
            echo "  $0 --lang de            # CV only (German)"
            echo "  $0 -r lead -c companyX  # Lead variant + cover letter for companyX"
            echo "  $0 -c companyX -s       # Separate cover-companyX.pdf + cv.pdf"
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

# Determine output dir — lang becomes a subdir, not a filename suffix
OUT_DIR="output/${LANG}"
mkdir -p "$OUT_DIR"

ROLE_PART=""
if [[ -n "$ROLE" ]]; then
    ROLE_PART="-${ROLE}"
fi

COMPANY_PART=""
if [[ -n "$COVER_COMPANY" ]]; then
    COMPANY_PART="-${COVER_COMPANY}"
fi

# Cover filename prefix is localized; CV prefix stays "cv-"
COVER_PREFIX="cover"
if [[ "$LANG" == "de" ]]; then
    COVER_PREFIX="anschreiben"
fi

# Shared Typst inputs (role + cover); mode is added per build
BASE_ARGS="--input lang=$LANG"
if [[ -n "$ROLE" ]]; then
    BASE_ARGS="$BASE_ARGS --input role=$ROLE"
fi
if [[ -n "$COVER_COMPANY" ]]; then
    BASE_ARGS="$BASE_ARGS --input cover=$COVER_COMPANY"
fi

# compile MODE OUTFILE — runs one typst build, exits on failure
compile() {
    local mode="$1" outfile="$2"
    typst compile --font-path data/assets/fonts $BASE_ARGS --input mode=$mode main.typ "$outfile"
    if [ $? -eq 0 ]; then
        echo "✅ Compiled: $outfile"
    else
        echo "❌ Error compiling $outfile"
        exit 1
    fi
}

if [[ "$SPLIT" == true && -n "$COVER_COMPANY" ]]; then
    # Two separate PDFs: cover-only and cv-only
    compile cover "${OUT_DIR}/${COVER_PREFIX}-${NAME}${ROLE_PART}${COMPANY_PART}.pdf"
    compile cv    "${OUT_DIR}/cv-${NAME}${ROLE_PART}.pdf"
elif [[ -n "$COVER_COMPANY" ]]; then
    # Single combined PDF (cover page + cv)
    compile full "${OUT_DIR}/${COVER_PREFIX}-cv-${NAME}${ROLE_PART}${COMPANY_PART}.pdf"
else
    # CV only, no cover requested
    compile cv "${OUT_DIR}/cv-${NAME}${ROLE_PART}.pdf"
fi
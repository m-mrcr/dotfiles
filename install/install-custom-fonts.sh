#!/usr/bin/env bash
# Install custom fonts that aren't available via Homebrew

set -e

FONTS_SOURCE_DIR="$HOME/Documents/03 Resources/How to Setup a New Mac/Fonts"
FONTS_INSTALL_DIR="$HOME/Library/Fonts"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}Installing custom fonts...${NC}"

# Check if source directory exists
if [ ! -d "$FONTS_SOURCE_DIR" ]; then
    echo "Error: Fonts source directory not found at $FONTS_SOURCE_DIR"
    exit 1
fi

# Create fonts directory if it doesn't exist
mkdir -p "$FONTS_INSTALL_DIR"

# Counters for reporting
installed_count=0
skipped_count=0
total_files=0

# Custom fonts that aren't in Homebrew
custom_fonts=(
    "Bookerly"
    "SNPro"
    "Poppins-Regular.ttf"
    "Tiempos Text"
    "Tiempos Headline"
    "Tiempos Fine"
    "Baskerville"
    "Germagont"
    "Powerr"
    "Maple Mono TTF"
    "Maple Mono NL TTF"
    "Nerd Fonts Daddy Time Mono"
    "Atkinson Hyperlegible"
    "Nunito_Sans"
)

# Install each custom font
for font in "${custom_fonts[@]}"; do
    if [ -e "$FONTS_SOURCE_DIR/$font" ]; then
        echo -e "${BLUE}Processing $font...${NC}"

        if [ -d "$FONTS_SOURCE_DIR/$font" ]; then
            # It's a directory, process all font files
            while IFS= read -r -d '' font_file; do
                ((total_files++))
                font_basename=$(basename "$font_file")

                # Check if font already exists
                if [ -f "$FONTS_INSTALL_DIR/$font_basename" ]; then
                    echo -e "${YELLOW}  ⊘ Skipping $font_basename (already installed)${NC}"
                    ((skipped_count++))
                else
                    cp "$font_file" "$FONTS_INSTALL_DIR/"
                    echo -e "${GREEN}  ✓ Installed $font_basename${NC}"
                    ((installed_count++))
                fi
            done < <(find "$FONTS_SOURCE_DIR/$font" -type f \( -name "*.ttf" -o -name "*.otf" -o -name "*.ttc" \) -print0)
        else
            # It's a single file
            ((total_files++))
            font_basename=$(basename "$font")

            if [ -f "$FONTS_INSTALL_DIR/$font_basename" ]; then
                echo -e "${YELLOW}  ⊘ Skipping $font_basename (already installed)${NC}"
                ((skipped_count++))
            else
                cp "$FONTS_SOURCE_DIR/$font" "$FONTS_INSTALL_DIR/"
                echo -e "${GREEN}  ✓ Installed $font_basename${NC}"
                ((installed_count++))
            fi
        fi
    else
        echo "Warning: $font not found, skipping..."
    fi
done

echo ""
echo -e "${GREEN}✓ Font installation complete!${NC}"
echo -e "${BLUE}  • Total font files processed: $total_files${NC}"
echo -e "${GREEN}  • Newly installed: $installed_count${NC}"
echo -e "${YELLOW}  • Already installed (skipped): $skipped_count${NC}"

if [ $installed_count -gt 0 ]; then
    echo ""
    echo -e "${BLUE}Note: You may need to restart applications to see the new fonts.${NC}"
fi

#!/usr/bin/env bats
# Tests for install-custom-fonts.sh

SCRIPT_PATH="/Users/martinmercer/.dotfiles/install/install-custom-fonts.sh"

@test "script exists and is executable" {
    [ -f "$SCRIPT_PATH" ]
    [ -x "$SCRIPT_PATH" ]
}

@test "script has correct shebang" {
    head -n 1 "$SCRIPT_PATH" | grep -q "#!/usr/bin/env bash"
}

@test "script defines FONTS_SOURCE_DIR variable" {
    grep -q "FONTS_SOURCE_DIR=" "$SCRIPT_PATH"
}

@test "script defines FONTS_INSTALL_DIR variable" {
    grep -q "FONTS_INSTALL_DIR=" "$SCRIPT_PATH"
}

@test "script has color definitions" {
    grep -q "GREEN=" "$SCRIPT_PATH"
    grep -q "BLUE=" "$SCRIPT_PATH"
    grep -q "YELLOW=" "$SCRIPT_PATH"
}

@test "script checks for source directory existence" {
    grep -q 'if \[ ! -d "\$FONTS_SOURCE_DIR" \]' "$SCRIPT_PATH"
}

@test "script creates install directory" {
    grep -q 'mkdir -p "\$FONTS_INSTALL_DIR"' "$SCRIPT_PATH"
}

@test "script has custom_fonts array" {
    grep -q "custom_fonts=(" "$SCRIPT_PATH"
}

@test "script includes all expected custom fonts in array" {
    grep -A 20 "custom_fonts=(" "$SCRIPT_PATH" | grep -q "Bookerly"
    grep -A 20 "custom_fonts=(" "$SCRIPT_PATH" | grep -q "SNPro"
    grep -A 20 "custom_fonts=(" "$SCRIPT_PATH" | grep -q "Maple Mono TTF"
    grep -A 20 "custom_fonts=(" "$SCRIPT_PATH" | grep -q "Atkinson Hyperlegible"
}

@test "script checks if font files already exist before copying" {
    grep -q 'if \[ -f "\$FONTS_INSTALL_DIR/\$font_basename" \]' "$SCRIPT_PATH"
}

@test "script tracks installed_count" {
    grep -q "installed_count=0" "$SCRIPT_PATH"
    grep -q "((installed_count++))" "$SCRIPT_PATH"
}

@test "script tracks skipped_count" {
    grep -q "skipped_count=0" "$SCRIPT_PATH"
    grep -q "((skipped_count++))" "$SCRIPT_PATH"
}

@test "script finds font files with correct extensions" {
    grep -q '\\( -name "\*\.ttf" -o -name "\*\.otf" -o -name "\*\.ttc" \\)' "$SCRIPT_PATH"
}

@test "script provides completion statistics" {
    grep -q "Total font files processed:" "$SCRIPT_PATH"
    grep -q "Newly installed:" "$SCRIPT_PATH"
    grep -q "Already installed (skipped):" "$SCRIPT_PATH"
}

@test "script warns about missing fonts" {
    grep -q "Warning:.*not found" "$SCRIPT_PATH"
}

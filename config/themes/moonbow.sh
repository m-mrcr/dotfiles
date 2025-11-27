#!/usr/bin/env zsh
# Moonbow Theme - Custom Color Palette
# By Martin Mercer
# Personal color selection with Dusty Rose and Jasmine prominence

# Core Palette
export MOONBOW_PACIFIC_CYAN="#39F"    # Cool blue-teal
export MOONBOW_EMERALD="#0cce6b"         # Vibrant green
export MOONBOW_DUSTY_MAUVE="##6B5F8A"     # Soft purple
export MOONBOW_DUSTY_ROSE="#FFB1B3"      # ⭐ Warm pink (prominent)
export MOONBOW_JASMINE="#fce694"         # ⭐ Soft yellow (prominent)
export MOONBOW_PASTEL_RED="#ef5350"      # Your original red
export MOONBOW_WARM_GREY="#a19a94"       # Neutral warm grey

# Semantic Mappings (using your custom palette)
export MOONBOW_HEADING="$MOONBOW_JASMINE"          # Prominent yellow
export MOONBOW_COMMENT="$MOONBOW_DUSTY_MAUVE"      # Soft purple
export MOONBOW_LINK="$MOONBOW_PACIFIC_CYAN"        # Cool cyan
export MOONBOW_ACTIVE_LINK="$MOONBOW_DUSTY_ROSE"   # Prominent rose
export MOONBOW_CODE="$MOONBOW_PACIFIC_CYAN"        # Cyan for code
export MOONBOW_LITERAL="$MOONBOW_PACIFIC_CYAN"     # Cyan for literals
export MOONBOW_KEYWORD="$MOONBOW_DUSTY_MAUVE"      # Purple for keywords
export MOONBOW_MARKUP="$MOONBOW_EMERALD"           # Green for markup

# Status Colors
export MOONBOW_ADDITION="$MOONBOW_EMERALD"         # Green for additions
export MOONBOW_DELETION="$MOONBOW_PASTEL_RED"      # Red for deletions
export MOONBOW_SUBSTITUTION="$MOONBOW_PACIFIC_CYAN" # Cyan for changes
export MOONBOW_HIGHLIGHT="#234d70"                 # Dark blue highlight
export MOONBOW_STRIKETHROUGH="$MOONBOW_WARM_GREY"  # Grey for strikethrough

# Accent Colors (reordered for prominence)
export MOONBOW_ACCENT01="$MOONBOW_JASMINE"       # 1st: Jasmine (yellow)
export MOONBOW_ACCENT02="$MOONBOW_DUSTY_ROSE"    # 2nd: Dusty Rose (pink)
export MOONBOW_ACCENT03="$MOONBOW_PACIFIC_CYAN"  # 3rd: Pacific Cyan
export MOONBOW_ACCENT04="$MOONBOW_PASTEL_RED"    # 4th: Pastel Red
export MOONBOW_ACCENT05="$MOONBOW_EMERALD"       # 5th: Emerald
export MOONBOW_ACCENT06="$MOONBOW_DUSTY_MAUVE"   # 6th: Dusty Mauve

# Quick Semantic Aliases
export MOONBOW_SUCCESS="$MOONBOW_EMERALD"
export MOONBOW_ERROR="$MOONBOW_PASTEL_RED"
export MOONBOW_WARNING="$MOONBOW_JASMINE"
export MOONBOW_INFO="$MOONBOW_PACIFIC_CYAN"

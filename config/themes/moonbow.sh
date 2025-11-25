#!/usr/bin/env zsh
# Moonbow Theme - Color Palette
# By Martin Mercer
# Adapted from Night Owl by Jeff Mueller & Sarah Drasner

# Editor Colors
export MOONBOW_FOREGROUND="#d6deeb"
export MOONBOW_BACKGROUND="#000000"
export MOONBOW_HEADING="#82b1ff"
export MOONBOW_COMMENT="#ae7f99"
export MOONBOW_LINK="#80cbc4"
export MOONBOW_ACTIVE_LINK="#d1aaff"
export MOONBOW_CODE="#80cbc4"
export MOONBOW_LITERAL="#82aaff"
export MOONBOW_KEYWORD="#c792ea"
export MOONBOW_MARKUP="#c5e478"

# Status Colors
export MOONBOW_ADDITION="#c5e478"      # Green
export MOONBOW_DELETION="#ef5350"      # Red
export MOONBOW_SUBSTITUTION="#a2bffc"  # Light Blue
export MOONBOW_HIGHLIGHT="#234d70"     # Dark Blue

# Accent Colors
export MOONBOW_ACCENT01="#82b1ff"  # Bright Blue
export MOONBOW_ACCENT02="#3de181"  # Green
export MOONBOW_ACCENT03="#f0d14f"  # Yellow
export MOONBOW_ACCENT04="#ff524f"  # Red
export MOONBOW_ACCENT05="#e89287"  # Salmon
export MOONBOW_ACCENT06="#9a94c7"  # Purple

# Interface Colors
export MOONBOW_TINT="#eec765"
export MOONBOW_PROMPT_BG="#011627"
export MOONBOW_BORDER="#122d42"

# Semantic Color Mappings (for easy use)
export MOONBOW_SUCCESS="$MOONBOW_ADDITION"
export MOONBOW_ERROR="$MOONBOW_DELETION"
export MOONBOW_WARNING="$MOONBOW_ACCENT03"
export MOONBOW_INFO="$MOONBOW_LITERAL"

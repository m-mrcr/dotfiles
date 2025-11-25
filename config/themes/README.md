# Moonbow Theme

A dark, vibrant theme by Martin Mercer, adapted from Jeff Mueller's Night Owl (originally by Sarah Drasner).

## Color Palette

### Primary Colors
- **Foreground**: `#d6deeb` - Soft blue-white for main text
- **Background**: `#000000` - Pure black for deep contrast

### Accent Colors
1. **Accent01 (Blue)**: `#82b1ff` - Bright blue for headings
2. **Accent02 (Green)**: `#3de181` - Vibrant green for success/additions
3. **Accent03 (Yellow)**: `#f0d14f` - Warm yellow for warnings/directories
4. **Accent04 (Red)**: `#ff524f` - Bright red for errors/deletions
5. **Accent05 (Salmon)**: `#e89287` - Soft coral pink
6. **Accent06 (Purple)**: `#9a94c7` - Muted purple

### Semantic Colors
- **Link**: `#80cbc4` - Teal cyan
- **Comment**: `#ae7f99` - Dusty rose
- **Keyword**: `#c792ea` - Bright purple
- **Markup**: `#c5e478` - Lime green
- **Code**: `#80cbc4` - Same as link (teal)
- **Literal**: `#82aaff` - Light blue

## Files Included

### `moonbow.json`
The master theme file with full scope definitions. Use this for:
- Drafts app
- NotePlan
- Other apps that support theme JSON imports

### `moonbow.sh`
Shell environment variables for the color palette. Source this in your shell config:
```bash
source "$DOTFILES_DIR/config/themes/moonbow.sh"
echo $MOONBOW_ACCENT02  # Outputs: #3de181
```

### `moonbow-ghostty.conf`
Ghostty terminal theme. To use:
```bash
# Add to your Ghostty config (~/.config/ghostty/config)
theme = ~/.dotfiles/config/themes/moonbow-ghostty.conf
```

## Current Integration

### ✅ Starship Prompt
Starship is already configured with Moonbow colors at `~/.config/starship.toml`:
- Green (`#3de181`) for username, git branch, Node.js
- Yellow (`#f0d14f`) for directory, prompt symbol
- Teal (`#80cbc4`) for hostname
- Blue (`#82aaff`) for Python, Docker
- Red (`#ff524f`) for errors, Rust

### 🎨 Customization Ideas

**Want more Catppuccin-style flavors?**
Consider creating variants:
- `moonbow-latte.json` - Light mode version
- `moonbow-frappe.json` - Medium contrast
- `moonbow-mocha.json` - Current dark theme

**Terminal ANSI colors**:
The Ghostty config maps your palette to the standard 16 ANSI colors, making syntax highlighting work across all terminal apps.

## Inspiration & Credits

- **Night Owl** by Sarah Drasner (original VS Code theme)
- **Jeff Mueller** (Drafts/NotePlan adaptation)
- **Catppuccin** (theme structure inspiration)
- **Martin Mercer** (Moonbow adaptation & curation)

## Future Plans

- [ ] Create light mode variant (Moonbow Latte?)
- [ ] Export to VS Code theme format
- [ ] Add bat (code viewer) theme
- [ ] Create fzf color scheme
- [ ] Add delta (git diff) theme

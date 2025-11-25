# Moonbow Theme

A dark, custom theme by Martin Mercer, featuring a personally curated color palette with **Dusty Rose** and **Jasmine** as prominent accent colors.

## Color Palette

### Core Colors (Your Custom Selection)
- **Jasmine** `#fce694` ⭐ - Soft, warm yellow (primary accent)
- **Dusty Rose** `#c08081` ⭐ - Warm pink (secondary accent, most prominent)
- **Pacific Cyan** `#2d93ad` - Cool blue-teal
- **Emerald** `#0cce6b` - Vibrant green
- **Dusty Mauve** `#977da1` - Soft purple
- **Warm Grey** `#a19a94` - Neutral warm grey
- **Pastel Red** `#ef5350` - Your original red

### Base Colors
- **Foreground**: `#d6deeb` - Soft blue-white for main text
- **Background**: `#000000` - Pure black for deep contrast

### Color Assignments

**Dusty Rose (`#c08081`)** appears in:
- Username in prompt
- Box drawing characters (`╭─` and `╰─`)
- Active links
- Action bar keys
- Cursor color (terminal)

**Jasmine (`#fce694`)** appears in:
- Directory path
- Prompt symbol (success)
- Headings
- Warnings
- Tint color

**Other Colors:**
- **Pacific Cyan** - Hostname, links, code, Python
- **Emerald** - Git branch, success messages, Node.js
- **Dusty Mauve** - Comments, keywords, command duration, packages
- **Pastel Red** - Errors, deletions, Rust
- **Warm Grey** - Strikethrough, time display

## RGB Values

For reference:
```
Pacific Cyan:  rgb(45, 147, 173)
Emerald:       rgb(12, 206, 107)
Dusty Mauve:   rgb(151, 125, 161)
Dusty Rose:    rgb(192, 128, 129)
Jasmine:       rgb(252, 230, 148)
Warm Grey:     rgb(161, 154, 148)
Pastel Red:    rgb(239, 83, 80)
```

## Files Included

### `moonbow.json`
The master theme file with full scope definitions. Use this for:
- Drafts app
- NotePlan
- Other apps that support theme JSON imports

Updated with your custom color palette where Dusty Rose and Jasmine have prominent positions.

### `moonbow.sh`
Shell environment variables for the color palette. Source this in your shell config:
```bash
source "$DOTFILES_DIR/config/themes/moonbow.sh"
echo $MOONBOW_DUSTY_ROSE    # Outputs: #c08081
echo $MOONBOW_JASMINE       # Outputs: #fce694
```

### `moonbow-ghostty.conf`
Ghostty terminal theme. To use:
```bash
# Add to your Ghostty config (~/.config/ghostty/config)
theme = ~/.dotfiles/config/themes/moonbow-ghostty.conf
```

Features Dusty Rose as the cursor color!

## Current Integration

### ✅ Starship Prompt
Starship is configured with your custom Moonbow colors at `~/.config/starship.toml`:

**Prominent Dusty Rose:**
- Username
- Box characters (`╭─╰─`)

**Prominent Jasmine:**
- Directory path
- Success prompt symbol `❯`

**Supporting colors:**
- Pacific Cyan - Hostname, Python, Docker, Go
- Emerald - Git branch, Node.js
- Dusty Mauve - Command duration, packages
- Pastel Red - Errors, Rust

### 🎨 Terminal Preview

Your prompt will look like this:
```
╭─martinmercer@hostname ~/Projects/dotfiles  main
╰─❯
```

Colors:
- `╭─╰─` and `martinmercer` in **Dusty Rose**
- `hostname` in **Pacific Cyan**
- `~/Projects/dotfiles` in **Jasmine**
- ` main` in **Emerald**
- `❯` in **Jasmine**

## Inspiration & Credits

- **Night Owl** by Sarah Drasner (original VS Code theme)
- **Jeff Mueller** (Drafts/NotePlan adaptation)
- **Catppuccin** (theme structure inspiration)
- **Martin Mercer** (Moonbow - custom palette curation)

## Future Expansion Ideas

- [ ] Create light mode variant (Moonbow Latte?)
- [ ] Export to VS Code theme format
- [ ] Add `bat` (code viewer) theme with your colors
- [ ] Create `fzf` color scheme
- [ ] Add `delta` (git diff) theme
- [ ] Generate complementary accent colors
- [ ] Create Neovim/Vim color scheme

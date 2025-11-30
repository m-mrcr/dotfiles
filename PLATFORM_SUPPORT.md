# Cross-Platform Support Guide

This dotfiles repo now supports **macOS**, **Linux**, and **Windows (WSL2)**.

## Platform Detection

The Makefile automatically detects your platform and runs the appropriate setup:

- **macOS**: Runs `make macos`
- **Linux**: Runs `make linux`
- **WSL2**: Runs `make wsl`

Detection scripts are in `bin/`:
- `bin/is-macos` - Detects macOS
- `bin/is-wsl` - Detects WSL2 environment
- `bin/is-windows` - Detects native Windows (Git Bash/MSYS)

## Platform-Specific Behaviors

### macOS (`make macos`)
- Installs Homebrew
- Installs packages from `install/Brewfile`
- Installs cask apps from `install/Caskfile`
- Installs Mac App Store apps from `install/Masfile`
- Runs `duti` for default app associations
- Symlinks configs with stow

### Linux (`make linux`)
- Uses apt-get for system packages
- Installs Homebrew for Linux (optional)
- Symlinks configs with stow
- Skips macOS-specific tools (duti, mas)

### WSL2 (`make wsl`)
- Installs essential build tools via apt
- Installs Homebrew for Linux
- Symlinks configs with stow
- Optimized for WSL2 environment

### Windows Native
- Use PowerShell script: `install/windows/setup.ps1`
- Installs apps via `winget` from `install/windows/winget-packages.txt`
- Sets up WSL2 and Ubuntu
- See `install/windows/README.md` for details

## File Organization

```
.dotfiles/
├── bin/                      # Helper scripts
│   ├── is-macos             # macOS detection
│   ├── is-wsl               # WSL2 detection
│   └── is-windows           # Windows detection
├── config/                   # Unix configs (all platforms)
│   ├── nvim/                # Neovim config
│   ├── git/                 # Git config
│   └── starship.toml        # Starship prompt
├── runcom/                   # Shell dotfiles
│   ├── .zshrc
│   └── .zprofile
├── install/
│   ├── Brewfile             # Homebrew packages (macOS/Linux/WSL)
│   ├── Caskfile             # macOS GUI apps
│   ├── Masfile              # Mac App Store apps
│   ├── npmfile              # Node packages (all platforms)
│   ├── Rustfile             # Rust packages (all platforms)
│   └── windows/
│       ├── setup.ps1                # Windows setup script
│       ├── winget-packages.txt      # Windows native apps
│       └── README.md                # Windows guide
└── Makefile                  # Main orchestrator
```

## Usage Examples

### On a fresh Mac
```bash
git clone <repo> ~/.dotfiles
cd ~/.dotfiles
make                # Auto-detects macOS, runs full setup
```

### On a Linux server
```bash
git clone <repo> ~/.dotfiles
cd ~/.dotfiles
make                # Auto-detects Linux
```

### On Windows
```powershell
# In PowerShell as Admin
cd path\to\dotfiles\install\windows
.\setup.ps1         # Install Windows apps + WSL2

# Then in WSL2 (Ubuntu)
cd ~
git clone <repo> ~/.dotfiles
cd ~/.dotfiles
make                # Auto-detects WSL2
```

## Shared vs Platform-Specific

### Shared Across All Platforms
- Shell configs (zsh)
- Git configuration
- Neovim setup
- Starship prompt
- Node packages (npmfile)
- Rust packages (Rustfile)
- Most CLI tools

### Platform-Specific
- **macOS only**: Cask apps, MAS apps, duti
- **Windows only**: winget packages, native GUI apps
- **Linux/WSL2**: apt packages for system dependencies

## Tips

### WSL2 + Windows Integration
- Install VS Code on Windows, use Remote-WSL extension
- Install GUI apps on Windows (browsers, Slack, etc.)
- Keep all dev tools in WSL2 (git, node, rust, etc.)
- Access WSL files from Windows: `\\wsl$\Ubuntu\home\<user>`
- Access Windows files from WSL: `/mnt/c/Users/<user>`

### Maintaining the Setup
- Edit package lists in `install/` directory
- Test changes on each platform before committing
- Use `make link` to re-symlink without reinstalling packages
- Run `make` to be idempotent - safe to run multiple times

## Adding New Platforms

To add support for a new platform:

1. Create detection script in `bin/is-<platform>`
2. Update Makefile OS detection logic
3. Add `<platform>:` target in Makefile
4. Add `stow-<platform>:` target for symlinking
5. Create platform-specific package lists in `install/<platform>/`
6. Update this documentation

## Troubleshooting

### "make: is-wsl: Command not found"
Ensure scripts are executable: `chmod +x bin/*`

### WSL2 not detected as WSL
Check `/proc/version` contains "microsoft"

### Stow conflicts
Run `make unlink` then `make link`, or remove conflicting files manually

### Homebrew not in PATH (WSL/Linux)
Add to shell config:
```bash
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

# Windows Setup Guide

This guide covers setting up your dotfiles on Windows using both native Windows apps and WSL2.

## Philosophy

- **Native Windows apps** (VS Code, browsers, etc.) install directly on Windows via `winget`
- **Unix tools and CLI** (git, shell, dev tools) run in WSL2 using this dotfiles repo
- **Best of both worlds**: Native performance for GUI apps, full Unix environment for development

## Initial Setup on Windows

### 1. Install Native Windows Applications

Open **PowerShell as Administrator** and run:

```powershell
cd path\to\dotfiles\install\windows
.\setup.ps1
```

This will:
- Install winget packages (VS Code, Git, Windows Terminal, etc.)
- Enable and install WSL2
- Install Ubuntu in WSL2

### 2. Configure WSL2

After WSL2 is installed, open **Windows Terminal** and select Ubuntu:

```bash
# Update package lists
sudo apt update && sudo apt upgrade -y

# Clone your dotfiles inside WSL2
cd ~
git clone <your-dotfiles-repo-url> .dotfiles
cd .dotfiles

# Run the setup
make
```

This will:
- Install Homebrew for Linux
- Install all packages from Brewfile
- Symlink all your config files
- Set up your shell environment

## Customizing Windows Packages

Edit `install/windows/winget-packages.txt` to add/remove Windows applications:

```
# Uncomment lines to install
Microsoft.VisualStudioCode
Git.Git
# Add your own packages
```

Find package IDs at: https://winget.run/

## File Organization

```
~/.dotfiles/
├── config/           # Unix configs (symlinked in WSL2)
├── runcom/           # Shell configs (WSL2 only)
├── install/
│   ├── Brewfile      # macOS/Linux packages
│   ├── npmfile       # Node packages (all platforms)
│   └── windows/
│       ├── setup.ps1              # Windows setup script
│       ├── winget-packages.txt    # Windows native apps
│       └── README.md              # This file
```

## Accessing Files Between Windows and WSL2

### From Windows → WSL2
WSL2 filesystems are accessible at:
```
\\wsl$\Ubuntu\home\<username>\.dotfiles
```

### From WSL2 → Windows
Windows drives are mounted at:
```bash
/mnt/c/Users/<username>/
/mnt/d/
```

## Tips

1. **Use Windows Terminal** - Best terminal for Windows + WSL2
2. **VS Code Remote-WSL** - Edit WSL2 files from VS Code on Windows
3. **Git in WSL2** - Use git from WSL2, not Windows Git, for consistency
4. **Symbolic Links** - Keep dotfiles in WSL2, don't try to symlink across Windows/WSL2 boundary

## Troubleshooting

### WSL2 won't start
```powershell
# Run as Administrator
wsl --update
wsl --shutdown
wsl
```

### Homebrew not found in WSL2
```bash
# Add to ~/.zshrc or ~/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

### Can't access Windows files from WSL2
Windows drives are at `/mnt/c/`, `/mnt/d/`, etc.

## Platform Detection

The Makefile automatically detects your platform:
- `make` on macOS → runs `macos` target
- `make` on Linux → runs `linux` target
- `make` on WSL2 → runs `wsl` target

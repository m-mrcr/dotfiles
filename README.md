# .files

These are my dotfiles. Take anything you want, but at your own risk.

Supports **macOS**, **Linux**, and **Windows (via WSL2)**.

## Highlights

- Minimal efforts to install everything, using a [Makefile](./Makefile)
- Cross-platform support: macOS, Linux, and Windows (WSL2) - see [PLATFORM_SUPPORT.md](./PLATFORM_SUPPORT.md)
- Mostly based around Homebrew, Caskroom and Node.js, Zsh + GNU Utils
- Fast and colored prompt
- Updated macOS defaults
- Well-organized and easy to customize
- **Comprehensive test suite** with 100+ tests - see [TESTING.md](./TESTING.md)
- The installation and runcom setup is
  [tested weekly on real Ubuntu and macOS machines](https://github.com/m-mrcr/dotfiles/actions)
  (Ventura/13, Sonoma/14, Sequoia/15) using [a GitHub Action](./.github/workflows/dotfiles-installation.yml)
- Supports both Apple Silicon (M-Series) and Intel chips

## Packages Overview

- [Homebrew](https://brew.sh) (packages: [Brewfile](./install/Brewfile))
- [homebrew-cask](https://github.com/Homebrew/homebrew-cask) (packages: [Caskfile](./install/Caskfile))
- [Mac App Store](https://apps.apple.com) (apps: [Masfile](./install/Masfile))
- [Node.js + npm LTS](https://nodejs.org/en/download/) (packages: [npmfile](./install/npmfile))
- [Neovim](https://neovim.io) configuration (submodule: [nvim-config](https://github.com/m-mrcr/nvim-config))
- Latest Git, Zsh, Python, GNU coreutils, curl, Ruby
- `$EDITOR` is [GNU nano](https://www.nano-editor.org) (`$VISUAL` is `code` and Git `core.editor` is `code --wait`)

## Installation

### macOS

1. Run system updates and install the Xcode Command Line Tools (provides `git` and `make`):
   ```bash
   sudo softwareupdate -i -a
   xcode-select --install
   ```
2. Grab the repo, either via the remote installer…
   ```bash
   bash -c "`curl -fsSL https://raw.githubusercontent.com/m-mrcr/dotfiles/main/remote-install.sh`"
   ```
   (If `~/.dotfiles` already exists, remove or rename it before running the installer.)
   …or by cloning directly:
   ```bash
   git clone --recurse-submodules https://github.com/m-mrcr/dotfiles.git ~/.dotfiles
   ```
   > **Note:** The `--recurse-submodules` flag automatically initializes the Neovim configuration submodule.
   > If you cloned without this flag, run `cd ~/.dotfiles && git submodule update --init --recursive`

3. Install everything and link configs:
   ```bash
   cd ~/.dotfiles
   make            # `make macos` does the same explicitly
   ```
   `make` is idempotent and executes the Homebrew, Cask, MAS, npm, cargo, stow, duti, and Bun steps.

### Linux

1. Install git and make:
   ```bash
   sudo apt-get update
   sudo apt-get install -y git build-essential
   ```

2. Clone the repo:
   ```bash
   git clone --recurse-submodules <your-repo-url> ~/.dotfiles
   cd ~/.dotfiles
   ```

3. Run the setup:
   ```bash
   make            # Automatically detects Linux
   ```

### Windows (WSL2)

For Windows, we use a hybrid approach:
- **Native Windows apps** (VS Code, browsers, etc.) install via `winget`
- **Development tools** (git, shell, etc.) run in WSL2

See the detailed guide: [install/windows/README.md](./install/windows/README.md)

**Quick start:**
1. Open PowerShell as Administrator on Windows
2. Navigate to `install\windows` and run `.\setup.ps1`
3. Open WSL2 (Ubuntu) and clone this repo
4. Run `make` inside WSL2

### Fresh macOS Setup (after erase)

- After onboarding, sign into iCloud and the App Store so the MAS bundle can authenticate.
- Follow the installation steps above; keep the App Store open while `make` runs.
- Useful reruns:
  - `make packages` – Homebrew, Cask, MAS, npm, cargo bundles.
  - `make mas-apps` – just the Mac App Store apps (`install/Masfile`).
  - `make link` – re-stow configs without reinstalling packages.
- Post-install checks:
  ```bash
  make test      # exercises helper scripts via Bats
  dot update     # refresh package managers on the new machine
  ```

## Post-Installation

1. Set your Git credentials:

```sh
git config --global user.name "your name"
git config --global user.email "your@email.com"
git config --global github.user "your-github-username"
```

2. Set macOS [Dock items](./macos/dock.sh) and [system defaults](./macos/defaults.sh):

```sh
dot dock
dot macos
```

3. Populate this file with tokens (example: `export GITHUB_TOKEN=abc`):

```sh
touch ~/.dotfiles/system/.exports
```

## Neovim Configuration

The Neovim configuration is managed as a separate git submodule at `config/nvim`, allowing it to be:
- Maintained independently in its own repository ([m-mrcr/nvim-config](https://github.com/m-mrcr/nvim-config))
- Shared across different systems (macOS and Linux)
- Updated independently from the dotfiles

### Updating the Neovim config

To update the Neovim configuration to the latest version:

```bash
cd ~/.dotfiles/config/nvim
git pull origin main
cd ~/.dotfiles
git add config/nvim
git commit -m "Update nvim config"
```

### Working on the Neovim config

The submodule is a full git repository, so you can work on it directly:

```bash
cd ~/.dotfiles/config/nvim
# Make changes, commit, push
git add .
git commit -m "Your changes"
git push origin main
```

Then update the submodule pointer in your dotfiles:

```bash
cd ~/.dotfiles
git add config/nvim
git commit -m "Update nvim config submodule"
```

## The `dot` command

```
$ dot help
Usage: dot <command>

Commands:
   clean            Clean up caches (brew, cargo, gem, pip)
   dock             Apply macOS Dock settings
   edit             Open dotfiles in IDE ($VISUAL) and Git GUI ($VISUAL_GIT)
   help             This help message
   macos            Apply macOS system defaults
   test             Run tests
   update           Update packages and pkg managers (brew, casks, cargo, pip3, npm, gems, macOS)
```

## Customize

To customize the dotfiles to your likings, fork it and [be the king of your castle!](https://www.webpro.nl/articles/getting-started-with-dotfiles)

## Credits

Many thanks to the [dotfiles community](https://dotfiles.github.io).

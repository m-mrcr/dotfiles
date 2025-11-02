# .files

These are my dotfiles. Take anything you want, but at your own risk.

It mainly targets macOS systems (should install on e.g. Ubuntu as well for many tools, config and aliases etc).

## Highlights

- Minimal efforts to install everything, using a [Makefile](./Makefile)
- Mostly based around Homebrew, Caskroom and Node.js, latest Bash + GNU Utils
- Fast and colored prompt
- Updated macOS defaults
- Well-organized and easy to customize
- The installation and runcom setup is
  [tested weekly on real Ubuntu and macOS machines](https://github.com/m-mrcr/dotfiles/actions)
  (Ventura/13, Sonomo/14, Sequoia/15) using [a GitHub Action](./.github/workflows/dotfiles-installation.yml)
- Supports both Apple Silicon (M-Series) and Intel chips

## Packages Overview

- [Homebrew](https://brew.sh) (packages: [Brewfile](./install/Brewfile))
- [homebrew-cask](https://github.com/Homebrew/homebrew-cask) (packages: [Caskfile](./install/Caskfile))
- [Mac App Store](https://apps.apple.com) (apps: [Masfile](./install/Masfile))
- [Node.js + npm LTS](https://nodejs.org/en/download/) (packages: [npmfile](./install/npmfile))
- Latest Git, Bash, Python, GNU coreutils, curl, Ruby
- `$EDITOR` is [GNU nano](https://www.nano-editor.org) (`$VISUAL` is `code` and Git `core.editor` is `code --wait`)

## Installation

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
   git clone https://github.com/m-mrcr/dotfiles.git ~/.dotfiles
   ```
3. Install everything and link configs:
   ```bash
   cd ~/.dotfiles
   make            # `make macos` does the same explicitly
   ```
   `make` is idempotent and executes the Homebrew, Cask, MAS, npm, cargo, stow, duti, and Bun steps.

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

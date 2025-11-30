DOTFILES_DIR := $(CURDIR)
OS := $(shell bin/is-supported bin/is-macos macos linux)
HOMEBREW_PREFIX := $(shell bin/is-supported bin/is-macos $(shell bin/is-supported bin/is-arm64 /opt/homebrew /usr/local) /home/linuxbrew/.linuxbrew)
export N_PREFIX = $(HOME)/.n
PATH := $(HOMEBREW_PREFIX)/bin:$(DOTFILES_DIR)/bin:$(N_PREFIX)/bin:$(PATH)
export PATH
SHELL := /bin/bash
SHELLS := /private/etc/shells
BIN := $(HOMEBREW_PREFIX)/bin
export XDG_CONFIG_HOME = $(HOME)/.config
export STOW_DIR = $(DOTFILES_DIR)
export ACCEPT_EULA=Y

.PHONY: test

all: $(OS)

macos: sudo core-macos packages link duti bun

linux: core-linux linux-packages link bun

wsl: core-linux linux-packages wsl-setup link bun

core-macos: brew git npm

core-linux:
	sudo apt-get update
	sudo apt-get upgrade -y
	sudo apt-get dist-upgrade -f
	sudo apt-get install -y build-essential curl wget git zsh stow

stow-macos: brew
	is-executable stow || brew install stow

stow-linux: core-linux
	is-executable stow || apt-get -y install stow

sudo:
ifndef GITHUB_ACTION
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
endif

packages: brew-packages cask-apps mas-apps node-packages rust-packages

submodules:
	git submodule update --init --recursive

link: stow-$(OS) submodules
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then \
		mv -v $(HOME)/$$FILE{,.bak}; fi; done
	mkdir -p "$(XDG_CONFIG_HOME)"
	stow -t "$(HOME)" runcom
	stow -t "$(XDG_CONFIG_HOME)" config
	mkdir -p $(HOME)/.local/runtime
	chmod 700 $(HOME)/.local/runtime

unlink: stow-$(OS)
	stow --delete -t "$(HOME)" runcom
	stow --delete -t "$(XDG_CONFIG_HOME)" config
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE.bak ]; then \
		mv -v $(HOME)/$$FILE.bak $(HOME)/$${FILE%%.bak}; fi; done

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

git: brew
	brew install git git-extras

npm: brew-packages
	n install lts

brew-packages: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile || true

cask-apps: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile || true

mas-apps: brew-packages
	brew bundle --file=$(DOTFILES_DIR)/install/Masfile || true

vscode-extensions: cask-apps
	for EXT in $$(cat install/Codefile); do code --install-extension $$EXT; done

node-packages: npm
	$(N_PREFIX)/bin/npm install --force --location global $(shell cat install/npmfile)

rust-packages: brew-packages
	cargo install $(shell cat install/Rustfile)

duti:
	duti -v $(DOTFILES_DIR)/install/duti

bun:
  curl -fsSL https://bun.sh/install | bash

linux-packages: brew-packages
	# Homebrew for Linux handles most packages
	# Install additional Linux-specific packages via apt if needed
	@if [ -f $(DOTFILES_DIR)/install/Aptfile ]; then \
		sudo apt-get install -y $$(cat $(DOTFILES_DIR)/install/Aptfile); \
	fi

wsl-setup:
	# WSL-specific setup
	@echo "Setting up WSL-specific configuration..."
	# Install wslu for WSL utilities (wslview, wslpath, etc.)
	@if ! is-executable wslview; then \
		sudo apt-get install -y wslu; \
	fi
	# Install xclip or wl-clipboard for clipboard support
	@if ! is-executable xclip && ! is-executable wl-copy; then \
		sudo apt-get install -y xclip; \
	fi
	@echo "WSL setup complete!"

test:
	bats test

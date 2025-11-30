#!/usr/bin/env bats

# Symlink Verification Tests
# Verifies that symlinks are created correctly after running 'make link'

setup() {
	export XDG_CONFIG_HOME="${HOME}/.config"
}

@test "config directory exists" {
	[ -d "$XDG_CONFIG_HOME" ]
}

@test "nvim config is symlinked correctly" {
	if [ -e "$XDG_CONFIG_HOME/nvim" ]; then
		[ -L "$XDG_CONFIG_HOME/nvim" ]
		# Should point to dotfiles
		target=$(readlink "$XDG_CONFIG_HOME/nvim")
		[[ "$target" =~ dotfiles ]]
	else
		skip "nvim config not yet linked"
	fi
}

@test "git config is symlinked correctly" {
	if [ -e "$XDG_CONFIG_HOME/git" ]; then
		[ -L "$XDG_CONFIG_HOME/git" ]
		target=$(readlink "$XDG_CONFIG_HOME/git")
		[[ "$target" =~ dotfiles ]]
	else
		skip "git config not yet linked"
	fi
}

@test "starship config is symlinked correctly" {
	if [ -e "$XDG_CONFIG_HOME/starship.toml" ]; then
		[ -L "$XDG_CONFIG_HOME/starship.toml" ]
		target=$(readlink "$XDG_CONFIG_HOME/starship.toml")
		[[ "$target" =~ dotfiles ]]
	else
		skip "starship config not yet linked"
	fi
}

@test "zshrc is symlinked correctly" {
	if [ -e "$HOME/.zshrc" ]; then
		[ -L "$HOME/.zshrc" ]
		target=$(readlink "$HOME/.zshrc")
		[[ "$target" =~ dotfiles ]]
	else
		skip "zshrc not yet linked"
	fi
}

@test "zprofile is symlinked correctly" {
	if [ -e "$HOME/.zprofile" ]; then
		[ -L "$HOME/.zprofile" ]
		target=$(readlink "$HOME/.zprofile")
		[[ "$target" =~ dotfiles ]]
	else
		skip "zprofile not yet linked"
	fi
}

@test "inputrc is symlinked correctly" {
	if [ -e "$HOME/.inputrc" ]; then
		[ -L "$HOME/.inputrc" ]
		target=$(readlink "$HOME/.inputrc")
		[[ "$target" =~ dotfiles ]]
	else
		skip "inputrc not yet linked"
	fi
}

@test "no broken symlinks in config directory" {
	if [ -d "$XDG_CONFIG_HOME" ]; then
		broken_links=$(find "$XDG_CONFIG_HOME" -maxdepth 1 -type l ! -exec test -e {} \; -print 2>/dev/null | wc -l)
		[ "$broken_links" -eq 0 ]
	fi
}

@test "no broken symlinks in home directory (dotfiles)" {
	# Find broken symlinks that point to dotfiles
	broken_count=0
	for link in "$HOME"/.*; do
		if [ -L "$link" ] && [ ! -e "$link" ]; then
			target=$(readlink "$link")
			if [[ "$target" =~ "dotfiles" ]]; then
				broken_count=$((broken_count + 1))
			fi
		fi
	done
	[ "$broken_count" -eq 0 ]
}

@test "stow-local-ignore is configured correctly" {
	[ -f "config/.stow-local-ignore" ]

	# themes should be ignored
	grep -q "^themes$" config/.stow-local-ignore
}

@test "nvim should NOT be in stow-local-ignore" {
	if [ -f "config/.stow-local-ignore" ]; then
		! grep -q "^nvim$" config/.stow-local-ignore
	fi
}

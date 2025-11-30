# Dotfiles Test Suite

Comprehensive testing for cross-platform dotfiles setup.

## Test Categories

### 1. Bin Scripts (`bin.bats`)
Tests for utility scripts in the `bin/` directory:
- `dot` command functionality
- `json` formatter
- `is-executable` detection
- `is-supported` command validation

### 2. Shell Functions (`function.bats`)
Tests for shell functions in `system/.function`:
- Variable getter
- Calculator function
- Line manipulation
- Duplicate/unique line filtering

### 3. Platform Detection (`platform.bats`)
Tests for OS and environment detection:
- macOS detection (`is-macos`)
- WSL2 detection (`is-wsl`)
- Windows detection (`is-windows`)
- ARM64 architecture detection (`is-arm64`)
- Makefile OS variable correctness
- Homebrew prefix configuration

### 4. Symlink Verification (`symlinks.bats`)
Validates symlink creation after `make link`:
- Config directory existence
- Neovim config symlink
- Git config symlink
- Starship config symlink
- Shell dotfiles (`.zshrc`, `.zprofile`, `.inputrc`)
- No broken symlinks
- Stow ignore file configuration

### 5. Package Installation (`packages.bats`)
Verifies package installations:
- Package list file validity
- Homebrew installation (macOS/Linux)
- Core tools (Git, Stow, Zsh)
- Node.js and npm
- Neovim
- Starship prompt
- Rust toolchain
- Platform-specific packages (mas, Cask, winget)

### 6. Cross-Platform Compatibility (`compatibility.bats`)
Ensures configs work across all platforms:
- Portable shebangs (`#!/usr/bin/env`)
- No hardcoded paths
- XDG_CONFIG_HOME usage
- No platform-specific commands in shared configs
- Shell compatibility (bash/zsh)
- Unix line endings (LF, not CRLF)
- Config file validity (YAML/TOML)
- No secrets in configs
- Proper submodule configuration

### 7. Makefile Targets (`makefile.bats`)
Tests Makefile functionality:
- Required variables defined
- OS detection
- All main targets exist
- Platform-specific targets (macOS, Linux, WSL)
- Stow integration
- Package management targets
- Proper error handling
- Syntax validation

## Running Tests

### Run All Tests
```bash
# Using the test runner (recommended)
./test/run-tests.sh

# Or using make
make test

# Or using bats directly
bats test/
```

### Run Specific Test Suite
```bash
bats test/platform.bats
bats test/symlinks.bats
bats test/packages.bats
```

### Run Single Test
```bash
bats test/platform.bats --filter "is-macos"
```

### Verbose Output
```bash
bats -p test/  # Pretty print
bats --verbose test/
```

## Test Output

The test runner provides colored output:
- ✓ Green = Passed
- ⊘ Yellow = Skipped
- ✗ Red = Failed

Example:
```
================================
  Dotfiles Test Suite
================================

Platform: macOS
Working Directory: /Users/you/.dotfiles

✓ bats found: Bats 1.10.0

Running: Platform Detection
----------------------------------------
✓ Passed: 11
⊘ Skipped: 2
```

## Writing New Tests

Tests use [Bats](https://github.com/bats-core/bats-core) (Bash Automated Testing System).

### Basic Test Structure
```bash
#!/usr/bin/env bats

@test "description of test" {
	run command_to_test
	[ "$status" -eq 0 ]
	[[ "$output" =~ "expected output" ]]
}
```

### Common Patterns

**Check file exists:**
```bash
@test "config file exists" {
	[ -f "path/to/file" ]
}
```

**Check command succeeds:**
```bash
@test "command works" {
	run some_command
	[ "$status" -eq 0 ]
}
```

**Skip test conditionally:**
```bash
@test "macOS only test" {
	if ! bin/is-macos; then
		skip "Not on macOS"
	fi
	# test code here
}
```

**Test output contains text:**
```bash
@test "output check" {
	run echo "hello world"
	[[ "$output" =~ "hello" ]]
}
```

## Adding New Test Suites

1. Create new file in `test/` directory: `test/mytest.bats`
2. Add shebang: `#!/usr/bin/env bats`
3. Write tests using `@test` syntax
4. Add to `TEST_SUITES` array in `test/run-tests.sh`
5. Run tests to verify

## CI Integration

Tests run automatically on:
- Every push to main branch
- Every pull request
- Weekly scheduled runs

See `.github/workflows/` for CI configuration.

## Test Coverage

Current test coverage includes:
- **Platform detection**: 100%
- **Core scripts**: 100%
- **Symlink creation**: ~90%
- **Package installation**: ~80%
- **Makefile targets**: ~95%
- **Cross-platform compatibility**: ~85%

## Troubleshooting

### "bats: command not found"
Install bats:
```bash
# macOS
brew install bats-core

# Linux
sudo apt-get install bats

# Manual
git clone https://github.com/bats-core/bats-core.git
cd bats-core
./install.sh /usr/local
```

### Tests fail after fresh install
Some tests expect certain packages to be installed. Run `make` first:
```bash
make
make test
```

### Skipped tests
Tests are skipped when:
- Running on a different platform (e.g., macOS-only test on Linux)
- Dependencies not yet installed
- Features not yet configured

This is normal and expected.

### Failed symlink tests
If symlink tests fail:
1. Run `make link` to create symlinks
2. Check for conflicting files
3. Run `make unlink` then `make link` to recreate

## Best Practices

1. **Keep tests fast** - Use `skip` for expensive tests that aren't critical
2. **Test one thing** - Each test should verify a single behavior
3. **Use descriptive names** - Test names should clearly state what they check
4. **Handle platform differences** - Use `skip` for platform-specific tests
5. **Don't modify state** - Tests should be read-only when possible
6. **Clean up after yourself** - If a test creates files, remove them

## Resources

- [Bats Documentation](https://bats-core.readthedocs.io/)
- [Bats GitHub](https://github.com/bats-core/bats-core)
- [Writing Good Tests](https://github.com/bats-core/bats-core#writing-tests)

#!/usr/bin/env bash

# Comprehensive Test Runner for Dotfiles
# Runs all test suites with proper reporting

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}  Dotfiles Test Suite${NC}"
echo -e "${BLUE}================================${NC}"
echo ""

# Detect platform
if [[ "$OSTYPE" =~ ^darwin ]]; then
    PLATFORM="macOS"
elif [[ -f /proc/version ]] && grep -qi microsoft /proc/version; then
    PLATFORM="WSL2"
else
    PLATFORM="Linux"
fi

echo -e "${YELLOW}Platform:${NC} $PLATFORM"
echo -e "${YELLOW}Working Directory:${NC} $(pwd)"
echo ""

# Check if bats is installed
if ! command -v bats &> /dev/null; then
    echo -e "${RED}✗ bats is not installed${NC}"
    echo -e "${YELLOW}Install bats:${NC}"
    echo "  macOS:  brew install bats-core"
    echo "  Linux:  sudo apt-get install bats"
    echo "  Manual: git clone https://github.com/bats-core/bats-core.git && cd bats-core && ./install.sh /usr/local"
    exit 1
fi

echo -e "${GREEN}✓ bats found:${NC} $(bats --version)"
echo ""

# Test suites to run
TEST_SUITES=(
    "test/bin.bats:Bin Scripts"
    "test/function.bats:Shell Functions"
    "test/platform.bats:Platform Detection"
    "test/symlinks.bats:Symlink Verification"
    "test/packages.bats:Package Installation"
    "test/compatibility.bats:Cross-Platform Compatibility"
    "test/makefile.bats:Makefile Targets"
)

TOTAL_PASSED=0
TOTAL_FAILED=0
TOTAL_SKIPPED=0
FAILED_SUITES=()

# Run each test suite
for suite_info in "${TEST_SUITES[@]}"; do
    IFS=':' read -r suite_file suite_name <<< "$suite_info"

    if [ ! -f "$suite_file" ]; then
        echo -e "${YELLOW}⊘ Skipping $suite_name (file not found)${NC}"
        continue
    fi

    echo -e "${BLUE}Running:${NC} $suite_name"
    echo "----------------------------------------"

    # Run the test and capture results
    if bats --formatter tap "$suite_file" > /tmp/bats-output.txt 2>&1; then
        # Count results
        passed=$(grep "^ok" /tmp/bats-output.txt | wc -l | xargs)
        skipped=$(grep "# skip" /tmp/bats-output.txt | wc -l | xargs)

        TOTAL_PASSED=$((TOTAL_PASSED + passed))
        TOTAL_SKIPPED=$((TOTAL_SKIPPED + skipped))

        echo -e "${GREEN}✓ Passed:${NC} $passed"
        if [ "$skipped" -gt 0 ]; then
            echo -e "${YELLOW}⊘ Skipped:${NC} $skipped"
        fi
    else
        # Test suite failed
        failed=$(grep "^not ok" /tmp/bats-output.txt | wc -l | xargs)
        TOTAL_FAILED=$((TOTAL_FAILED + failed))
        FAILED_SUITES+=("$suite_name")

        echo -e "${RED}✗ Failed:${NC} $failed"
        echo ""
        echo -e "${RED}Failed tests:${NC}"
        grep "^not ok" /tmp/bats-output.txt || true
    fi

    echo ""
done

# Summary
echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}  Test Summary${NC}"
echo -e "${BLUE}================================${NC}"
echo -e "${GREEN}Passed:${NC}  $TOTAL_PASSED"
echo -e "${YELLOW}Skipped:${NC} $TOTAL_SKIPPED"
echo -e "${RED}Failed:${NC}  $TOTAL_FAILED"

if [ "$TOTAL_FAILED" -gt 0 ]; then
    echo ""
    echo -e "${RED}Failed test suites:${NC}"
    for suite in "${FAILED_SUITES[@]}"; do
        echo -e "  ${RED}✗${NC} $suite"
    done
    echo ""
    exit 1
else
    echo ""
    echo -e "${GREEN}✓ All tests passed!${NC}"
    exit 0
fi

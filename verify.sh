#!/bin/bash

# Qwen Code CLI Plugin Verification Script
# This script verifies that all plugin components are properly installed
# Author: Converted from original by glittercowboy for Qwen Code CLI

set -e  # Exit immediately if a command exits with a non-zero status
set -u  # Exit on undefined variable

# Detect OS type for compatibility
detect_os() {
    case "$(uname -s)" in
        Linux*)     OS=Linux;;
        Darwin*)    OS=macOS;;
        CYGWIN*|MINGW*|MSYS*) OS=Windows;;
        *)          OS="UNKNOWN:${unameOut}"
    esac
    echo "$OS"
}

# Colors for output (with compatibility for different systems)
if [ -t 1 ]; then  # Check if terminal supports colors
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    NC='\033[0m' # No Color
else
    # No color support for non-interactive environments
    RED=''
    GREEN=''
    YELLOW=''
    BLUE=''
    NC=''
fi

# Print colored output
print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}  Qwen Code CLI Plugin with     ${NC}"
    echo -e "${BLUE}      TOML Commands             ${NC}"
    echo -e "${BLUE}      Plugin Verification       ${NC}"
    echo -e "${BLUE}================================${NC}"
    echo
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${BLUE}→ $1${NC}"
}

# Verify installation
verify_installation() {
    print_info "Verifying plugin installation..."
    echo

    # Check commands
    print_info "Checking commands..."
    COMMANDS_DIR="$HOME/.qwen/commands"
    if [ -d "$COMMANDS_DIR" ]; then
        # Check specific plugin commands and count missing ones
        PLUGIN_COMMANDS=(
            "add-to-todos.toml" "check-todos.toml" "create-prompt.toml"
            "run-prompt.toml" "whats-next.toml"
        )

        MISSING_COMMANDS=0
        FOUND_COMMANDS=0

        print_info "  Checking specific plugin commands..."
        for cmd in "${PLUGIN_COMMANDS[@]}"; do
            if [ -f "$COMMANDS_DIR/$cmd" ]; then
                print_success "  Found: $cmd"
                ((FOUND_COMMANDS++))
            else
                print_error "  Missing: $cmd"
                ((MISSING_COMMANDS++))
            fi
        done

        # Count total TOML files in commands directory
        TOTAL_TOML_COUNT=$(find "$COMMANDS_DIR" -name "*.toml" -type f 2>/dev/null | wc -l)
        print_info "  Total TOML files in commands directory: $TOTAL_TOML_COUNT"

        if [ "$MISSING_COMMANDS" -gt 0 ]; then
            print_error "Plugin is not fully installed: $MISSING_COMMANDS command(s) missing"
            print_warning "Only $FOUND_COMMANDS out of 5 plugin commands are available"
            return 1  # Return error code to indicate incomplete installation
        else
            print_success "All 5 plugin commands are available"
        fi
    else
        print_error "Commands directory does not exist at $COMMANDS_DIR"
        print_error "Plugin is not installed or installation is corrupted"
        return 1  # Return error code to indicate no installation
    fi

    echo
}

# Show summary based on verification results
show_summary() {
    local verification_result=$1
    print_info "Plugin verification complete!"
    echo

    if [ $verification_result -eq 0 ]; then
        print_success "The Qwen Plugin with TOML commands is fully installed and ready to use."
        print_info "You can use commands like /create-prompt, /add-to-todos, /run-prompt, etc. in Qwen Code CLI."
    else
        print_error "The Qwen Plugin with TOML commands is not fully installed or missing."
        print_info "Please reinstall the plugin using ./install.sh"
        exit 1
    fi
}

# Main execution
main() {
    print_header
    if verify_installation; then
        show_summary 0
    else
        show_summary 1
    fi
}

main "$@"
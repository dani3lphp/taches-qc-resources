#!/bin/bash

# Qwen Code CLI Plugin Uninstaller
# This script removes the Qwen Code CLI Plugin with TOML commands
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
    echo -e "${BLUE}      Plugin Uninstaller        ${NC}"
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

# Check if running as root
check_root() {
    if [ "$EUID" -eq 0 ] || [ "$(id -u)" -eq 0 ]; then
        print_error "This script should not be run as root"
        exit 1
    fi
}

# Remove plugin components
uninstall_plugin() {
    print_info "Uninstalling Qwen Code CLI Plugin with TOML commands..."

    # Define plugin-specific command names to remove (based on the plugin)
    PLUGIN_COMMANDS=(
        "add-to-todos" "check-todos" "create-prompt" "run-prompt" "whats-next"
    )

    # Remove plugin-specific commands
    for cmd in "${PLUGIN_COMMANDS[@]}"; do
        if [ -f "$HOME/.qwen/commands/$cmd.toml" ]; then
            rm -f "$HOME/.qwen/commands/$cmd.toml"
            print_success "Removed command: /$cmd"
        else
            print_warning "Command not found: $HOME/.qwen/commands/$cmd.toml"
        fi
    done

    # Remove any remaining .toml files that might have been copied from this plugin
    if [ -d "$HOME/.qwen/commands" ]; then
        find "$HOME/.qwen/commands" -name "*.toml" -type f -delete 2>/dev/null || true
    fi
}

# Verify removal and remove commands folder if empty
verify_removal() {
    print_info "Verifying removal..."

    if [ -d "$HOME/.qwen/commands" ]; then
        REMAINING_COMMANDS=$(find "$HOME/.qwen/commands" -name "*.toml" 2>/dev/null | wc -l)
        TOTAL_COMMANDS=$(find "$HOME/.qwen/commands" -mindepth 1 -type f 2>/dev/null | wc -l)

        if [ "$REMAINING_COMMANDS" -eq 0 ] && [ "$TOTAL_COMMANDS" -eq 0 ]; then
            # No plugin files remain, remove the empty directory
            if rmdir "$HOME/.qwen/commands" 2>/dev/null; then
                print_success "Commands directory removed (was empty)"
            else
                print_warning "Could not remove commands directory"
            fi
        elif [ "$REMAINING_COMMANDS" -eq 0 ]; then
            print_success "All plugin components successfully removed"
            print_info "Commands directory kept (contains other files)"
        else
            print_warning "Some components remain in ~/.qwen/commands ($REMAINING_COMMANDS .toml files)"
            print_warning "These may be other plugins or custom files"
        fi
    else
        print_success "Commands directory does not exist, already removed"
    fi
}

# Show usage information
show_usage() {
    echo -e "${YELLOW}Usage:${NC}"
    echo "  ./uninstall.sh"
    echo
    echo -e "${YELLOW}Description:${NC}"
    echo "  Removes all Qwen Code CLI Plugin with TOML commands"
    echo "  This will remove only the plugin-specific commands."
    echo "  Other files in ~/.qwen/ will remain untouched."
    echo
}

# Parse command line arguments
for arg in "$@"; do
    case $arg in
        --help)
            show_usage
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $arg${NC}"
            show_usage
            exit 1
            ;;
    esac
done

# Confirmation prompt
print_warning "This will remove the Qwen Code CLI Plugin with TOML commands from your system."
echo -n "Are you sure you want to continue? (yes/no): "
read -r response

if [[ ! "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    print_info "Uninstallation cancelled."
    exit 0
fi

# Main execution
main() {
    print_header

    check_root
    uninstall_plugin
    verify_removal

    echo
    print_success "Uninstallation completed!"
    echo
    print_info "Qwen Code CLI Plugin with TOML commands has been removed from your system."
    print_info "Your ~/.qwen/ directory may still contain other plugins or custom files."
}

main "$@"
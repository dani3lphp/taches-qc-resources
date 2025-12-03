#!/bin/bash

# Qwen Code CLI Plugin Installer
# This script installs the Qwen Code CLI Plugin with TOML commands
# Author: Converted from original by glittercowboy for Qwen Code CLI
# Date: December 2025

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
    echo -e "${BLUE}        Plugin Installer        ${NC}"
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

# Check if Qwen directories exist, create if they don't
check_and_create_qwen_dirs() {
    print_info "Checking Qwen directories..."

    QWEN_HOME="$HOME/.qwen"
    QWEN_COMMANDS="$QWEN_HOME/commands"
    # We don't need skills and agents anymore

    # Create directories if they don't exist
    if [ ! -d "$QWEN_HOME" ]; then
        print_info "Creating Qwen home directory: $QWEN_HOME"
        mkdir -p "$QWEN_HOME"
        print_success "Created $QWEN_HOME"
    else
        print_success "Qwen home directory exists: $QWEN_HOME"
    fi

    if [ ! -d "$QWEN_COMMANDS" ]; then
        print_info "Creating commands directory: $QWEN_COMMANDS"
        mkdir -p "$QWEN_COMMANDS"
        print_success "Created $QWEN_COMMANDS"
    else
        print_success "Commands directory exists: $QWEN_COMMANDS"
    fi
}

# Install plugin components
install_plugin() {
    print_info "Installing Qwen Code CLI Plugin with TOML commands..."

    # Get the directory where this script is located
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    PLUGIN_DIR="$SCRIPT_DIR"

    print_info "Plugin source directory: $PLUGIN_DIR"

    # Copy all .toml files from subdirectories to ~/.qwen/commands
    if [ -d "$HOME/.qwen/commands" ]; then
        print_info "Installing .toml command files..."

        # Create temporary directory to collect all .toml files
        # Use different approaches for different systems
        if command -v mktemp >/dev/null 2>&1; then
            TEMP_DIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'qwen-plugin' 2>/dev/null)
        else
            # Fallback if mktemp is not available
            TEMP_DIR="/tmp/qwen-plugin-$(date +%s)"
            mkdir -p "$TEMP_DIR"
        fi

        # Find and copy all .toml files from subdirectories
        find "$PLUGIN_DIR" -name "*.toml" -type f -exec cp {} "$TEMP_DIR/" \;

        # Copy all collected .toml files to ~/.qwen/commands
        cp "$TEMP_DIR"/*.toml "$HOME/.qwen/commands/" 2>/dev/null || true

        # Clean up temporary directory
        if [ -d "$TEMP_DIR" ]; then
            rm -rf "$TEMP_DIR"
        fi

        print_success "TOML commands installed successfully"
    else
        print_warning "Commands directory not found in ~/.qwen/"
    fi
}

# Verify installation
verify_installation() {
    print_info "Verifying installation..."

    # Count TOML files for commands
    if [ -d "$HOME/.qwen/commands" ]; then
        COMMANDS_TOML_COUNT=$(find "$HOME/.qwen/commands" -type f -name "*.toml" 2>/dev/null | wc -l)
        # Count other file types too
        COMMANDS_OTHER_COUNT=$(find "$HOME/.qwen/commands" -type f -not -name "*.toml" 2>/dev/null | wc -l)
        TOTAL_COMMANDS=$((COMMANDS_TOML_COUNT + COMMANDS_OTHER_COUNT))

        print_success "Installation verified:"
        print_success "  - $TOTAL_COMMANDS total commands installed ($COMMANDS_TOML_COUNT .toml, $COMMANDS_OTHER_COUNT other)"
    else
        COMMANDS_TOML_COUNT=0
        COMMANDS_OTHER_COUNT=0
        TOTAL_COMMANDS=0
        print_error "Commands directory does not exist at ~/.qwen/commands"
    fi

    echo
    print_info "Plugin installed successfully in $HOME/.qwen/"
}

# Create backup of existing plugin if it exists
create_backup() {
    if [ -d "$HOME/.qwen/commands" ]; then
        print_info "Creating backup of existing plugin (if any)..."
        BACKUP_DIR="$HOME/.qwen-backup-$(date +%Y%m%d_%H%M%S)"

        if [ -d "$HOME/.qwen" ]; then
            cp -r "$HOME/.qwen" "$BACKUP_DIR"
            print_success "Backup created at $BACKUP_DIR"
        fi
    fi
}

# Show usage information
show_usage() {
    echo -e "${YELLOW}Usage:${NC}"
    echo "  ./install.sh [OPTIONS]"
    echo
    echo -e "${YELLOW}Options:${NC}"
    echo "  --backup    Create backup of existing installation before installing"
    echo "  --help      Show this help message"
    echo
    echo -e "${YELLOW}Examples:${NC}"
    echo "  ./install.sh              Install plugin without backup"
    echo "  ./install.sh --backup     Install plugin with backup"
    echo
}

# Parse command line arguments
BACKUP=false
for arg in "$@"; do
    case $arg in
        --backup)
            BACKUP=true
            ;;
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

# Main execution
main() {
    print_header

    check_root

    if [ "$BACKUP" = true ]; then
        create_backup
    fi

    check_and_create_qwen_dirs
    install_plugin
    verify_installation

    echo
    print_success "Installation completed successfully!"
    echo
    print_info "You can now use the following commands in Qwen Code CLI:"
    echo
    print_info "  /create-prompt      - Create new prompts with structured workflows"
    print_info "  /add-to-todos       - Capture tasks with full context"
    print_info "  /check-todos        - Resume work on captured tasks"
    print_info "  /run-prompt         - Execute saved prompt files"
    print_info "  /whats-next         - Create handoff documents for continuing work"
    echo
    print_info "For more information, see the README.md file in this directory."
    echo
    print_success "Happy building with Qwen Code CLI!"
}

main "$@"
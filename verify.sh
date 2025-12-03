#!/bin/bash

# Verification script for the Prompt Qwen Plugin

set -e  # Exit on any error

PLUGIN_NAME="prompt-qwen-plugin"
PLUGIN_DIR="$HOME/.claude/$PLUGIN_NAME"
COMMANDS_DIR="$HOME/.claude/commands"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

# Function to check if a file exists
check_file() {
    if [ -f "$1" ]; then
        print_status "✓ Found: $1"
        return 0
    else
        print_error "✗ Missing: $1"
        return 1
    fi
}

# Function to check if a directory exists
check_directory() {
    if [ -d "$1" ]; then
        print_status "✓ Found: $1"
        return 0
    else
        print_error "✗ Missing: $1"
        return 1
    fi
}

print_status "Verifying Prompt Qwen Plugin installation..."

# Check plugin directory
check_directory "$PLUGIN_DIR"

# Check command files
check_file "$COMMANDS_DIR/create-prompt.toml"
check_file "$COMMANDS_DIR/run-prompt.toml"
check_file "$COMMANDS_DIR/add-to-todos.toml"
check_file "$COMMANDS_DIR/check-todos.toml"
check_file "$COMMANDS_DIR/whats-next.toml"

# Check for required scripts in plugin directory
check_file "$PLUGIN_DIR/install.sh"
check_file "$PLUGIN_DIR/uninstall.sh"
check_file "$PLUGIN_DIR/verify.sh"

# Check module directories
check_directory "$PLUGIN_DIR/meta-prompting"
check_directory "$PLUGIN_DIR/todo-management"
check_directory "$PLUGIN_DIR/context-handoff"

print_status "Verification completed!"

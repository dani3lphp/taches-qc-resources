# Qwen Code CLI Plugin: TOML Commands

This plugin packages TOML commands created from a Claude Code conversation into a Qwen Code CLI compatible format.

## What's Included

### Commands - Slash commands that expand into structured workflows
- **Meta-Prompting**: Commands for creating and running prompts
  - `/create-prompt` - Create new prompts with structured workflows
  - `/run-prompt` - Execute saved prompt files
- **Todo Management**: Commands for capturing and managing tasks
  - `/add-to-todos` - Capture tasks with full context
  - `/check-todos` - Resume work on captured tasks
- **Context Handoff**: Commands for continuing work in fresh contexts
  - `/whats-next` - Create handoff documents for continuing work

All commands are provided in `.toml` format for use with Qwen Code CLI.

## Installation

### Automatic Installation (Recommended)

Run the included installation script:

```bash
# Make sure the script is executable
chmod +x install.sh

# Install the plugin
./install.sh
```

The installation script will:
- Create necessary directories in `~/.qwen/`
- Copy all `.toml` files from the subdirectories to `~/.qwen/commands/`
- Verify the installation

## Uninstallation

To remove the plugin, use the uninstall script:

```bash
# Make sure the script is executable
chmod +x uninstall.sh

# Uninstall the plugin (with confirmation)
./uninstall.sh
```

## Verification

To verify that the installation was successful:

```bash
# Make sure the script is executable
chmod +x verify.sh

# Verify the installation
./verify.sh
```

## Usage

After installation, simply use any of the slash commands in your Qwen Code CLI environment:

- `/create-prompt` - Generate optimized prompts
- `/add-to-todos` - Capture tasks with full context
- `/check-todos` - Resume work on captured tasks
- `/run-prompt` - Execute saved prompt files
- `/whats-next` - Create handoff documents for continuing work

## Important: Manual Execution Required for /run-prompt

**WARNING**: For the Qwen Code CLI, the `/run-prompt` command should be used manually rather than automatically. The model often fails to run slash commands properly, which can result in:

- Unexpected or incorrect command execution
- Bad output that may be difficult to recover from
- Potential errors in your workflow

### Why Automatic Execution Fails

The Qwen model has limitations when executing slash commands directly. These limitations can cause the model to:

- Misinterpret command parameters
- Execute commands in an unintended sequence
- Generate malformed command syntax

### Recommended Approach

Instead of relying on the model to execute `/run-prompt` automatically:

1. **Manually execute** the `/run-prompt` command in your Qwen Code CLI environment
2. **Review the output** carefully after each execution
3. **Verify the results** before proceeding with subsequent commands
4. **Monitor execution** to catch any potential issues early

This manual approach ensures more reliable execution and reduces the risk of problematic output.

## Plugin Structure

The plugin maintains the following directory structure:

- `meta-prompting/` - Contains meta-prompting commands
  - `create-prompt.toml` - Command to create new prompts
  - `run-prompt.toml` - Command to execute prompts
- `todo-management/` - Contains todo management commands
  - `add-to-todos.toml` - Command to add todos
  - `check-todos.toml` - Command to check todos
- `context-handoff/` - Contains context handoff commands
  - `whats-next.toml` - Command to create handoff documents
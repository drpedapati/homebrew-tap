# Homebrew Tap

Homebrew formulas for IRL (Idempotent Research Loop) tools.

## Installation

```bash
brew tap drpedapati/tap
brew install irl
```

## Available Formulas

| Formula | Description |
|---------|-------------|
| `irl` | CLI for creating IRL research projects with auto-naming |

## Usage

After installation:

```bash
# Interactive mode - prompts for project purpose
irl init

# Direct mode - provide purpose as argument
irl init "ERP correlation analysis"

# Check your environment
irl doctor

# List available templates
irl templates
```

## Updating

```bash
brew update
brew upgrade irl
```

# Homebrew Tap

Homebrew formulas for IRL (Idempotent Research Loop) tools and sciClaw.

## Installation

```bash
brew tap drpedapati/tap
brew install irl
```

## Available Formulas

| Formula | Description |
|---------|-------------|
| `irl` | CLI for creating IRL research projects with auto-naming |
| `sciclaw` | Paired scientist CLI that uses IRL for project lifecycle |
| `sciclaw-docx-review` | Installs `docx-review` binary without colliding with other taps |
| `sciclaw-pubmed-cli` | Installs `pubmed` and `pubmed-cli` binaries without colliding with other taps |
| `sciclaw-quarto` | Installs Quarto CLI on Linux (macOS users should prefer `brew install --cask quarto`) |

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
brew upgrade sciclaw
```

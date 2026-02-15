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
| `docx-review` | Review/edit Word documents with tracked changes from the CLI |
| `pubmed-cli` | PubMed search and citation graph traversal |

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

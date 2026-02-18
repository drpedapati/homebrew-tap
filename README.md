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

## Legacy Migration (versionless installs)

If Homebrew reports legacy version numbers like `64` for companion formulas, run a one-time reinstall:

```bash
brew reinstall drpedapati/tap/sciclaw-docx-review
brew reinstall drpedapati/tap/sciclaw-pubmed-cli
brew reinstall drpedapati/tap/irl
brew reinstall drpedapati/tap/sciclaw-quarto
```

If `docx-review` linking conflicts (because `drpedapati/tools/docx-review` is also installed), run:

```bash
brew unlink docx-review
brew link --overwrite sciclaw-docx-review
```

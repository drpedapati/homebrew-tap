# Homebrew Tap

Primary Homebrew tap for `sciClaw`, `sciClaw-dev`, `irl`, and the `sciclaw-*` companion formulas used by the main sciClaw install.

This tap is intentionally separate from `drpedapati/tools`:
- `drpedapati/tap` installs `sciclaw`, `sciclaw-dev`, `irl`, and `sciclaw-*` companion formulas
- `drpedapati/tools` installs standalone utilities like `docx-review`, `pubmed-cli`, `pdf-form-filler`, and `phi-cleaner`
- deprecated legacy tap: `drpedapati/sciclaw` (users should untap it if still present)

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
| `sciclaw-dev` | Development channel for sciClaw prereleases |
| `sciclaw-docx-review` | Installs `docx-review` binary without colliding with other taps |
| `sciclaw-pubmed-cli` | Installs `pubmed` and `pubmed-cli` binaries without colliding with other taps |
| `sciclaw-quarto` | Installs Quarto CLI on Linux (macOS users should prefer `brew install --cask quarto`) |
| `docx-review` | Legacy convenience formula; prefer `drpedapati/tools/docx-review` for standalone installs |

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

## Relationship To Other Repos

- Website and docs: `https://sciclaw.dev`
- Source repo and releases: `https://github.com/drpedapati/sciclaw`
- Standalone tool tap: `https://github.com/drpedapati/homebrew-tools`
- Deprecated legacy tap: `https://github.com/drpedapati/homebrew-sciclaw`

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

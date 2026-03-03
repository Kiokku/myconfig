# terminal-config

My terminal/dev environment configs:
- Ghostty
- fastfetch
- Zsh (zimfw, zfz, oh-my-posh)
- Git + lazygit
- tmux
- Yazi

## Structure

- `ghostty/`: Ghostty config
- `fastfetch/`: fastfetch config
- `zsh/`: zsh + zimfw + zfz + oh-my-posh
- `git/`: git and lazygit config
- `tmux/`: tmux config
- `yazi/`: yazi config
- `shared/`: shared env/aliases
- `scripts/`: install/link/check scripts
- `docs/`: setup and troubleshooting notes

## Source Paths (macOS)

This repo is synced from the following active local paths:
- `~/.zshrc`
- `~/.zimrc`
- `~/fzf.zsh`
- `~/.gitconfig`
- `~/.gitignore_global`
- `~/Library/Application Support/com.mitchellh.ghostty/config`
- `~/Library/Application Support/lazygit/config.yml`
- `~/.config/fastfetch/config.jsonc`

## Manual Prerequisites (Important)

- `bootstrap.sh` does **not** install Homebrew packages.
- `bootstrap.sh` only:
  - runs `scripts/install.sh` (installs `zimfw` + runs `fzf` post-install script if available)
  - runs `scripts/link.sh` (creates symlinks and backups)
- On macOS, install Homebrew manually first (requires administrator permission).

Install all required tools with:

```bash
brew bundle --file Brewfile
```

Tools expected by this repo:
- cask: `ghostty`
- formulae: `zsh`, `tmux`, `yazi`, `fastfetch`, `oh-my-posh`, `fzf`, `git`, `lazygit`

If you prefer manual install without `Brewfile`:

```bash
brew install --cask ghostty
brew install zsh tmux yazi fastfetch oh-my-posh fzf git lazygit
```

## Quick Start

1. Install dependencies (Homebrew required):

```bash
brew bundle --file Brewfile
```

2. Run install helper:

```bash
bash scripts/install.sh
```

3. Link configs into `$HOME`:

```bash
bash scripts/link.sh
```

4. Reload shell:

```bash
exec zsh
```

## Private Local Overrides

Put machine-specific or secret settings in:
- `~/.zshrc.local`
- `~/.gitconfig.local`
- `~/.tmux.conf.local`

These files are sourced if present and are not tracked by this repo.

## Maintenance

- Validate environment:

```bash
bash scripts/doctor.sh
```

- If config changes break startup, see `docs/troubleshooting.md`.

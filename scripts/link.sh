#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/terminal-config"
mkdir -p "$HOME/.config/lazygit"
mkdir -p "$HOME/.config/yazi"
mkdir -p "$HOME/.config/ohmyposh"
mkdir -p "$HOME/.config/ghostty"
mkdir -p "$HOME/.config/fastfetch"
mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"
mkdir -p "$HOME/Library/Application Support/lazygit"

backup_if_exists() {
  local path="$1"
  if [ -e "$path" ] && [ ! -L "$path" ]; then
    local backup="${path}.bak.$(date +%Y%m%d%H%M%S)"
    mv "$path" "$backup"
    echo "backup: $path -> $backup"
  fi
}

link_file() {
  local src="$1"
  local dst="$2"

  backup_if_exists "$dst"

  if [ -L "$dst" ] || [ -f "$dst" ]; then
    rm -f "$dst"
  fi

  ln -s "$src" "$dst"
  echo "linked: $dst -> $src"
}

# main dotfiles
link_file "$ROOT_DIR/zsh/.zshrc" "$HOME/.zshrc"
link_file "$ROOT_DIR/zsh/.zimrc" "$HOME/.zimrc"
link_file "$ROOT_DIR/git/.gitconfig" "$HOME/.gitconfig"
link_file "$ROOT_DIR/git/.gitignore_global" "$HOME/.gitignore_global"
link_file "$ROOT_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

# app configs
link_file "$ROOT_DIR/ghostty/config" "$HOME/.config/ghostty/config"
link_file "$ROOT_DIR/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
link_file "$ROOT_DIR/git/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"
link_file "$ROOT_DIR/git/lazygit/config.yml" "$HOME/Library/Application Support/lazygit/config.yml"
link_file "$ROOT_DIR/yazi/yazi.toml" "$HOME/.config/yazi/yazi.toml"
link_file "$ROOT_DIR/yazi/keymap.toml" "$HOME/.config/yazi/keymap.toml"
link_file "$ROOT_DIR/yazi/theme.toml" "$HOME/.config/yazi/theme.toml"
link_file "$ROOT_DIR/zsh/oh-my-posh/theme.omp.json" "$HOME/.config/ohmyposh/theme.omp.json"
link_file "$ROOT_DIR/zsh/oh-my-posh/theme.omp.json" "$HOME/themes.json"
link_file "$ROOT_DIR/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"

# repo-level shared files
if [ -L "$HOME/.config/terminal-config" ]; then
  rm -f "$HOME/.config/terminal-config"
elif [ -d "$HOME/.config/terminal-config" ]; then
  backup_if_exists "$HOME/.config/terminal-config"
fi
ln -s "$ROOT_DIR" "$HOME/.config/terminal-config"

echo "all links updated"

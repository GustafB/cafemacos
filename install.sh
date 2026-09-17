#!/bin/bash
# Install the cafemac desktop: brew packages, symlinked configs, services.
# Re-runnable. Existing non-symlink configs are moved to <path>.bak.
set -euo pipefail
REPO="$(cd "$(dirname "$0")" && pwd)"

link() {
  local src="$REPO/config/$1" dst="$HOME/.config/$1"
  mkdir -p "$(dirname "$dst")"
  if [ -L "$dst" ]; then rm "$dst"
  elif [ -e "$dst" ]; then mv "$dst" "$dst.bak"; echo "moved existing $dst to $dst.bak"; fi
  ln -s "$src" "$dst"
  echo "linked $dst"
}

brew trust nikitabobko/tap >/dev/null 2>&1 || true
brew trust FelixKratz/formulae >/dev/null 2>&1 || true
brew bundle --file="$REPO/Brewfile"

# layout switcher for the bar; needs Xcode command line tools
mkdir -p "$REPO/bin"
swiftc -O -o "$REPO/bin/kbswitch" "$REPO/src/kbswitch.swift"

# cmd-click on file links in Ghostty opens nvim
"$REPO/bin/set-nvim-handler.sh"

for c in aerospace sketchybar borders ghostty; do link "$c"; done

# AeroSpace docs: group windows by app in Mission Control so it stays usable
defaults write com.apple.dock expose-group-apps -bool true
# hide the native menu bar; sketchybar takes its place
defaults write NSGlobalDomain _HideMenuBar -bool true
killall Dock SystemUIServer 2>/dev/null || true

brew services restart sketchybar
brew services restart borders
open -a AeroSpace
echo "done. grant AeroSpace accessibility access if macOS asks."

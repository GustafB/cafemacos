#!/bin/bash
# Remove everything install.sh set up and return to stock macOS.
set -uo pipefail
osascript -e 'quit app "AeroSpace"' 2>/dev/null
brew services stop sketchybar borders
brew uninstall --cask aerospace font-jetbrains-mono-nerd-font
brew uninstall sketchybar borders
# drop the nvim file handler; macOS falls back to its own defaults
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -u "$HOME/Applications/OpenInNvim.app" 2>/dev/null
rm -rf "$HOME/Applications/OpenInNvim.app"
brew uninstall duti
brew untap nikitabobko/tap FelixKratz/formulae
for c in aerospace sketchybar borders ghostty; do
  [ -L "$HOME/.config/$c" ] && rm "$HOME/.config/$c"
  [ -e "$HOME/.config/$c.bak" ] && mv "$HOME/.config/$c.bak" "$HOME/.config/$c"
done
defaults delete com.apple.dock expose-group-apps 2>/dev/null
defaults delete NSGlobalDomain _HideMenuBar 2>/dev/null
killall Dock SystemUIServer 2>/dev/null
echo "done. the repo itself is untouched."

# cafemac

macOS counterpart to [cafeos](https://github.com/GustafB/cafeos). Same modifier (Alt), same
workspace and hjkl bindings, without disabling SIP.

| cafeos | cafemac |
|---|---|
| Hyprland | [AeroSpace](https://github.com/nikitabobko/AeroSpace) |
| waybar | [SketchyBar](https://github.com/FelixKratz/SketchyBar) |
| hyprland borders | [JankyBorders](https://github.com/FelixKratz/JankyBorders) |
| kitty | Ghostty |
| rofi | Raycast |

## Layout

```
Brewfile            packages and taps
config/<app>/       symlinked to ~/.config/<app>
config/sketchybar/  bar after Pe8er's setup: items/ define, plugins/ update, icon_map.sh is
                    the sketchybar-app-font map (vendored from its releases)
install.sh          brew bundle, symlinks, defaults, start services
uninstall.sh        undo all of the above
```

## Install

```sh
git clone <this-repo> ~/cafemac && ~/cafemac/install.sh
```

macOS asks for Accessibility access for AeroSpace on first launch. Clicking the Wi-Fi and
battery items opens the native popover through System Events, which needs Accessibility for
`sketchybar` as well (System Settings > Privacy & Security > Accessibility, then
`brew services restart sketchybar`); without it the click opens the matching settings pane.
No Screen Recording permission is needed. The native menu bar is hidden by the installer's
`_HideMenuBar` default, which takes effect after logging out and in; or set System Settings >
Control Center > Automatically hide and show the menu bar to Always.

The layout item on the far left toggles tiles/accordion on click. Workspaces show their apps
as icons and hide when empty. Weather comes from open-meteo for the cafeos coordinates.
The keyboard item shows US or SE and toggles between them on click, using `bin/kbswitch`
(built from `src/kbswitch.swift` by the installer, no permissions needed). The stock
ctrl-space still works as well. Karabiner (caps lock
as control) and Raycast are assumed to be set up already and are not managed here.

## Keys

Alt is the modifier. `alt-slash` opens this config.

| keys | action |
|---|---|
| alt-return / alt-shift-return | Ghostty / Raycast |
| alt-q | close window |
| alt-h/j/k/l, arrows | focus (j=up, k=down as in cafeos) |
| alt-shift-h/j/k/l | move window |
| alt-1..0, alt-shift-1..0 | switch / send to workspace |
| alt-tab | previous workspace |
| alt-shift-f / alt-shift-i | float toggle / flip split |
| alt-r, then h/j/k/l, esc | resize mode (bar shows a resize glyph) |
| alt-v | Raycast clipboard history |
| alt-ctrl-l | lock (display sleep) |

## File links

Cmd-clicking a file link in Ghostty (Claude Code emits them for every file it mentions) opens
the file in nvim in a new Ghostty window. `bin/set-nvim-handler.sh` compiles
`src/OpenInNvim.applescript` into `~/Applications/OpenInNvim.app` and registers it with
`duti` as the default app for text and code types and a list of code extensions; images,
PDFs and everything else keep their usual apps. Edit the lists in that script and re-run it
to change what goes to nvim. Ghostty cannot pass a line number through, so links land on
line 1.

## Editing

Edit files in `config/`, then `aerospace reload-config`, `sketchybar --reload` or
`brew services restart borders`. Ghostty reloads with cmd-shift-comma.

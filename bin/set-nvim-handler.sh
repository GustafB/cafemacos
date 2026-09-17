#!/bin/bash
# Build the OpenInNvim shim into ~/Applications and make it the default app for text and
# code files, so cmd-clicking a file link in Ghostty lands in nvim. Images, PDFs and the
# like are untouched. Re-runnable.
set -euo pipefail
REPO="$(cd "$(dirname "$0")/.." && pwd)"
APP="$HOME/Applications/OpenInNvim.app"
mkdir -p "$HOME/Applications"
rm -rf "$APP"
osacompile -o "$APP" "$REPO/src/OpenInNvim.applescript"
PLIST="$APP/Contents/Info.plist"
/usr/bin/plutil -replace CFBundleIdentifier -string se.cafebabe.openinnvim "$PLIST"
/usr/bin/plutil -replace LSUIElement -bool true "$PLIST"
# claim the types explicitly; Launch Services only lets duti pick an app that declares them
/usr/bin/plutil -replace CFBundleDocumentTypes -json '[{"CFBundleTypeName":"Text and source","CFBundleTypeRole":"Editor","LSHandlerRank":"Owner","LSItemContentTypes":["public.plain-text","public.text","public.source-code","public.script","public.shell-script","public.json","public.yaml","public.xml"]},{"CFBundleTypeName":"Code by extension","CFBundleTypeRole":"Editor","LSHandlerRank":"Owner","CFBundleTypeExtensions":["md","markdown","go","toml","nix","lua","rs","ts","tsx","jsx","mjs","cjs","sql","env","cfg","conf","ini","log","txt","csv","proto","tf","hcl","gradle","kt","java","scala","zig","c","h","cpp","hpp","cs","php","rb","py","yaml","yml","json","sh","zsh","bash","fish","vim","gitignore","editorconfig","rasi","yuck","kdl","scss","css","mod","sum"]}]' "$PLIST"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -f "$APP"

ID=se.cafebabe.openinnvim
for uti in public.plain-text public.source-code public.shell-script public.script \
           public.json public.yaml public.xml public.swift-source public.c-source \
           public.c-header public.python-script public.ruby-script public.perl-script \
           com.netscape.javascript-source; do
  duti -s $ID "$uti" all 2>/dev/null || true
done
# extensions macOS only knows as dynamic types
for ext in md markdown go toml nix lua rs ts tsx jsx mjs cjs sql env cfg conf ini log txt \
           csv proto tf hcl gradle kt java scala zig c h cpp hpp cs php rb py yaml yml json \
           sh zsh bash fish vim gitignore editorconfig Makefile Dockerfile; do
  duti -s $ID "$ext" all 2>/dev/null || true
done
echo "OpenInNvim registered for text and code files"

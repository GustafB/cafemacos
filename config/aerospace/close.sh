#!/bin/bash
# alt-q: in a Ghostty window whose tmux session (ghostty/tmux-tabs) has several tabs,
# close the current tab; anywhere else, close the window as usual.
export PATH="$HOME/homebrew/bin:/opt/homebrew/bin:$PATH"

IFS='|' read -r app app_pid < <(aerospace list-windows --focused --format '%{app-bundle-id}|%{app-pid}')

if [ "$app" = com.mitchellh.ghostty ]; then
  # the window's tmux client is a descendant of the focused Ghostty process; one process
  # can own several windows (cmd-n), so prefer the client tmux reports as focused
  match=() focused=()
  while read -r client_pid session windows flags; do
    p=$client_pid
    while [ "${p:-1}" -gt 1 ] && [ "$p" != "$app_pid" ]; do
      p=$(ps -o ppid= -p "$p" | tr -d ' ')
    done
    [ "$p" = "$app_pid" ] || continue
    match+=("$session $windows")
    case ",$flags," in *,focused,*) focused+=("$session $windows") ;; esac
  done < <(tmux -L ghostty list-clients -F '#{client_pid} #{session_id} #{session_windows} #{client_flags}' 2>/dev/null)

  [ ${#focused[@]} -eq 1 ] && match=("${focused[@]}")
  if [ ${#match[@]} -eq 1 ]; then
    read -r session windows <<<"${match[0]}"
    if [ "$windows" -gt 1 ]; then
      tmux -L ghostty kill-window -t "$session:"
      exit
    fi
  fi
fi

aerospace close

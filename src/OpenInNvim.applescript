-- Default-app shim: opens the dropped/clicked files in nvim inside a new Ghostty window.
-- Registered for text and code types by bin/set-nvim-handler.sh.
-- The paths are embedded in one `sh -c` string on purpose: any existing file path that
-- appears as its own argv entry (via `open --args` or the binary alike) is also handed to
-- Ghostty's Cocoa layer as a document, which it then runs as a command in a second window.
on open theFiles
	set paths to ""
	repeat with f in theFiles
		set paths to paths & " " & quoted form of POSIX path of f
	end repeat
	launchNvim(paths)
end open

on run
	launchNvim("")
end run

on launchNvim(paths)
	set logf to "/tmp/openinnvim.log"
	do shell script "{ echo \"=== $(date +%T) paths:" & paths & "\"; env | sort; } >> " & logf
	set nvim to do shell script "/bin/zsh -lc 'command -v nvim' 2>>" & logf
	do shell script "echo \"nvim=" & nvim & "\" >> " & logf
	set cmd to "exec " & quoted form of nvim & paths
	do shell script "nohup /Applications/Ghostty.app/Contents/MacOS/ghostty -e /bin/zsh -lc " & quoted form of cmd & " >>" & logf & " 2>&1 & echo \"launched pid=$!\" >> " & logf
end launchNvim

// Toggle or select keyboard layouts through the Text Input Sources API; no
// accessibility permission needed, unlike simulating ctrl-space.
//   kbswitch            cycle through enabled keyboard layouts
//   kbswitch <name>     select layout whose name contains <name> (e.g. Swedish)
//   kbswitch --current  print the current layout name
import Carbon
import Foundation

func name(_ src: TISInputSource) -> String {
    guard let p = TISGetInputSourceProperty(src, kTISPropertyLocalizedName) else { return "?" }
    return Unmanaged<CFString>.fromOpaque(p).takeUnretainedValue() as String
}

let filter: [CFString: Any] = [
    kTISPropertyInputSourceCategory: kTISCategoryKeyboardInputSource as Any,
    kTISPropertyInputSourceType: kTISTypeKeyboardLayout as Any,
    kTISPropertyInputSourceIsEnabled: true,
    kTISPropertyInputSourceIsSelectCapable: true,
]
let layouts = (TISCreateInputSourceList(filter as CFDictionary, false).takeRetainedValue() as! [TISInputSource])
let current = TISCopyCurrentKeyboardLayoutInputSource().takeRetainedValue()
let args = Array(CommandLine.arguments.dropFirst())

if args.first == "--current" {
    print(name(current)); exit(0)
}
if args.first == "--list" {
    layouts.forEach { print(name($0)) }; exit(0)
}
let target: TISInputSource?
if let q = args.first {
    target = layouts.first { name($0).localizedCaseInsensitiveContains(q) }
} else {
    let i = layouts.firstIndex { name($0) == name(current) } ?? -1
    target = layouts.isEmpty ? nil : layouts[(i + 1) % layouts.count]
}
guard let t = target else { FileHandle.standardError.write("no matching layout\n".data(using: .utf8)!); exit(1) }
exit(TISSelectInputSource(t) == noErr ? 0 : 1)

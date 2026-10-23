#!/usr/bin/env python3
"""Print AeroSpace keybindings as a cheat sheet, read live from the config."""
import argparse
import os
import re
import subprocess
import sys

CONFIG = os.path.expanduser(os.environ.get("AEROSPACE_CONFIG", "~/.aerospace.toml"))

# Workspace switching and moving windows to a workspace follow an obvious
# alt-<key> / alt-shift-<key> pattern and would bury everything else.
SKIP = re.compile(r"^(workspace|move-node-to-workspace)\s+\S+$")

MODIFIER_LABEL = {"alt": "⌥", "cmd": "⌘", "ctrl": "⌃", "shift": "⇧"}
KEY_LABEL = {
    "minus": "-", "equal": "=", "slash": "/", "comma": ",", "period": ".",
    "semicolon": ";", "quote": "'", "backslash": "\\", "backtick": "`",
    "leftSquareBracket": "[", "rightSquareBracket": "]",
    "enter": "↩", "esc": "Esc", "tab": "⇥", "space": "Space",
    "backspace": "⌫", "up": "↑", "down": "↓",
    "left": "←", "right": "→",
}

BOLD, DIM, CYAN, RESET = "\033[1m", "\033[2m", "\033[36m", "\033[0m"


def pretty(binding):
    """alt-shift-h -> ⌥⇧H"""
    parts = binding.split("-")
    mods = "".join(MODIFIER_LABEL[p] for p in parts[:-1] if p in MODIFIER_LABEL)
    key = parts[-1]
    return mods + KEY_LABEL.get(key, key.upper() if len(key) == 1 else key)


def parse(path, keep_workspaces=False):
    """Return [(mode, binding, command)] in file order."""
    out, mode = [], None
    with open(path, encoding="utf-8") as fh:
        for raw in fh:
            line = raw.strip()
            if not line or line.startswith("#"):
                continue
            section = re.match(r"^\[mode\.([^.]+)\.binding\]$", line)
            if section:
                mode = section.group(1)
                continue
            if mode is None or "=" not in line:
                continue
            binding, _, value = line.partition("=")
            binding = binding.strip()
            if not re.match(r"^[A-Za-z0-9-]+$", binding):
                continue
            value = value.split("#")[0].strip()
            cmds = re.findall(r"'([^']*)'", value) or re.findall(r'"([^"]*)"', value)
            if not cmds:
                continue
            if not keep_workspaces and any(SKIP.match(c) for c in cmds):
                continue
            out.append((mode, binding, ", ".join(cmds)))
    return out


def main():
    ap = argparse.ArgumentParser(
        prog="aerokeys", description="AeroSpace keybinding cheat sheet"
    )
    ap.add_argument("query", nargs="*", help="filter rows by substring")
    ap.add_argument("-a", "--all", action="store_true", help="include workspace bindings")
    ap.add_argument("-f", "--fzf", action="store_true", help="filter interactively with fzf")
    ap.add_argument("-p", "--plain", action="store_true", help="no colour, no headings")
    args = ap.parse_args()

    if not os.path.exists(CONFIG):
        sys.exit("aerokeys: no AeroSpace config at %s" % CONFIG)

    rows = parse(CONFIG, keep_workspaces=args.all)
    query = " ".join(args.query).lower()
    if query:
        rows = [
            r for r in rows
            if all(w in " ".join(r).lower() for w in query.split())
        ]
    if not rows:
        sys.exit("aerokeys: nothing matches %r" % query)

    colour = sys.stdout.isatty() and not args.plain and not args.fzf
    width = max(len(pretty(b)) for _, b, _ in rows)

    lines, current_mode = [], None
    for mode, binding, command in rows:
        if not args.fzf and not args.plain and mode != current_mode:
            current_mode = mode
            head = "mode: %s" % mode
            lines.append("")
            lines.append("%s%s%s" % (BOLD, head, RESET) if colour else head)
        keys = pretty(binding).ljust(width)
        if colour:
            lines.append("  %s%s%s  %s  %s(%s)%s" % (CYAN, keys, RESET, command, DIM, binding, RESET))
        else:
            lines.append("  %s  %s  (%s)" % (keys, command, binding))

    text = "\n".join(lines).lstrip("\n")
    if args.fzf:
        try:
            subprocess.run(["fzf", "--prompt=aerokeys> "], input=text, text=True)
        except FileNotFoundError:
            sys.exit("aerokeys: fzf is not installed")
    else:
        print(text)


if __name__ == "__main__":
    main()

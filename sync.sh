#!/bin/sh
# Copy this kit's rules, commands and skills into ~/.claude.
# Never touches ~/.claude/settings.json (it holds my iTerm2 hooks).
set -e
cd "$(dirname "$0")"

mkdir -p ~/.claude/commands ~/.claude/skills

# Rules: back up the old global file first
[ -f ~/.claude/CLAUDE.md ] && cp ~/.claude/CLAUDE.md ~/.claude/CLAUDE.md.bak
cp CLAUDE.md ~/.claude/CLAUDE.md

# Commands: remove my- commands that no longer exist here, then copy
for f in ~/.claude/commands/my-*.md; do
  [ -e "$f" ] || continue
  [ -e ".claude/commands/$(basename "$f")" ] || { rm "$f"; echo "removed $(basename "$f")"; }
done
cp .claude/commands/my-*.md ~/.claude/commands/

# Skills
cp -R .claude/skills/* ~/.claude/skills/

echo "Synced. Open a new claude session to load the changes."
ls ~/.claude/commands

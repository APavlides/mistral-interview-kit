---
description: List dead or redundant code without editing
argument-hint: [path to limit the scan]
---
Scope: $ARGUMENTS (if empty, the whole project, excluding .venv and node_modules).

List redundant or dead code, giving the file and line for each item: unused imports, functions and variables, duplicated logic, debug prints, and unneeded dependencies.

Group the items under two headings:
- **Safe to remove**
- **Check first** (say what to check)

Don't edit anything until I choose what to remove.

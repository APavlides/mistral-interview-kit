# mistral-interview-kit

This repo holds the configuration, prompts and instructions for a 60-minute live vibe-coding interview (likely a FastAPI backend calling an LLM API such as Mistral, with a React + Vite frontend, using uv and pnpm).

**It contains no solution code:** no starter app, no API wrapper, no Dockerfile and no boilerplate. All application code gets written live, during the session.

## Structure

```
.
├── README.md                 # this file
├── CLAUDE.md                 # always-on working rules and conventions
├── PROMPTS.md                # copy-paste prompts to use live, plus phrases to say aloud
├── CHECKLIST.md              # 4-day prep plan and "must know cold" list
├── .gitignore                # keeps secrets, venvs, node_modules and archives out of git
├── .vscode/
│   └── launch.json           # debugpy config for uvicorn (adjust the module path)
└── .claude/
    ├── settings.json         # permissions allowlist only (no hooks, no bypass mode)
    ├── commands/
    │   ├── review.md         # /review: explain recent changes, read-only
    │   ├── debug.md          # /debug <error>: diagnose before fixing
    │   ├── pitch.md          # /pitch: client demo pitch plus likely Q&A
    │   ├── cleanup.md        # /cleanup: list dead code without editing
    │   └── qa.md             # /qa: up to 5 critical, demo-breaking issues, checked against running servers
    └── skills/
        ├── write-prd/SKILL.md                   # BRIEF.md -> half-page living PRD.md
        └── fastapi-mistral-conventions/SKILL.md # backend checklist (no code)
```

## Install globally (without overwriting your settings)

Run these from the repo root.

1. Create the folders. This does nothing if they already exist.
   ```sh
   mkdir -p ~/.claude/commands ~/.claude/skills
   ```

2. Copy the commands and skills.
   ```sh
   cp .claude/commands/*.md ~/.claude/commands/
   cp -R .claude/skills/* ~/.claude/skills/
   ```
   If you already have commands or skills with the same names, add `-i` to each `cp` (for example `cp -i ...`). It asks before replacing each file.

3. Add CLAUDE.md to your global rules.
   - If `~/.claude/CLAUDE.md` doesn't exist yet, append this repo's file:
     ```sh
     cat CLAUDE.md >> ~/.claude/CLAUDE.md
     ```
   - If it already exists, open both files and merge them by hand, so you don't end up with duplicate or conflicting rules.

4. Merge the permissions into your global settings **by hand**.
   - Open `~/.claude/settings.json`. It holds your iTerm2 hooks, so leave those as they are.
   - Add the entries from this repo's `.claude/settings.json` `permissions.allow` list to its `permissions.allow` list. Create the `permissions` block if it isn't there.
   - Don't copy this repo's file over yours.
   - Then validate the result:
     ```sh
     python3 -m json.tool ~/.claude/settings.json > /dev/null && echo OK
     ```

5. Set up the debugger in each project. Copy `.vscode/launch.json` into the project, then change `app.main:app` to the starter's module path and app object.

After installing, start Claude Code and run `/status` (to check that the settings loaded) and `/help` (to check that the commands are listed).

Install the kit the day before the interview, not during the 5-minute setup.

## Using this kit with a cloned starter

Once the kit is installed globally, it works in any repo, including the one they give you, and nothing of yours goes into their repo.

1. Clone their repo with `git clone <their-url>` and `cd` into it.
2. If their starter has its own `CLAUDE.md`, Claude loads it alongside yours, and their conventions win.
3. Only if you want the debugger: copy `.vscode/launch.json` from this kit and fix the module path.
4. `BRIEF.md` and `PRD.md` will live in their repo. To keep them out of git, add them to `.git/info/exclude`, your local ignore list, rather than editing their `.gitignore`.

**Fallback** (if you can't install globally, for example on a different machine): copy `CLAUDE.md` and `.claude/` into their repo, then add both to `.git/info/exclude` straight away so you don't commit them.

## Interview-day checklist

Before you start:
- [ ] Check the kit is installed: `/qa` and `/pitch` are listed, and write-prd loads.
- [ ] Have `PROMPTS.md` and `CHECKLIST.md` open on a second screen.

Setup (during their 5-minute intro):
- [ ] Open the starter and check that its `.gitignore` covers `.env`. Only then paste their API key into `.env`.
- [ ] Start the backend and frontend in your own terminals. Don't let Claude start them.
- [ ] Switch Claude Code to accept-edits mode (Shift+Tab). Keep reading every diff.
- [ ] Tell Claude: "We're in a live session."

The build (40 minutes):
- [ ] Paste their brief word for word into `BRIEF.md`, then say: "Read the starter and BRIEF.md, then use write-prd."
- [ ] Ask the PRD's open questions out loud to the interviewer.
- [ ] Build M1 (the thinnest end-to-end slice) first. Stub the model call if it's slow to wire up.
- [ ] Approve each plan once, verify each slice, and narrate what's happening and why.
- [ ] For each new instruction, append it to `BRIEF.md` and say: "Update PRD.md for the new instruction, then build it."
- [ ] If an interviewer steers you mid-build, follow them first and update `BRIEF.md` afterwards. Their brief is the real plan.

The last 5 minutes:
- [ ] Run `/qa` and fix only what's critical.
- [ ] Run `/pitch`, rehearse it once, then demo. Use `PRD.md` to show what was agreed.

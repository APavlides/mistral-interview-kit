# mistral-interview-kit

My Claude Code setup for a 40-minute live vibe-coding interview. It contains **no solution code**: all application code is written live.

## What's in it

| File | What it is |
|---|---|
| `CLAUDE.md` | **Rules.** Claude reads them automatically in every session: plan first, small steps, explain everything, follow the starter. |
| `.claude/commands/*.md` | **Saved prompts.** Typing `/my-start <brief>` is the same as pasting a long prompt with my brief inside it. |
| `.claude/skills/*/SKILL.md` | **Knowledge Claude loads by itself** when the work matches the skill's description. I never call these. `mistral-api` covers using the current SDK correctly; `llm-streaming` covers streaming from FastAPI to React; `pitch-deck` turns the finished app into a client story and an HTML deck (`/my-pitch` triggers it). |
| `.claude/settings.json` | **Permissions.** Commands Claude may run without asking. Adding packages, committing, pushing and deleting still ask. |
| `CHECKLIST.md` | My prep plan and the things to know cold. Not used by Claude. |

The eight commands (each does one job). They all start with `my-`, so typing `/my-` lists only mine:

| Command | Job |
|---|---|
| `/my-explain [area]` | Right after cloning: explains the codebase in about 2 minutes of reading. Changes nothing |
| `/my-start <brief>` | Brief to `docs/BRIEF.md` and `docs/PRD.md` (with milestones), plus questions to ask. Builds nothing |
| `/my-build [M2]` | Plans the next unfinished milestone, waits for my OK, builds it, verifies it, marks it done |
| `/my-next <instruction>` | A new instruction from the interviewer: adds it to `docs/BRIEF.md` and `docs/PRD.md`. Builds nothing |
| `/my-test <name>` | When they ask for a test: proposes 3 to 5 cases, writes them with a fake Mistral client, runs them |
| `/my-debug <error>` | When something breaks: diagnoses before changing anything |
| `/my-qa` | About 5 minutes before the demo: up to 5 demo-breaking issues |
| `/my-pitch` | Before the demo: writes `docs/PITCH.md` (talk track plus likely questions) and `docs/slides.html` (the deck) |

## Install once

From this folder:

```sh
mkdir -p ~/.claude/commands ~/.claude/skills
cp .claude/commands/my-*.md ~/.claude/commands/
cp -R .claude/skills/* ~/.claude/skills/
cat CLAUDE.md >> ~/.claude/CLAUDE.md
```

If `~/.claude/CLAUDE.md` already has content, open it afterwards and tidy up any duplicates.

**After changing the kit:** run `./sync.sh` from this folder, then open a new `claude` session. The script:
- copies `CLAUDE.md` over `~/.claude/CLAUDE.md`, after saving the old one as `~/.claude/CLAUDE.md.bak`
- copies the commands, and removes any `my-` command that no longer exists here
- copies the skills
- never touches `~/.claude/settings.json`

The kit's `CLAUDE.md` is the master copy. Make rule changes here, not in `~/.claude/CLAUDE.md`, or the next sync will overwrite them.

**Permissions:** never copy this repo's `.claude/settings.json` over `~/.claude/settings.json`, because that would wipe my iTerm2 hooks. Instead, merge its `"allow"` list into the global file's `"permissions": { "allow": [...] }`, keeping everything else. Back up first, then check with `python3 -m json.tool ~/.claude/settings.json`. (Done on 2026-11-05; the backup is `~/.claude/settings.json.bak`.)

**Up-to-date docs (Context7 MCP server, required):** this gives Claude a tool for looking up current library docs, and the `mistral-api` skill tells it when to use it. It's free, and needs no API key. Install the plugin from inside Claude Code:
```
/plugin marketplace add upstash/context7
/plugin install context7@context7-marketplace
```
Restart Claude Code, then run `/mcp`, select Context7 and sign in through the browser. To test it, ask: "Use context7 to look up how to stream a chat completion with the mistralai Python SDK." I'm skipping their `npx ctx7 setup` installer, because it also installs a skill of its own.

Check git access for cloning: `gh auth status` should say "Logged in". If it doesn't, run `gh auth login` and choose HTTPS.

## Interview day

**Setup (5 minutes):**
```sh
git clone <their-url>
cd <repo>
cp .env.example .env          # if they have one; then paste their key into .env
grep -n "^\.env" .gitignore   # make sure .env is ignored; if not: echo ".env" >> .gitignore
```
- Start the backend and frontend in two terminal tabs, using the commands in their README. Typically:
  - backend: `uv sync`, then `uv run uvicorn ...`
  - frontend: `pnpm install`, then `pnpm dev`
- Start Claude Code: `claude`. My rules, commands, skills, permissions and Context7 all load automatically.
- Press **Shift+Tab** for accept-edits mode.

**Build (40 minutes):**
1. `/my-explain`, and read the summary out loud. If the app is almost complete, skip `/my-start` and `/my-build`: fix things one at a time in plain words, with `/my-debug` and `/my-qa`.
1. `/my-start <brief>`. Ask the open questions out loud, then type the answers into the chat.
2. `/my-build`. Approve the plan, read each diff and say out loud what's happening. Repeat `/my-build` for each milestone.
3. When they give a new instruction: `/my-next <instruction>`, then `/my-build`.
4. Small fixes (including issues `/my-qa` finds): just ask in plain words, for example "Fix QA issue 1" or "Handle a Mistral timeout with a friendly error in the UI."

**Wrap-up (last 7 minutes of the build):** run `/my-qa` and fix only what's critical. Then run `/my-pitch` and `open docs/slides.html`, and press Cmd+Ctrl+F for full screen.

**Demo (10 minutes):** present the slides, and switch to the live app on the "Live demo" slide.

**If they give a zip instead of a URL:** unzip it, `cd` into it, run `git init && git add -A && git commit -m starter`, then carry on as above.

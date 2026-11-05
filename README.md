# mistral-interview-kit

My Claude Code setup for a 40-minute live vibe-coding interview. It contains **no solution code**: all application code is written live.

## What's in it

| File | What it is |
|---|---|
| `CLAUDE.md` | **Rules.** Claude reads them automatically in every session: plan first, small steps, explain everything, follow the starter. |
| `.claude/commands/*.md` | **Saved prompts.** Typing `/start <brief>` is the same as pasting a long prompt with my brief inside it. |
| `.claude/skills/*/SKILL.md` | **Knowledge Claude loads by itself** when the work matches the skill's description. I never call these. `mistral-api` covers using the current SDK correctly; `llm-streaming` covers streaming from FastAPI to React; `pitch-deck` turns the finished app into a client story and an HTML deck (`/pitch` triggers it). |
| `.claude/settings.json` | **Permissions.** Commands Claude may run without asking. Adding packages, committing, pushing and deleting still ask. |
| `CHECKLIST.md` | My prep plan and the things to know cold. Not used by Claude. |

The five commands:

| Command | When |
|---|---|
| `/start <brief>` | At the start: saves `BRIEF.md`, writes a short `PRD.md`, lists questions to ask, plans the first slice |
| `/next <instruction>` | Each time they give a new instruction |
| `/debug <error>` | When something breaks: diagnoses before changing anything |
| `/qa` | About 5 minutes before the demo: up to 5 demo-breaking issues |
| `/pitch` | Before the demo: writes `PITCH.md` (talk track plus likely questions) and `slides.html` (the deck) |

## Install once

From this folder:

```sh
mkdir -p ~/.claude/commands ~/.claude/skills
cp .claude/commands/*.md ~/.claude/commands/
cp -R .claude/skills/* ~/.claude/skills/
cat CLAUDE.md >> ~/.claude/CLAUDE.md
```

If `~/.claude/CLAUDE.md` already has content, open it afterwards and tidy up any duplicates. **This never touches `~/.claude/settings.json`.**

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
- Start Claude Code with my permissions: `claude --settings ~/Documents/Projects/mistral-interview-kit/.claude/settings.json`
- Press **Shift+Tab** for accept-edits mode.

**Build (40 minutes):** `/start <brief>`, then `/next <instruction>` for each step they give you. Approve each plan, read each diff and say out loud what's happening.

**Wrap-up (last 7 minutes of the build):** run `/qa` and fix only what's critical. Then run `/pitch` and `open slides.html`, and press Cmd+Ctrl+F for full screen.

**Demo (10 minutes):** present the slides, and switch to the live app on the "Live demo" slide.

**If they give a zip instead of a URL:** unzip it, `cd` into it, run `git init && git add -A && git commit -m starter`, then carry on as above.

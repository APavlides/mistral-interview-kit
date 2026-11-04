# mistral-interview-kit

My Claude Code setup for a live vibe-coding interview (likely a FastAPI backend calling the Mistral API, with a React + Vite frontend, using uv and pnpm).

It contains **no solution code**, only instructions for Claude. All application code gets written live, in the interview.

---

## 1. What this is (one minute)

- **`CLAUDE.md`**: rules Claude reads automatically in every session, such as plan first, take small steps, explain everything, and add nothing I didn't ask for.
- **Slash commands** (`.claude/commands/`): saved prompts. Typing `/start <brief>` is the same as pasting a long prompt with my brief inside it. Type `/` in Claude Code to see them all.
- **Skills** (`.claude/skills/`): saved procedures Claude uses when it needs them. `/start` and `/next` use write-prd for me.
- **`settings.json`**: commands Claude may run without asking me (tests, `git status` and so on). Adding packages, committing, pushing and deleting still ask.

Installing copies these into `~/.claude/`, so they work in **any** folder, including the interviewers' repo. **Nothing ever needs copying into their repo.**

---

## 2. Install once, the day before

Run this from this repo's folder:

```sh
mkdir -p ~/.claude/commands ~/.claude/skills
cp .claude/commands/*.md ~/.claude/commands/
cp -R .claude/skills/* ~/.claude/skills/
```

**Rules:** if `~/.claude/CLAUDE.md` doesn't exist yet, run `cat CLAUDE.md >> ~/.claude/CLAUDE.md`. If it does exist, open both files and merge them by hand.

**Permissions (optional, but fewer prompts):**
1. Open `~/.claude/settings.json`. It contains my iTerm2 hooks, so **don't overwrite it**.
2. Add the lines from this repo's `.claude/settings.json` `"allow"` list to its `"allow"` list. Create `"permissions": { "allow": [ ... ] }` if it isn't there.
3. Check the JSON is valid: `python3 -m json.tool ~/.claude/settings.json > /dev/null && echo OK`

**Check it worked:** open Claude Code in any folder and type `/`. You should see `/start`, `/next`, `/qa` and `/pitch`.

**Check git access works** (so cloning doesn't catch me out on the day):
```sh
gh auth status
```
It should say "Logged in to github.com". If it doesn't, run `gh auth login`, choose HTTPS and log in through the browser.

**Updating later:** after changing the kit, run the two `cp` lines again.

---

## 3. Interview day: get a working folder (5-minute setup)

Pick the case that matches what they give me.

### A) They give a git URL
```sh
cd ~/Documents/Projects
git clone <url>
cd <repo-name>
```
- **A public repo** clones with no keys or login.
- **A private repo** uses my GitHub login (checked with `gh auth status` the day before). They may need my GitHub username to give me access.
- **If the URL starts with `git@github.com:`** (SSH) and it fails, swap it for the HTTPS form: `https://github.com/<owner>/<repo>.git`.

### B) They give a zip or a folder of files
```sh
cd ~/Documents/Projects
unzip <file>.zip -d interview
cd interview
git init && git add -A && git commit -m "starter"
```
Committing their starter first means I can see my changes with `git diff`.

### C) They give only a description and keys (no starter)
```sh
mkdir -p ~/Documents/Projects/interview && cd ~/Documents/Projects/interview
git init
```
`/start` will notice the folder is empty and propose the scaffold (`uv init` with FastAPI, `pnpm create vite` with React + TypeScript). Approve the dependencies when it asks.

### Then, in every case
1. **Protect the key.** Check `.gitignore` contains `.env`: `grep -n "^\.env" .gitignore`. If it doesn't (or there's no `.gitignore`), add it: `echo ".env" >> .gitignore`.
2. **Add the key.** Put it in `.env`, for example `MISTRAL_API_KEY=...`. Use whatever variable name the starter expects.
3. **Install and start the servers myself,** each in its own terminal tab. Use the starter's README if it has one. Typically:
   - backend: `uv sync`, then `uv run uvicorn <module>:app --reload --port 8000`
   - frontend: `pnpm install`, then `pnpm dev`
4. **Start Claude Code:** run `claude` in the project folder, then press **Shift+Tab** for accept-edits mode.

(With no starter, skip step 3 until `/start` has created the scaffold.)

---

## 4. Interview day: the build (40 minutes)

You only need four commands:

| When | Type |
|---|---|
| At the start | `/start <paste their brief>` |
| Each time they give a new instruction | `/next <paste the instruction>` |
| About 5 minutes before the demo | `/qa` |
| For the demo and role-play | `/pitch` |

`/start` saves the brief to `BRIEF.md`, writes a short `PRD.md` and lists questions to ask the interviewer out loud. `/next` adds each instruction to both files and builds it.

Between those:
- **Approve each plan once,** read every diff, and narrate what's happening and why.
- **Build the thinnest end-to-end slice first.** Stub the model call if it's slow to wire up.
- **Use the build commands if they help:** `/client`, `/endpoints`, `/structured`, `/ui`, `/tests`, `/docker`.
- **If something breaks:** `/debug <error>`. To explain a change: `/review`.
- **If an interviewer steers me,** follow them first. Their brief is the real plan.

---

## 5. Practice run (do this tomorrow)

1. Do steps 2 and 3C above in a new folder.
2. `/start Build an app where a user pastes text and gets a 3-bullet summary from Mistral.`
3. Halfway through: `/next Add a button that translates the summary into French.`
4. Finish with `/qa`, then `/pitch`, and say the pitch out loud.

If that works end to end, I understand the whole kit. `CHECKLIST.md` has the full 4-day plan and the "must know cold" answers.

---

## Reference: every file

| File | Purpose | Installed to |
|---|---|---|
| `CLAUDE.md` | Always-on rules and conventions | `~/.claude/CLAUDE.md` |
| `.claude/commands/start.md` | `/start <brief>`: save the brief, write the PRD, plan M1 | `~/.claude/commands/` |
| `.claude/commands/next.md` | `/next <instruction>`: update the brief and PRD, plan, build | `~/.claude/commands/` |
| `.claude/commands/client.md` | `/client`: async Mistral client (timeouts, retries, logging) | `~/.claude/commands/` |
| `.claude/commands/endpoints.md` | `/endpoints`: `/chat`, `/chat/stream` (SSE), `/health`, CORS | `~/.claude/commands/` |
| `.claude/commands/structured.md` | `/structured <fields>`: structured output or tool calls | `~/.claude/commands/` |
| `.claude/commands/ui.md` | `/ui`: React + Vite UI with streaming and a proxy | `~/.claude/commands/` |
| `.claude/commands/tests.md` | `/tests`: three pytest tests with a mocked LLM | `~/.claude/commands/` |
| `.claude/commands/docker.md` | `/docker`: Dockerfile and run.sh (only if asked) | `~/.claude/commands/` |
| `.claude/commands/qa.md` | `/qa`: up to 5 demo-breaking issues | `~/.claude/commands/` |
| `.claude/commands/pitch.md` | `/pitch`: client pitch plus likely Q&A | `~/.claude/commands/` |
| `.claude/commands/debug.md` | `/debug <error>`: diagnose before fixing | `~/.claude/commands/` |
| `.claude/commands/review.md` | `/review`: explain recent changes | `~/.claude/commands/` |
| `.claude/commands/cleanup.md` | `/cleanup`: list dead code | `~/.claude/commands/` |
| `.claude/skills/write-prd/` | Turns `BRIEF.md` into a living `PRD.md` | `~/.claude/skills/` |
| `.claude/skills/fastapi-mistral-conventions/` | Backend checklist Claude follows (no code) | `~/.claude/skills/` |
| `.claude/settings.json` | Permissions allowlist | Merged by hand into `~/.claude/settings.json` |
| `.vscode/launch.json` | VS Code debugger config. Optional: copy into the project and fix the module path | Not installed |
| `.gitignore` | Keeps secrets out of this repo | Not installed |
| `CHECKLIST.md` | 4-day prep plan, must-know answers, phrases to say aloud | Not installed (for me to read) |

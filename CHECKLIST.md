# Prep checklist

## 4-day plan

### Day 1: Setup and Mistral API basics
- [ ] Check the prerequisites from the invite: `python3 --version` (3.12+), `uv --version`, `node -v`, `pnpm -v`.
- [ ] Do a test call with screen sharing and your mic. On macOS, give your terminal and IDE Screen Recording permission. Make the terminal and editor font bigger.
- [ ] Install this kit globally (see README) and confirm `/qa`, `/pitch` and the skills show up in Claude Code.
- [ ] Get a Mistral API key into a local `.env` and confirm `.env` is gitignored.
- [ ] Read the Mistral docs for chat completions, streaming, JSON mode or structured output, tool calling, rate limits and error codes.
- [ ] Make one chat call and one streaming call by hand, and note the response shape and the error shape.
- [ ] Check that Context7 (if you use it) can answer a Mistral SDK question.

### Day 2: Timed build #1 (40 minutes), then a 30-minute review
- [ ] Pick a practice brief you haven't seen before.
- [ ] Rehearse the live workflow from the README: start the servers yourself and switch to accept-edits mode.
- [ ] Run `/start <brief>` and ask the PRD's open questions out loud.
- [ ] Build M0 to M3 against the clock, using the build commands (`/client`, `/endpoints`, `/ui` and so on). Halfway through, add a new requirement with `/next <instruction>`.
- [ ] Run `/qa` and fix whatever is critical.
- [ ] 30-minute review: what was slow, which prompts or rules to tweak, and what you couldn't explain.

### Day 3: Timed build #2, plus pitch practice
- [ ] Use a different brief (for example a classifier, summariser or extractor rather than a chat app).
- [ ] Use the same flow, and aim to finish M3 with time to spare.
- [ ] Run `/pitch` and deliver it aloud twice, timed at 5 minutes. Have someone (or Claude) push back with the Q&A questions.

### Day 4: Full 60-minute mock, then rest
- [ ] Do one full mock: brief, plan, build, qa, pitch, narrating aloud the whole time.
- [ ] Make final tweaks to the kit only. No new features.
- [ ] Stop early and rest.

## Must know cold
- [ ] **Why one shared client in the lifespan:** it reuses connection pools and TLS sessions, avoids per-request setup cost and socket exhaustion, and gives one place for config and clean shutdown.
- [ ] **Which errors to retry, and why jitter:** retry 429, 5xx, timeouts and connection errors, because they're transient. Don't retry other 4xx, because the request itself is wrong. Use exponential backoff to ease load, and jitter so clients don't retry in sync (the thundering herd). Respect `Retry-After`.
- [ ] **SSE on the wire:** `Content-Type: text/event-stream`, with each event as `data: ...` followed by a blank line, over one long-lived HTTP response. It's one-way, from server to client. Disable buffering. Send a final done event and an error event.
- [ ] **Vite proxy versus CORS:** the proxy makes the browser see the same origin, so dev needs no CORS. CORS is the server telling the browser which other origins may call it, and it's needed when the frontend and API are on different origins (as in production without a reverse proxy).
- [ ] **Every line of a Dockerfile:** base image, workdir, copying the dependency files first for caching, installing with uv, copying the source, the non-root user, the exposed port and the CMD.
- [ ] **What each part of this kit does:**
  - [ ] CLAUDE.md rules: plan first, the live-session mode (approve once, servers run by you), POC slice, diagnose before fixing, and the backend and frontend conventions.
  - [ ] Flow commands: `/start`, `/next`, `/qa`, `/pitch`.
  - [ ] Build commands: `/client`, `/endpoints`, `/structured`, `/ui`, `/tests`, `/docker`.
  - [ ] Control commands: `/review`, `/debug`, `/cleanup`.
  - [ ] Skills: write-prd (BRIEF.md to a living PRD.md) and fastapi-mistral-conventions.
  - [ ] `settings.json`: what's allowed, and why `uv add`, `pnpm add`, `git commit`, `git push` and `rm` still prompt.

## Phrases to say aloud
Read these before the interview, not during it.
- "First I'll make sure I understand the goal and the user."
- "I'll build the thinnest end-to-end slice first, then harden it."
- "I'm stubbing the model call for a minute to prove the UI-to-API path."
- "I'm asking it to diagnose before it edits, so I stay in control."
- "I'm only retrying on 429, 5xx and timeouts: other 4xx errors won't succeed on a retry."
- "Jitter stops many clients from retrying at the same moment."
- "One shared client in the lifespan reuses connections instead of opening one per request."
- "I'm using the Vite proxy so there's no CORS in dev and no hardcoded URLs."
- "That's out of scope for the POC; I'd add it next."
- "Let me verify that before moving on."

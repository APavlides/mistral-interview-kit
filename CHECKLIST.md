# Prep checklist

## Day 1: Tools and basics
- [ ] Check `python3 --version` (3.12+), `uv --version`, `node -v` and `pnpm -v`. Install anything missing with `brew install uv node pnpm`.
- [ ] Install the kit and Context7 (README), check `gh auth status`, and type `/my-` in Claude Code to see the eight commands.
- [ ] In the practice builds, watch for a "Skill" step when Claude writes Mistral or streaming code. If a skill never triggers, tweak its description.
- [ ] Build the practice starter in a separate folder, and push it to a private GitHub repo.
- [ ] Read the Mistral docs on chat completions, streaming, JSON output and function calling. Skim embeddings and OCR.
- [ ] Test screen sharing and the mic. On macOS, give your terminal Screen Recording permission. Make the font bigger.

## Day 2: Timed build #1 (40 minutes)
- [ ] Clone a fresh copy of the practice starter, then follow the README "Interview day" section exactly.
- [ ] Brief: "A user pastes text and gets a 3-bullet summary." Run `/my-start`, then `/my-build` for each milestone. Halfway through: `/my-next Stream the summary as it's generated.`, then `/my-build`.
- [ ] Stop building at 33 minutes. Run `/my-qa`, then `/my-pitch`, then `open docs/slides.html`. Time how long the deck takes to generate.
- [ ] Present the slides out loud, switching to the live app on the "What I built" slide.
- [ ] Spend 15 minutes on what was slow, and on what you couldn't explain.

## Day 3: Timed build #2, plus pitch practice
- [ ] Use a different brief: "Classify support tickets into categories with a reason." Halfway through: `/my-next Return structured JSON.`, then `/my-build`.
- [ ] Give the pitch twice, 5 minutes each, and answer the Q&A out loud.
- [ ] Run `/my-test` on the endpoint that calls Mistral, so you've seen how the fake client works before you have to explain it.

## Day 4: Full 60-minute mock, then rest

## Must know cold
- **Why one shared client in the lifespan?** It reuses connections instead of opening one per request, and gives one place for setup and shutdown.
- **Which errors do you retry?** 429, 5xx and timeouts, because they're temporary. Not other 4xx, because the request itself is wrong.
- **Why jitter?** So many clients don't all retry at the same moment.
- **What is SSE?** One long HTTP response with `Content-Type: text/event-stream`, where each chunk is a `data: ...` line followed by a blank line.
- **Vite proxy or CORS?** The proxy makes the browser think the frontend and API are the same site, so dev needs no CORS. CORS is needed when they're on different origins.
- **uv versus pnpm:** uv manages Python (`pyproject.toml`, `uv.lock`, `.venv`). pnpm manages JavaScript (`package.json`, `pnpm-lock.yaml`, `node_modules`).
- **Your setup in one sentence:** "Rules in CLAUDE.md keep Claude planning first and in small steps. Eight saved prompts I trigger, all prefixed `my-` and one job each: explain (the codebase in 2 minutes), start (brief to PRD), build (plan and build a milestone), next (update the PRD), test, debug, QA and pitch. Three skills hold the know-how: the current Mistral SDK, streaming, and a pitch framework that turns the finished app into a client story and deck, and Context7 gives it up-to-date docs. A permissions list blocks installs, commits and deletes without asking."

## Phrases to say aloud
- "Thinnest end-to-end slice first, then I'll harden it."
- "I'm stubbing the model call to prove the UI-to-API path."
- "I'm asking it to diagnose before it edits."
- "That's out of scope for the POC; it'd be next."
- "Let me verify that before moving on."

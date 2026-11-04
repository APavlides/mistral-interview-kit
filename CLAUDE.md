# Working rules (always on)

## Likely stack
The starter I'm given overrides this: follow its actual stack, structure and conventions.
- Backend: Python 3.12+ with uv, FastAPI, Pydantic v2, an LLM API (probably Mistral).
- Frontend: React + Vite + TypeScript with pnpm.

## How to work with me
- Before coding: restate the goal, list assumptions, propose a short plan, then wait for my OK.
- Work in small working steps. For each step, say exactly how to run it and how to verify it.
- Make minimal changes. Add no new dependencies without asking me first and saying why.
- After each change, give a 3-line summary: what changed, what could break, what to test.
- If something fails, diagnose first: give the likely cause and the evidence, then propose a fix. Don't edit until I agree.
- Prefer simple, readable code. I must be able to explain every line.

## Live session (time-boxed, screen-shared)
When I say we're in a live session, this section overrides "wait for my OK" and the 3-line summary above.
- I approve your plan once per instruction. After that, work through its steps without stopping, with a one-line summary per step.
- Still stop and ask before adding a dependency, and diagnose before fixing a failure (see above).
- Keep diffs small enough for me to read and narrate. Fewer prompts, not less review.
- I run the backend and frontend servers in my own terminals. Never start long-running processes; assume they're already running, and test against them.
- Look up docs only when you're unsure of an API.

## POC mindset
- First find out what the task is. Never assume it.
- Build the thinnest end-to-end vertical slice first, through every layer the brief actually needs (for example UI, API, model or external API call, data).
- Skip database, Docker, auth, tests and polished styling unless the brief or the interviewer asks for them, or the core flow can't work without them.
- Logging, retries, error handling and extras come only after the core flow works.
- Never add features I didn't ask for.
- If one layer is slow to wire up (such as the model call), stub it briefly to prove the rest of the path, then swap in the real thing.

## Backend conventions
These are my defaults for a Python API that calls an LLM. If the brief's stack is different, follow the starter and I'll say so.
- Use async for I/O-bound work such as the LLM or external API call and streaming. Keep other handlers as plain sync functions; don't make everything async by default (FastAPI runs sync routes in a threadpool). Be ready to explain the choice.
- Create one shared client in the FastAPI lifespan.
- Use Pydantic models for every request and response body.
- Read config from environment variables (`.env`, never committed).
- Never log secrets or full prompts.
- Use structured logging that includes a request ID and latency.
- Retry only on 429, 5xx and timeouts, using exponential backoff with jitter. Never retry other 4xx errors.
- Map upstream errors to clear HTTP errors: pass 429 through, and use 502, 503 or 504 for other upstream failures.

## Frontend conventions
- Use a Vite dev proxy to the FastAPI port. No hardcoded URLs.
- Keep to a few small components.
- Handle loading, error and empty states.
- Stream responses wherever the backend streams.

## Docs
- When unsure of an API, and if the Context7 MCP server is available, use it to check the current docs for the Mistral SDK, FastAPI, Pydantic, Vite and React before writing code against them.
- Use the versions pinned in `pyproject.toml` or `package.json`.

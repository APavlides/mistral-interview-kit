# Working rules

## Context
I'm in a 40-minute live coding interview, sharing my screen. They give me a starter repo and a brief in steps. The starter's stack and conventions always win over anything below.

## How to work with me
- For each instruction: restate the goal in one line, propose a short plan, and wait for my OK. Then work through the plan without stopping, with a one-line summary per step.
- Keep changes small enough for me to read and explain. I must be able to explain every line.
- Never add a dependency without asking first and saying why.
- If something fails, diagnose first (the likely cause and the evidence), then propose a fix. Don't edit until I agree.
- I run the backend and frontend servers myself. Never start long-running processes; assume they're running and test against them.
- Look up docs only when you're unsure of an API (with Context7 if it's available), and use the versions in `pyproject.toml` and `package.json`. For Mistral and streaming details, use the mistral-api and llm-streaming skills.

## POC mindset
- Build the thinnest end-to-end slice first (UI to API to Mistral and back), then improve it.
- If the Mistral call is slow to wire up, stub it briefly to prove the rest of the path.
- No database, Docker, auth, tests or styling unless the brief asks for them.
- Never add features I didn't ask for.

## Backend conventions (FastAPI + Mistral)
- Use async for the Mistral call and for streaming. Plain sync is fine elsewhere.
- Create one shared Mistral client in the FastAPI lifespan.
- Use Pydantic models for request and response bodies.
- Read the API key from `.env` (never committed). Never log keys or full prompts.
- Once the core flow works:
  - Set timeouts on upstream calls.
  - Retry only on 429, 5xx and timeouts, with backoff and jitter. Prefer the SDK's built-in retry config over a hand-written loop.
  - Map errors clearly: pass 429 through, and use 502 or 504 for other upstream failures.

## Frontend conventions (React + Vite)
- Use the Vite dev proxy to reach the backend. No hardcoded URLs.
- Keep to a few small components.
- Show loading, error and empty states.

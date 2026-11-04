# Live prompts

These are prompts to copy and paste during the session. Use only the ones that fit the brief, and adapt names and paths to the starter. Each prompt relies on the CLAUDE.md rules (plan first, small steps, explain how to verify).

---

## 1. Project structure
> Read the starter and tell me its current structure, stack and how to run it. Then propose the smallest folder layout for a FastAPI backend and a React + Vite frontend that fits this brief: [brief]. List the files you would create and one line on the purpose of each. Don't write code yet; wait for my OK.

## 2. Async Mistral client
> Create the backend's Mistral client. Check the Mistral SDK docs (Context7 if available) and the version in pyproject.toml first. Requirements:
> - One shared async client, created in the FastAPI lifespan and closed on shutdown.
> - API key and model from environment variables. Fail fast at startup if they're missing.
> - Explicit timeouts on every call.
> - Retry only on 429, 5xx and timeouts, with exponential backoff and jitter and a small maximum number of attempts. Never retry other 4xx.
> - Structured logging with request ID, latency and attempt count. Never log the key or full prompts.
> - Map upstream errors: pass 429 through, and use 502, 503 or 504 for other failures.
> - Two methods: a normal chat completion, and a streaming one that yields text chunks.
>
> Keep it in one small module. Explain how to verify it from the terminal.

## 3. Endpoints and schemas
> Add the API endpoints using the client from step 2:
> - `POST /chat` with Pydantic v2 request and response models.
> - `POST /chat/stream`, which streams over SSE (`text/event-stream`, `data:` lines, a final done event, and an error event instead of a dropped connection).
> - `GET /health`, which doesn't call the LLM.
> - CORS for the frontend origin only, read from config.
>
> Give me the exact curl commands to test each endpoint, including the streaming one.

## 4. Structured output or tool calling
> I need the model to return [describe the fields]. Check the current Mistral docs for JSON mode or structured output and for tool calling, and recommend one for this case, with the reason. Define the Pydantic model, validate the model's output against it, and on a validation failure either retry once with the error included or return a clear 502. Show me a curl command that proves it works.

## 5. Dockerfile and run.sh
> Only if the brief asks for it: write a minimal Dockerfile using uv (a slim Python base image, dependencies copied and installed first for layer caching, a non-root user, uvicorn on 0.0.0.0) and a `run.sh` that builds and runs it with the `.env` file. Explain every line of the Dockerfile in one sentence each.

## 6. Debugger setup
> Set up debugging for the backend: adapt `.vscode/launch.json` so the module path matches the starter's FastAPI app, and confirm the `.env` path. Tell me where to put a breakpoint to inspect the request just before the Mistral call, and how to start the debug session.

## 7. React chat UI with streaming
> Build a minimal React + Vite + TypeScript chat UI:
> - A Vite dev proxy from `/api` to the FastAPI port. No hardcoded URLs.
> - Two or three small components at most.
> - An input, a message list, and a send button disabled while a request is in flight.
> - Streaming from `/chat/stream`, appending chunks as they arrive.
> - Loading, error and empty states.
> - No styling libraries.
>
> Tell me how to run both servers and what I should see.

## 8. Fault finding
> This is broken: [paste error or symptom]. Diagnose first and don't edit anything. Give me the most likely root cause with evidence from the code or logs, up to 2 other causes and how to rule each one out, then the smallest fix. Wait for my OK before changing anything.

## 9. Three pytest tests
> Write exactly three pytest tests for the backend, mocking the Mistral call (no network):
> 1. The happy path: `/chat` returns 200 with the expected schema.
> 2. An upstream 429 is passed through as 429.
> 3. An upstream timeout returns 504.
>
> Use FastAPI's test client and add no new dependencies without asking. Give me the command to run them.

## 10. Wrap-up client pitch
> Run /pitch for this project. Audience: [who]. Keep it to 3 minutes, plain language, with honest limitations and what production would take.

---

## Phrases to say aloud
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

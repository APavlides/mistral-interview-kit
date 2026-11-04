---
name: fastapi-mistral-conventions
description: Standards checklist for a FastAPI service that calls the Mistral API or another LLM API. Use when writing or reviewing backend code that calls an LLM, including clients, endpoints, streaming, retries, error handling and logging.
---

# FastAPI + LLM API conventions

These are instructions only. The starter's actual stack and conventions override them. Before writing code against an SDK, check its current docs (with Context7 if it's available) and the version pinned in `pyproject.toml`.

## Async and the client
- [ ] Use async for I/O-bound work: the LLM or external API call, and streaming. Keep other routes plain sync, since FastAPI runs those in a threadpool.
- [ ] Never call a blocking SDK method inside an async route.
- [ ] Create one shared LLM client in the FastAPI lifespan, reuse it on every request, and close it on shutdown. Never create a client per request.

## Config and secrets
- [ ] Read the API key, model name, timeouts and the allowed CORS origin from environment variables (`.env`, which is gitignored).
- [ ] Fail fast at startup with a clear message if a required variable is missing.
- [ ] Never log API keys, auth headers or full prompts and completions. Log sizes or truncated previews instead.

## Timeouts
- [ ] Set an explicit timeout on every upstream call, with a separate connect timeout and read timeout.
- [ ] For streaming, use a read timeout between chunks rather than one total-time limit.

## Retries
- [ ] Retry only on 429, 5xx, timeouts and connection errors. Never retry any other 4xx error.
- [ ] Use exponential backoff with jitter, a small maximum number of attempts and a cap on the total wait.
- [ ] Respect `Retry-After` when the response sends it.
- [ ] Don't retry a stream after it has started sending chunks to the client.

## Error mapping
- [ ] Pass upstream 429 through as 429.
- [ ] Map other upstream failures to 502 (bad upstream response), 503 (upstream unavailable) or 504 (upstream timeout).
- [ ] Return a short, safe error body: no stack traces and no upstream secrets.

## Request IDs and logging
- [ ] Give every request an ID: accept an incoming `X-Request-ID` header or generate one, and return it in the response header.
- [ ] Use structured logs (key/value pairs or JSON) that include the request ID, route, status, latency in milliseconds, model and upstream attempt count.

## Pydantic schemas
- [ ] Use a Pydantic v2 model for every request and response body, with limits on lengths and value ranges.
- [ ] Validate LLM output that's supposed to be structured (JSON mode or tool calls) against a Pydantic model.
- [ ] If validation fails, either retry once with the validation error included in the prompt or return a clear 502. Never pass unvalidated output on to the client.

## Streaming over SSE
- [ ] Use the `text/event-stream` content type and send each chunk as a `data:` line followed by a blank line.
- [ ] Send a clear final event (such as `[DONE]`), and send an error event instead of silently dropping the connection.
- [ ] Stop the upstream stream when the client disconnects.
- [ ] Disable proxy buffering where it applies, so chunks reach the client as they're sent.

## CORS and the frontend
- [ ] In dev, prefer the Vite proxy, which makes CORS unnecessary.
- [ ] If CORS is needed, allow the specific frontend origin from config. Never use `*` together with credentials.

## Health
- [ ] Provide a cheap `/health` endpoint that doesn't call the LLM.

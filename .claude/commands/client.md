---
description: Build the async Mistral (LLM) client with retries, timeouts, logging and error mapping
argument-hint: [extra details from the brief]
---
Extra details: $ARGUMENTS

Create the backend's LLM client (Mistral unless the starter says otherwise). First check the SDK version in pyproject.toml and its docs if you're unsure.
- One shared async client, created in the FastAPI lifespan and closed on shutdown.
- API key and model from environment variables. Fail fast at startup if they're missing.
- Explicit timeouts on every call. Retry only on 429, 5xx and timeouts, with exponential backoff and jitter. Never retry other 4xx.
- Structured logging with request ID, latency and attempt count. Never log the key or full prompts.
- Pass 429 through as 429; map other upstream failures to 502, 503 or 504.
- A chat method and a streaming method. Keep it in one small module, and tell me how to verify it.

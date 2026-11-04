---
description: Add the API endpoints - /chat, /chat/stream (SSE), /health, schemas and CORS
argument-hint: [extra details from the brief]
---
Extra details: $ARGUMENTS

Add the API endpoints, using the shared LLM client:
- `POST /chat`, with Pydantic v2 request and response models.
- `POST /chat/stream`, streaming over SSE: `text/event-stream`, `data:` lines, a final done event, and an error event instead of a dropped connection.
- `GET /health`, which doesn't call the LLM.
- CORS for the frontend origin only, read from config.

Adapt the endpoint names and fields to the brief. Give me the exact curl commands to test each one, with the URL first.

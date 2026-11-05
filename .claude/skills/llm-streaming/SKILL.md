---
name: llm-streaming
description: How to stream an LLM response end to end, from FastAPI over SSE to a React frontend through the Vite proxy. Use when adding, changing or debugging streamed responses, or when a stream arrives all at once, hangs, or cuts off.
---

# Streaming end to end

CLAUDE.md and the starter take precedence. This skill is knowledge only: still plan and wait for approval as CLAUDE.md says.

## Backend (FastAPI)
- Return a streaming response with the `text/event-stream` media type, from an async generator that iterates the async Mistral stream.
- Wire format: each event is `data: <payload>` followed by a **blank line**. Without the blank line, the browser never sees the event.
- Send JSON payloads (for example a text delta), so newlines inside the text can't break the format.
- End with a clear done event. If something fails mid-stream, send an error event before closing. Never just drop the connection.
- Headers: `Cache-Control: no-cache`. Add `X-Accel-Buffering: no` if a proxy might buffer.
- Don't retry once chunks have started reaching the client.
- If the client disconnects, stop iterating the upstream stream.

## Frontend (React)
- The browser's built-in `EventSource` only does GET. For a POST with a body, use `fetch` and read `response.body` with a reader and a text decoder.
- Buffer the incoming text and split it on the blank line between events. A single network chunk can contain part of an event, or several events.
- Append each delta to state as it arrives. Disable the send button while streaming, and show an error message if an error event arrives or the request fails.
- Call the API through a relative path (such as `/api/...`) that the Vite proxy forwards to FastAPI. No hardcoded host.

## Debugging checklist
1. Test the backend alone with `curl -N` (no buffering) against the stream endpoint. If chunks arrive one by one there, the backend is fine.
2. If everything arrives at once in the browser, but not with curl, suspect buffering in the proxy or a compression layer, or a frontend that waits for the whole body (calling `.json()` or `.text()`).
3. If the stream hangs at the end, check the done event is sent and that the frontend stops reading.
4. If the text looks garbled or merged, check the blank-line separators and that the frontend buffers partial events.

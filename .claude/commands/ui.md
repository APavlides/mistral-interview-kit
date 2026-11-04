---
description: Build the minimal React + Vite + TypeScript UI with streaming and a dev proxy
argument-hint: [extra details from the brief]
---
Extra details: $ARGUMENTS

Build a minimal React + Vite + TypeScript UI for the core flow (adapt it to the starter and the brief):
- A Vite dev proxy from `/api` to the FastAPI port. No hardcoded URLs.
- Two or three small components at most.
- An input, a results or message list, and a submit button disabled while a request is in flight.
- Stream the response if the backend streams, appending chunks as they arrive.
- Loading, error and empty states. No styling libraries.

Tell me what I should see in the browser (I already have both servers running).

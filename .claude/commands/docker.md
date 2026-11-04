---
description: Write a minimal Dockerfile and run.sh using uv (only if the brief asks)
argument-hint: [extra details]
---
Extra details: $ARGUMENTS

Only do this if the brief or the interviewer asks for it.
Write a minimal Dockerfile using uv:
- A slim Python base image.
- Dependency files copied and installed first, for layer caching.
- A non-root user.
- uvicorn listening on 0.0.0.0.

Also write a `run.sh` that builds the image and runs it with the `.env` file. Explain every Dockerfile line in one sentence each.

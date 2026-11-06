---
name: mistral-api
description: How to call the Mistral API correctly from Python with the current mistralai SDK. Use whenever writing, changing or debugging code that calls Mistral (chat, streaming, structured output, function calling, embeddings, OCR), or when a Mistral import or method fails.
---

# Mistral API

CLAUDE.md and the starter take precedence. This skill is knowledge only: still plan and wait for approval as CLAUDE.md says.

## 1. Check the version before writing any call
- Find the installed version in `uv.lock`, or with `uv pip show mistralai`.
- The SDK's interface changed across major versions, and old examples are everywhere.
  - Very old code uses `MistralClient`.
  - Some versions import with `from mistralai import Mistral`.
  - The current README imports with `from mistralai.client import Mistral`.
- Match the installed version. If the starter already calls Mistral, copy its pattern.
- If an import or method fails, suspect a version mismatch first.

## 2. Look up the exact method names, don't guess
- If the Context7 MCP server is available: resolve the `mistralai` Python client library, then query it for the specific topic (for example "async streaming chat").
- Otherwise, use the docs site (docs.mistral.ai) or the SDK README (github.com/mistralai/client-python).
- Do one focused lookup per feature, not a broad read.

## 3. Facts and conventions
- **Client:** one shared client, created in the FastAPI lifespan with the API key from the environment. The SDK supports async calls and use as an async context manager. Use the async methods inside async routes.
- **Models:** take the model name from config. Don't hard-code it in many places.
- **Retries and timeouts:** prefer the SDK's built-in `retry_config` (backoff strategy) and timeout settings over a hand-written retry loop. Retry only on 429, 5xx and timeouts.
- **Errors:** SDK HTTP errors derive from a base Mistral error class with a `status_code`. Map 429 to 429, and other upstream failures to 502 or 504. A 422 means our request is invalid: fix it, don't retry it.
- **Streaming:** the SDK streams as server-sent events. Each event carries a delta, which may be empty. Skip empty deltas. For forwarding the stream to the browser, see the llm-streaming skill.
- **Structured output:** Mistral recommends custom structured output (a schema, such as one from a Pydantic model) over plain JSON mode. If you use JSON mode, the prompt itself must explicitly ask for JSON. Always validate the result with Pydantic before returning it.
- **Function calling:** the model returns tool calls. Our code runs the tool, sends the result back with the matching tool-call ID, and calls the model again for the final answer.
- **Agents:** Mistral also has an Agents and Conversations API, with built-in tools (such as web search and code execution) and server-side conversation state. Look it up with Context7 before using it, because it's newer and changes often.
- **Embeddings:** an embeddings endpoint with an embedding model (such as `mistral-embed`) and a list of inputs. For small demos, keep the vectors in memory and use cosine similarity. No vector database unless asked.
- **OCR / documents:** there's an OCR endpoint for PDFs and images. Look up its input format before using it.

## 4. Never
- Log the API key or full prompts.
- Mix calls written for two different SDK versions.
- Commit `.env`.

---
description: Get structured output or tool calls from the LLM, validated with Pydantic
argument-hint: <the fields or tools you need>
---
What I need from the model: $ARGUMENTS

1. Check the current Mistral docs for JSON mode or structured output and for tool calling. Recommend one for this case, with a one-line reason, and wait for my OK.
2. Define a Pydantic model for the output and validate the model's response against it.
3. On a validation failure, retry once with the error included in the prompt, or return a clear 502. Never pass unvalidated output on to the client.
4. Give me a curl command that proves it works.

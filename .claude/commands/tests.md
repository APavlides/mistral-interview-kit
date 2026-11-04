---
description: Write three pytest tests with the LLM call mocked
argument-hint: [endpoint or behaviour to focus on]
---
Focus: $ARGUMENTS (if empty, the main endpoint).

Write exactly three pytest tests, mocking the LLM call so there's no network:
1. The happy path returns 200 with the expected schema.
2. An upstream 429 is passed through as 429.
3. An upstream timeout returns 504.

Use FastAPI's test client. Add no new dependencies without asking me first. Give me the command to run the tests.

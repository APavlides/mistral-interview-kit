---
description: Write and run focused tests for one function, class, endpoint or file
argument-hint: <function, class, endpoint or file name>
---
Target: $ARGUMENTS

1. Read the target and the code it calls. Find the test setup the starter already has (pytest for Python, Vitest for the frontend) and follow it.
2. If no test tool is installed, say which one and why (for example `uv add --dev pytest`), and wait for my OK.
3. Propose 3 to 5 test cases, one line each: the main success case, an edge case, and an error case. Wait for my OK.
4. Write the tests. Never call the real Mistral API: replace the client with a fake that returns a fixed reply. Test endpoints with FastAPI's `TestClient`.
5. Run them (for example `uv run pytest -q`) and show me the result. If one fails, tell me whether the test or the code is wrong before changing either.
6. Give me two sentences I can say out loud about what the tests prove.

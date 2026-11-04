---
description: Find up to 5 critical, demo-breaking issues (verified by running the app)
argument-hint: [main flow or endpoint to exercise]
---
Main flow to check: $ARGUMENTS (if empty, infer it from the code).

Report critical issues only: no style or naming notes. Look for:
- crashes on the happy path
- unhandled model or external API failures (timeout, 429, 5xx)
- secrets leaked in code or logs
- broken CORS or proxy
- anything else that would break the demo

First verify by exercising the main flow against the servers I already have running (for example curl to localhost). Don't start servers yourself. Then report at most 5 issues, ranked by severity. For each, give the file, why it matters and the smallest fix. Don't edit anything until I approve.

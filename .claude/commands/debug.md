---
description: Diagnose a failure before touching any code
argument-hint: <error message or symptom>
---
Problem: $ARGUMENTS

Diagnose first. Don't edit any files.
1. Read the error and the relevant code. If it involves Mistral or streaming, use the mistral-api or llm-streaming skill.
2. Give the most likely root cause, with evidence (file:line, log line or output).
3. Give up to 2 other plausible causes, and how to rule each one out.
4. Propose the smallest fix.

Then stop and wait for my OK.

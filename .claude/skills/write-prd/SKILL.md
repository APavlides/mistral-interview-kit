---
name: write-prd
description: Turn the task brief (BRIEF.md if it exists, otherwise the brief given in chat) into a half-page PRD.md at the repo root, and update it as new instructions arrive. Use at the start of a build, whenever a new instruction or requirement is added, or when the user asks for a PRD or spec.
---

# Write PRD

Write a half-page `PRD.md` at the repo root. Write no code. Aim to be done in under 2 minutes.

## Input
- Read `BRIEF.md` at the repo root if it exists. Otherwise use the brief given in chat.
- Read the starter's structure and stack first, so the PRD fits what's already there.

## Sections (in this order, kept terse)
1. **Goal**: one sentence.
2. **User**: who uses it, in one line.
3. **User stories**: 3 to 5, one line each.
4. **Core flow**: a single flow, as numbered steps.
5. **Out of scope**: what we're explicitly not building.
6. **Implementation notes**: the stack (follow the starter), the endpoints (method, path, purpose), and the data, kept in memory with no database unless the brief needs one.
7. **Milestones**: vertical slices, each with a one-line **Done when** check. Detail the current milestone; sketch later ones in a few words.
   - M0: scaffold, the starter running.
   - M1: the thinnest end-to-end path through every layer the brief needs.
   - M2: the core feature.
   - M3: hardening (timeouts, retry with backoff, UI error messages, logging).
   - M4: extras.
8. **Open questions**: at most 3. Mark each **Ask** (a question for the interviewer) or **I decide**, with a recommended default.
9. **Risks and what to cut**: one or two lines.

## Keep it living
- If `PRD.md` already exists, read it and edit only the sections the new instruction changes. Don't regenerate the whole file.
- After an update, say in one line what changed.
- Keep it to half a page. Cut words before adding sections.

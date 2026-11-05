---
description: Turn the brief into docs/BRIEF.md and a short docs/PRD.md with milestones (no building)
argument-hint: <paste the brief>
---
Brief: $ARGUMENTS

Don't write any application code yet.
1. Save the brief word for word to `docs/BRIEF.md`.
2. Read the starter (its README, structure and how it runs). Summarise it in 3 lines.
3. Write a half-page `docs/PRD.md` with these sections:
   - **Goal**: one sentence.
   - **User**: one line.
   - **Core flow**: numbered steps.
   - **Out of scope**: what we're not building.
   - **Endpoints and data**: in memory.
   - **Milestones**: M1 is the thinnest end-to-end slice, then the core feature, then hardening. Each must take about 5 minutes to build, so split any bigger one into smaller milestones. Anything that won't fit in 40 minutes goes under Out of scope. Each has a "Done when" line and a status of [ ] or [x].
   - **Open questions**: up to 3, each marked Ask or I decide, with my recommended default.
4. Show me the open questions, then stop. When I reply with answers, update `docs/PRD.md`.

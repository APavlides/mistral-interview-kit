---
description: Add the interviewer's new instruction to docs/BRIEF.md and update docs/PRD.md (no building)
argument-hint: <paste the new instruction>
---
New instruction: $ARGUMENTS

Don't write any application code. If this is a question rather than an instruction, just answer it and change no files.
1. Append it word for word to `docs/BRIEF.md` under a new numbered "Step" heading.
2. Update `docs/PRD.md`:
   - Never edit a milestone marked [x]. It's a record of what was built.
   - Add new milestones (with "Done when" and [ ]) straight after the last [x] one. Change unfinished milestones only if the instruction affects them.
   - Split anything bigger than about 5 minutes of work.
   - In the other sections, label any planned change with its milestone (for example "M6: SQLite replaces doc.json"). Edit only what changes.
3. Tell me in one line what changed, and which milestone `/my-build` will do next.

---
name: pitch-deck
description: Turn a finished app into a client pitch, written as a talk track (PITCH.md) plus a self-contained HTML slide deck (slides.html), for a non-technical decision maker. Use when asked for a pitch, demo script, presentation, slides or deck, or when preparing a client demo or role-play.
---

# Pitch deck

CLAUDE.md takes precedence. Inputs: `BRIEF.md`, `PRD.md` and the code. Aim to finish in about 2 minutes.

## 1. The story (the same order for the talk and the slides)
1. **Their problem.** Describe it in the client's words, with the cost of doing nothing (time, money, risk).
2. **What we built.** One sentence: "A tool that [does X] so [user] can [outcome]."
3. **Live demo.** 3 to 4 clicks that show the core flow solving the problem. Name what to click and what to say at each step.
4. **How it works.** In plain language, and with a simple diagram. Say where the AI (Mistral) fits, and what stays under the client's control.
5. **Why it matters.** The value in business terms: faster, cheaper, more consistent, scales.
6. **Honest limitations.** What it doesn't do yet, and where a human should stay in the loop.
7. **Next steps.** What production would take (data, security, evaluation, monitoring, cost controls) and a clear ask, such as a 2 to 4 week pilot.

## 2. Role-play guidance (goes in PITCH.md)
- **Opening:** one question to ask the client first, such as "What does this cost you today?". Then tie the pitch to their answer.
- Keep the talk to about 5 minutes, which leaves about 5 minutes for questions.
- **Q&A:** prepare 5 likely questions (cost, data privacy, accuracy and hallucinations, scale, timeline), each with a 1 to 2 sentence answer. Be honest, and offer a next step.
- **Close:** restate the value in one sentence, then make the ask.

## 3. Truthfulness rules
- Claim only what exists in the code. Anything else is a "next step".
- Don't invent metrics. Use "for example" or a clearly marked placeholder such as `[their volume]`.
- Keep technical detail out of the slides. If they ask for it, the presenter explains it.

## 4. Slide rules
- About 7 slides, matching the story: title, problem, solution, "Live demo" (a cue to switch to the app), how it works, limitations, next steps. Value can go on the solution slide.
- One idea per slide: a headline plus at most 3 short bullets. No paragraphs, and no code.
- The diagram has at most 5 boxes (for example User → UI → API → Mistral → back), with plain labels.
- Speaker notes go in `PITCH.md`, not on the slides.

## 5. Deck format (slides.html)
- One self-contained file. No build step, no framework, and inline CSS.
- Load only Mermaid, from a CDN with a pinned, exact version. Under each diagram, add a plain-text version of the flow as a fallback in case it doesn't render.
- Each slide fills the 16:9 viewport, one at a time.
- Arrow keys and the space bar move between slides. Show a slide counter.
- Style for screen sharing: large text (headlines about 48px or more, bullets about 28px or more), high contrast, a light neutral background and one accent colour.

## 6. Before you finish
- Check every claim against the code, and check each slide's word count.
- Make sure the Mermaid syntax is simple and valid.
- Tell me: `open slides.html`, then press Cmd+Ctrl+F for full screen. Then give me a 3-line summary of the story.

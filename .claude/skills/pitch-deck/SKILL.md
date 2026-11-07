---
name: pitch-deck
description: Turn a finished app into a client pitch, written as a short talk track (docs/PITCH.md) plus a 5-slide self-contained HTML deck (docs/slides.html), for a non-technical decision maker. Use when asked for a pitch, demo script, presentation, slides or deck, or when preparing a client demo or role-play.
---

# Pitch deck

CLAUDE.md takes precedence. Inputs: `docs/BRIEF.md`, `docs/PRD.md` and the code. If `docs/` is missing, use the code and what we did in this session. Work fast: I generate this in the last few minutes of the build, read it in 2 minutes, then present for about 5 minutes, followed by about 5 minutes of client questions.

## 1. The five slides (the talk follows the same order, about 5 minutes in all)
Rough timing: problem 30s, solution 30s, what I built and the demo 2.5 min, next steps 1 min, thank you 15s.

Every app uses the same five sections, and every slide shows its section label (in bold below) at the top, exactly as written.

1. **The problem.** The client's pain as the headline, plus the cost of doing nothing (time, money, risk).
2. **Our solution.** One sentence: "A tool that [does X] so [user] can [outcome]", plus up to 3 benefits in business terms (faster, cheaper, more consistent). One benefit is a simple illustrative calculation, worded as an example (such as "for example, 50 people × 10 minutes a day = about 40 hours a week").
3. **What I built.** The cue to switch to the live demo. Up to 3 bullets on what works today, plus a diagram of how this app works (see "The diagram" below).
4. **Next steps.** One honest limitation, then what production would take (for example data, security, evaluation, cost controls), and the ask: a 2 to 4 week pilot.
5. **Thank you.** "Thank you", the one-sentence value line again, and "Questions?".

## 2. Truthfulness rules
- Claim only what exists in the code. Anything else is a next step.
- Never leave blanks or placeholders for me to fill in. Use a concrete, plausible example client and scenario, phrased as an example ("for a team handling around 200 emails a day"), never as a measured result.
- No technical detail on the slides apart from the diagram. I'll explain it if they ask.
- Make a claim about Mistral itself (its products, hosting or policies) only if you're sure it's true. Otherwise, leave it out.

## The diagram
- Draw this app's actual mechanism, worked out from the code: the real steps the data goes through, from input to result. Never use a generic flow such as "User → App → Mistral → Answer", and don't reuse a flow from another app.
- Name the Mistral models and API features the code really uses (read them from the code).
- Make the step that makes this app different from a plain chatbot visible.
- At most 5 boxes, with plain labels a client can follow.

## 3. docs/PITCH.md: about 2 minutes to read
Under 250 words, in exactly this shape:
- **One-liner:** the sentence to memorise.
- **Opening question:** one question to ask the client first.
- **Per slide:** 1 to 2 lines to say.
- **Demo:** 3 steps that fit in about 2 minutes, saying what to click or type. Include a ready-to-paste example input in a code block. If the code handles a failure safely (for example it says when it can't answer, or rejects bad input clearly), add a fourth step that shows it, with its own ready-to-paste input. That builds trust.
- **Likely questions:** 3 to 4, each with a one-line answer. Always cover:
  - **Data privacy:** answer with the deployment choices: what the app does today, and what's possible for more control. Only accurate claims.
  - **Accuracy:** how this app limits mistakes, and how a pilot would measure them.
  - **Why Mistral:** the specific models this app uses, and why they fit this job.
  - Add cost or scale if relevant.
- **Close:** the ask, in one line.

Example of the shape (for a ticket triage app):

```markdown
**One-liner:** TriageAI reads each support email and tells your team its category, urgency and a draft reply, in seconds.
**Opening question:** "How long does your team spend sorting the inbox each morning?"

1. **Problem:** A team handling around 200 emails a day spends hours just sorting them, and urgent ones wait.
2. **Solution:** Every email is sorted and drafted the moment it arrives, so people only review and send.
3. **What I built:** Let me show you. *(switch to the app)*
4. **Next steps:** Today it handles one email at a time. A 2-week pilot on real inbox data would prove the accuracy.
5. **Thank you:** Faster replies, with the urgent emails first.

**Demo:**
1. Paste the email below and click **Triage**.
2. Point out the urgency ("High") and the reason it gives.
3. Show the draft reply: "a human approves it before it's sent".
4. Paste the second email to show it flags an unclear email instead of guessing.

    Hi, I was charged twice for my order #4821 and need a refund today.

    Hello?

**Likely questions:**
- *Is our data safe?* Today it calls Mistral's API. For full control, Mistral's open-weight models can run on your own infrastructure.
- *How accurate is it?* It returns a fixed set of categories that the code checks, and a person approves every reply. The pilot measures accuracy on your real emails.
- *Why Mistral?* It uses a small Mistral model, which is fast and low-cost for short emails, from a European provider.

**Close:** "Can we start a 2-week pilot with your inbox next month?"
```

## 4. docs/slides.html
- Exactly 5 slides. A headline plus at most 3 short bullets each. No paragraphs, no code.
- Every slide has the same layout:
  - **Top:** the section label in the accent colour, uppercase, about 24px (for example "THE PROBLEM").
  - **Middle:** the headline and the bullets.
  - **Bottom:** the app name on the left, and a progress strip on the right (Problem · Solution · What I built · Next steps), with the current section highlighted.
- "What I built" always has the diagram, on the right of the bullets.
- One self-contained file. No build step, no framework, and inline CSS.
- Load only Mermaid, from a CDN with a pinned, exact version. Under the diagram, add a plain-text version of the flow (with the class `fallback`) in case it doesn't render, and hide it once the diagram has rendered: `.diagram:has(svg) .fallback { display: none; }`.
- Hide inactive slides with `visibility: hidden` and absolute positioning, not `display: none`, because Mermaid can't draw diagrams inside a `display: none` element.
- Each slide fills the 16:9 viewport, one at a time. Arrow keys and the space bar move between slides. Show a slide counter.
- Style for screen sharing: large text (headlines about 48px or more, bullets about 28px or more), high contrast, a light neutral background and one accent colour.

## 5. Before you finish
- Check every claim against the code, including each box in the diagram and each model name.
- Make sure the Mermaid syntax is simple and valid.
- Tell me: `open docs/slides.html`, then press Cmd+Ctrl+F for full screen.

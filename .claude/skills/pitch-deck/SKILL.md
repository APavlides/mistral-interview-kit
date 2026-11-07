---
name: pitch-deck
description: Turn a finished app into a client pitch, written as a short talk track (docs/PITCH.md) plus a 5-slide self-contained HTML deck (docs/slides.html), for a non-technical decision maker. Use when asked for a pitch, demo script, presentation, slides or deck, or when preparing a client demo or role-play.
---

# Pitch deck

CLAUDE.md takes precedence. Inputs: `docs/BRIEF.md`, `docs/PRD.md` and the code. If `docs/` is missing, use the code and what we did in this session. Work fast: I generate this in the last few minutes of the build, read it in 2 minutes, then present for about 5 minutes, followed by about 5 minutes of client questions.

## 1. The five slides (the talk follows the same order, about 5 minutes in all)
Rough timing: problem 30s, solution 30s, what I built and the demo 2.5 min, next steps 1 min, thank you 15s.

1. **The problem.** The app's name as a small label, then the client's pain as the headline, plus the cost of doing nothing (time, money, risk).
2. **The solution.** One sentence: "A tool that [does X] so [user] can [outcome]", plus up to 3 benefits in business terms (faster, cheaper, more consistent).
3. **What I built.** The cue to switch to the live demo. Up to 3 bullets on what works today, plus a diagram of at most 5 boxes (for example User → App → API → Mistral → back).
4. **Next steps.** One honest limitation, then what production would take (for example data, security, evaluation, cost controls), and the ask: a 2 to 4 week pilot.
5. **Thank you.** "Thank you", the one-sentence value line again, and "Questions?".

## 2. Truthfulness rules
- Claim only what exists in the code. Anything else is a next step.
- Never leave blanks or placeholders for me to fill in. Use a concrete, plausible example client and scenario, phrased as an example ("for a team handling around 200 emails a day"), never as a measured result.
- No technical detail on the slides. I'll explain it if they ask.

## 3. docs/PITCH.md: about 2 minutes to read
Under 250 words, in exactly this shape:
- **One-liner:** the sentence to memorise.
- **Opening question:** one question to ask the client first.
- **Per slide:** 1 to 2 lines to say.
- **Demo:** 3 steps that fit in about 2 minutes, saying what to click or type. Include a ready-to-paste example input in a code block.
- **Likely questions:** 3 to 4, each with a one-line answer. Always cover data privacy, accuracy, and why Mistral; add cost or scale if relevant.
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

    Hi, I was charged twice for my order #4821 and need a refund today.

**Likely questions:**
- *Is our data safe?* The data goes only to Mistral's API, and it can be self-hosted for full control.
- *How accurate is it?* The pilot measures it on your real emails, and a person always approves the reply.
- *Why Mistral?* Strong models, EU-based, with open-weight options you can run yourself.

**Close:** "Can we start a 2-week pilot with your inbox next month?"
```

## 4. docs/slides.html
- Exactly 5 slides. A headline plus at most 3 short bullets each. No paragraphs, no code.
- One self-contained file. No build step, no framework, and inline CSS.
- Load only Mermaid, from a CDN with a pinned, exact version. Under the diagram, add a plain-text version of the flow in case it doesn't render.
- Each slide fills the 16:9 viewport, one at a time. Arrow keys and the space bar move between slides. Show a slide counter.
- Style for screen sharing: large text (headlines about 48px or more, bullets about 28px or more), high contrast, a light neutral background and one accent colour.

## 5. Before you finish
- Check every claim against the code.
- Make sure the Mermaid syntax is simple and valid.
- Tell me: `open docs/slides.html`, then press Cmd+Ctrl+F for full screen.

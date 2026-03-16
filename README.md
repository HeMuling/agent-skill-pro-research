# agent-skill-pro-research

This repository stores the Codex skill implementation named `pro-research`.

- Skill name: `pro-research` (from `SKILL.md`)
- Repository name: `agent-skill-pro-research`
- This skill uses the external engine package `@steipete/oracle`.
- The Oracle CLI implementation and its native Codex skill are maintained at:
  - `https://github.com/steipete/oracle/tree/main/skills/oracle`

## Installation

Use this skill in your local Codex setup by pointing to the skill directory under this repository:

- `SKILL.md`: `pro-research` skill definition and execution flow.
- `scripts/run_pro_research.sh`: helper script for login, preview, and browser-run.
- `agents/` and `references/`: supporting files used by the workflow.

## Workflow logic

```text
┌──────────────────────────────────────────────────────┐
│                      TRIGGER                         │
│   Complex problem, second opinion, cross-file        │
│   diagnosis, or research synthesis                   │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│                       ROUTE                          │
│   Use pro-research when the main need is judgment,   │
│   not direct execution                               │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│             FRAME + COLLECT EVIDENCE                 │
│   Define the question, the decision to unblock,      │
│   and the smallest useful bundle                     │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│             PREVIEW + TIGHTEN SCOPE                  │
│   Check the bundle before running and remove noise   │
│   or missing context                                 │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│                  ORACLE ANALYSIS                     │
│   Run browser-backed research on the approved        │
│   materials                                          │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│                   RESULT GATE                        │
│   Wait for the full result before making             │
│   downstream decisions                               │
└──────────────────────────┬───────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────┐
│                     HANDOFF                          │
│   Turn the result into the next workflow: fix,       │
│   validate, write, plan, or run a narrower pass      │
└──────────────────────────────────────────────────────┘
```

## Contents
- `SKILL.md`
- `agents/openai.yaml`
- `scripts/run_pro_research.sh`
- `references/*`

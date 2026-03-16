# Context Selection

## Core Rules

- Prefer the smallest evidence bundle that still contains the truth.
- Send source material, not guesses about source material.
- Keep the bundle diagnosis-oriented or research-oriented, not bloated.
- Preview with `scripts/run_pro_research.sh preview ...` before any long Oracle run.

## Include First

Start with these whenever possible:

- `*.md`, `*.txt`, `*.rst`
- code files that directly constrain the question
- config files, schemas, interface definitions, and short logs
- research notes, paper extracts, experiment summaries, and result tables converted to text
- design docs, READMEs, ADRs, runbooks, and decision notes

For mixed engineering questions, include both the observed artifact and the implementation or config that governs it.

For scientific research questions, include both the evidence artifact and the theory, paper extract, note, or implementation that is being compared against it.

## Exclude or Convert

Do not send these through the wrapper as raw inputs:

- PDFs, slide decks, screenshots, and images
- Office binaries such as `.docx`, `.pptx`, `.xlsx`
- archives, media files, and other binary-heavy assets
- secrets such as `.env`, keys, tokens, credentials, and auth dumps
- large unrelated directories such as build outputs, vendor caches, and dependency trees

Convert non-text artifacts into local text notes first. Extract the relevant pages, results, captions, or observations, then send those derived text files to Oracle.

## Bundle Patterns

Use this pattern for hard engineering diagnosis:

1. symptom or notes
2. minimal implementation files
3. governing config
4. one or two logs or docs

Use this pattern for scientific research:

1. research question or planning note
2. paper extracts or reading notes
3. experiment summaries or result notes
4. local code or config only if it affects interpretation

## Session Reuse

- Oracle browser runs can take a long time and may detach.
- Reattach with `oracle status --hours 72` and `oracle session <id>`.
- Do not create a duplicate run for the same prompt unless the user explicitly wants a fresh pass.

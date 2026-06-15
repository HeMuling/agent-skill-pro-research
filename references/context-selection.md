# Context Selection

## Core Rules

- Prefer the most complete topic-bounded package that still stays relevant.
- Send source material, not guesses about source material.
- Keep the bundle diagnosis-oriented or research-oriented, but use relevance rather than brevity as the boundary.
- Default to near-full inlining for clearly relevant, text-like materials.

## Include First

Start with these whenever possible:

- `*.md`, `*.txt`, `*.rst`
- code files that directly constrain the question
- config files, schemas, interface definitions, and short logs
- research notes, paper extracts, experiment summaries, and result tables converted to text
- design docs, READMEs, ADRs, runbooks, and decision notes
- issue threads, review notes, meeting notes, and timelines when they explain why something changed
- architecture or system overviews
- onboarding docs, glossaries, notation guides, metric definitions, and methodology notes
- related implementation files that explain how the primary evidence should be interpreted
- historical change notes, baseline docs, and prior-state references

For mixed engineering questions, include both the observed artifact and the implementation or config that governs it.

For scientific research questions, include both the evidence artifact and the theory, paper extract, note, or implementation that is being compared against it.

If two relevant documents add distinct explanatory value, prefer including both instead of collapsing prematurely to one.

## Exclude or Convert

Do not include these as raw inputs:

- PDFs, slide decks, screenshots, and images
- Office binaries such as `.docx`, `.pptx`, `.xlsx`
- archives, media files, and other binary-heavy assets
- secrets such as `.env`, keys, tokens, credentials, and auth dumps
- large unrelated directories such as build outputs, vendor caches, and dependency trees

Convert non-text artifacts into local text notes first. Extract the relevant pages, results, captions, or observations, then inline that derived text in `research-context.md`.

## Bundle Patterns

Use this pattern for hard engineering diagnosis:

1. symptom or notes
2. implementation files that govern the behavior
3. governing config
4. logs and outputs
5. design docs, ADRs, or architecture notes
6. recent change history, decision notes, or baseline context

Use this pattern for scientific research:

1. research question or planning note
2. paper extracts or reading notes
3. experiment summaries or result notes
4. local code or config if it affects interpretation
5. related work notes, terminology, or method background
6. prior framing, baseline assumptions, or historical context

## Inlining Rules

- Separate authored synthesis from source embedding:
  - analytical synthesis may be written manually
  - embedded source material must be inserted from files on disk with shell commands
- Inline the full contents of relevant text files when they are reasonably bounded and clearly useful.
- Treat background and supporting documents as first-class sources, not optional extras.
- For very long sources, inline the relevant full sections in original order with `sed -n` or `awk`, and add an omission note written via shell.
- Add a source heading above every inlined block with:
  - path
  - type
  - role
  - why it matters
- Write those source headings and omission notes with `printf`.
- For bounded full-file inclusion, prefer `cat`.
- Do not manually paste or retype source-file content into `Inlined Source Materials`.
- Preserve enough surrounding context so a downstream reader can interpret the excerpt independently.
- If two files are nearly redundant, keep the more primary source and note the overlap in `Materials Map`; otherwise include both when they contribute distinct context.
- If a PDF, slide, spreadsheet, or screenshot is converted into a text note, that derived text file becomes the source that must be inserted via shell.
- Only omit materials that are clearly redundant, clearly unrelated, or unsafe to include.

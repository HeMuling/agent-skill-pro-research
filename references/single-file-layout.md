# Single File Layout

This skill always produces one file named `research-context.md`.

## Required Section Order

1. `Task Purpose`
2. `Materials Map`
3. `Current Context`
4. `Timeline`
5. `Observed Facts`
6. `Comparisons and Tensions`
7. `Hypotheses or Interpretive Angles`
8. `Open Questions`
9. `Missing Materials`
10. `Inlined Source Materials`
11. `Appendix` when needed

Do not reorder these sections. The reader should see framing first, then orientation and evidence structure, then interpretation, then the inlined materials.

## Section Rules

### Task Purpose

Must state:

- goal
- core question
- decision to unblock
- scope limits
- fixed constraints

### Materials Map

List every included source with:

- path
- type
- role
- why it matters
- priority

Useful role labels include:

- core evidence
- background reference
- historical context
- decision record
- method note
- supporting documentation

### Current Context

Use this as a rich orientation section. Include the background, prior state, terminology, assumptions, relevant history, and why the current question matters.

### Timeline

Reconstruct the relevant sequence of events. If the sequence is unclear, say so directly instead of inventing one.

### Observed Facts

Only include statements that can be tied directly to the materials. If a sentence is interpretive, move it later.

### Comparisons and Tensions

Use this for:

- expected versus actual
- source A versus source B
- old version versus new version
- paper claim versus local result
- note versus implementation

### Hypotheses or Interpretive Angles

This section is explicitly interpretive. Label competing explanations clearly and keep support and contradiction visible.

### Open Questions

List unresolved questions that matter for the task.

### Missing Materials

List the highest-value missing evidence or background documents first. Prefer concrete items over generic wishes.

### Inlined Source Materials

Paste the task-relevant materials directly into the file. Include both direct evidence and supporting/background materials that a downstream reader would otherwise need to retrieve separately. Every block needs a source heading like:

```text
### Source: /abs/path/to/file
Type: log
Role: runtime evidence
Why it matters: shows the first failing event after the config change
```

Then inline the content.

Implementation rule:

- Write the source heading with `printf`.
- Append full bounded files with `cat file >> research-context.md`.
- Append relevant ranges from long files with `sed -n 'start,endp' file >> research-context.md` or an equivalent `awk` command.
- Write omission notes with `printf` before or between appended ranges.
- Do not manually copy or retype original source text in this section.

Recommended internal grouping inside this section:

- `### Core Evidence`
- `### Background and Supporting Documentation`
- `### Historical and Decision Context`

If a file is very long:

- bias toward fuller inclusion when the material is relevant
- inline the relevant full sections in original order
- add a short omission note where content was skipped
- do not rewrite the source into prose if the original wording matters

### Appendix

Use `Appendix` for overflow background that is still relevant, such as glossary material, parameter definitions, schemas, notation guides, extra supporting documents, or long background notes that would otherwise swamp the main body.

## Command Pattern

Use shell commands directly when assembling `Inlined Source Materials`. A canonical pattern is:

```sh
printf '\n### Source: %s\nType: %s\nRole: %s\nWhy it matters: %s\n\n' \
  "/abs/path/to/file" "log" "runtime evidence" "shows the first failing event" >> research-context.md
cat /abs/path/to/file >> research-context.md
printf '\n' >> research-context.md
```

For partial inclusion from a long file:

```sh
printf '\n### Source: %s\nType: %s\nRole: %s\nWhy it matters: %s\n\n' \
  "/abs/path/to/file" "notes" "theory reference" "contains the relevant derivation section" >> research-context.md
sed -n '120,220p' /abs/path/to/file >> research-context.md
printf '\n[omitted unrelated sections]\n' >> research-context.md
sed -n '310,360p' /abs/path/to/file >> research-context.md
printf '\n' >> research-context.md
```

Analytical sections elsewhere in `research-context.md` may be written manually. This shell-command rule applies specifically to embedded source-material content.

## Minimal Skeleton

```markdown
# research-context

## Task Purpose
...

## Materials Map
...

## Current Context
...

## Timeline
...

## Observed Facts
...

## Comparisons and Tensions
...

## Hypotheses or Interpretive Angles
...

## Open Questions
...

## Missing Materials
...

## Inlined Source Materials
...

## Appendix
...
```

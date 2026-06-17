---
name: ask-pro-model
description: |
  Manual-only. Use only when the user explicitly mentions `$ask-pro-model` or provides the skill path and asks to compile a rich evidence package for a difficult, evidence-heavy task, then consult ChatGPT Pro through Safari with Computer Use. It prepares a timestamped run directory with `research-context.md`, `pro-prompt.md`, and `pro-response.md`, and waits for the Pro model to finish instead of timing out. Typical uses include complex engineering diagnosis, literature synthesis, experiment anomaly review, theory checks, contribution planning, or second-opinion discussion.
  Not for: implicit invocation, direct patching, routine bug fixes, ordinary PR reviews, academic prose polishing, narrow citation-only checks, or API/Oracle/Playwright model runs.
---

# Ask Pro Model

Use this skill to turn scattered relevant materials into a high-signal research package, ask ChatGPT Pro through Safari for a second opinion, and save the final answer back to disk. The package should give the Pro model enough context to reason from original materials without hunting across many files, and should bias toward topic-bounded completeness rather than aggressive pruning.

Invoke this skill only on explicit request. Do not use it from task-shape inference alone.

## Decision Rule

- Use this skill when the main need is to clarify what the materials say, what is confirmed, what remains interpretive, and what ChatGPT Pro thinks after seeing the packaged evidence.
- Use it when the user wants a durable non-project run directory containing the evidence package, exact prompt, Pro response, and any run notes.
- Move to a dedicated implementation-and-fix workflow when the problem is already scoped and the next step is to change code and prove the repair with tests.
- Move to a dedicated academic prose polishing workflow when the main task is rewriting prose rather than preparing evidence.

## Workflow

1. Create a non-project run directory.
   Use `${CODEX_HOME:-$HOME/.codex}/ask-pro-model/<timestamp>-<slug>/`, where `<timestamp>` is sortable local time and `<slug>` is a short sanitized task label. Do not write the primary outputs into the project worktree.

2. Define the task before gathering details.
   Identify the goal, the exact question, the decision to unblock, the scope limits, and the fixed constraints.

3. Build a topic-bounded evidence and background set.
   Gather the materials that contain the truth about the question and the background needed to interpret it: notes, logs, code, configs, paper extracts, experiment summaries, meeting notes, ADRs, design docs, decision records, schemas, terminology notes, method notes, and relevant historical context.

4. Convert non-text artifacts before use.
   Extract relevant text from PDFs, slides, spreadsheets, screenshots, and other binaries, then treat the converted text as the source material to inline.

5. Prefer topic-bounded completeness over minimality.
   Do not stop at the smallest bundle that still contains the truth. If a text-like file adds distinct explanatory value within the same topic boundary, include it. If it is very long, inline the relevant full sections in original order and mark where content was omitted.

6. Read the right references before writing.
   Start with:
   - `references/single-file-layout.md`
   - `references/problem-framing.md`
   - `references/context-selection.md`
   - `references/chatgpt-pro-safari.md`

   Then load the task-specific reference that matches the job:
   - `references/second-opinion-brief.md`
   - `references/root-cause-hypotheses.md`
   - `references/literature-synthesis.md`
   - `references/experiment-anomaly-diagnosis.md`
   - `references/argument-and-contribution-planning.md`
   - `references/theory-derivation-check.md`

7. Compose the single file in fixed order.
   Write `research-context.md` in the run directory. Follow the required section order exactly so the reader sees task framing before evidence details.

8. Write analysis sections separately from source insertion.
   Analytical sections such as `Task Purpose`, `Current Context`, `Observed Facts`, `Comparisons and Tensions`, `Open Questions`, and `Missing Materials` may be authored manually. `Inlined Source Materials` must be built from files on disk with shell commands, not manual paste.

9. Keep facts and interpretation separate.
   `Observed Facts` must contain only claims grounded directly in the materials. Put explanations, hypotheses, and judgments later under clearly labeled interpretive sections.

10. Inline sources with shell commands and path labels.
   Use `printf` for source headings and omission notes, `cat` for full-file insertion, and `sed -n` or `awk` for partial insertion from long files. Append all source text to `research-context.md` with shell redirection rather than retyping it manually.

11. Write `pro-prompt.md`.
   Include the exact instruction to ChatGPT Pro: the deliverable requested, the core question, the reasoning style expected, the constraints, and how to use the attached or pasted `research-context.md`. Make clear that the Pro response is advisory and should cite evidence from the package.

12. Confirm before transmission when required.
   Sending the package to ChatGPT is third-party data transmission. If the user's current request did not explicitly approve sending this specific package to ChatGPT Pro, ask for action-time confirmation before uploading or pasting any content.

13. Use Safari and Computer Use for ChatGPT Pro.
   Follow `references/chatgpt-pro-safari.md`. Do not use Oracle, Playwright, browser API automation, or model API mode. Prefer uploading `research-context.md` and pasting `pro-prompt.md`; if upload is unavailable, paste combined content only if the UI accepts it.

14. Confirm ChatGPT Pro has started processing, then wait until it finishes.
   After submitting, inspect the UI before any long sleep. Enter the waiting loop only after there is a clear progress signal: the submitted message appears in the conversation, the input is disabled or replaced by a stop control, ChatGPT shows a thinking/reasoning/progress indicator, or response text has started streaming. If the message remains only in the composer, upload is still pending, no assistant turn appears, or there is no clear indication that the Pro model started thinking, do not run `scripts/wait_for_pro_response.sh`; record the observation in `run-notes.md` and ask the user before retrying, resubmitting, or changing approach. Once the progress signal is visible, do not interrupt, restart, or abandon the run because it is slow. Run `scripts/wait_for_pro_response.sh` between checks and continue until completion.

15. Save the final response.
   Copy the completed ChatGPT Pro answer into `pro-response.md`. If login, model selection, upload, or waiting issues occurred, write concise notes to `run-notes.md`.

16. End with uncertainty, not false closure.
   Make missing materials, open questions, and unsupported claims explicit instead of smoothing them over.

## Output Contract

Produce one run directory under `${CODEX_HOME:-$HOME/.codex}/ask-pro-model/`.

Required files:

1. `research-context.md`
2. `pro-prompt.md`
3. `pro-response.md`

Optional file:

- `run-notes.md` for login, model-selection, upload, waiting, or error notes.

`research-context.md` required section order:

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

Section rules:

- `Task Purpose`: state the goal, core question, decision to unblock, scope limits, and fixed constraints.
- `Materials Map`: list every included source with path, type, role, relevance, and priority. Distinguish core evidence from background reference, historical context, decision record, method note, or supporting documentation when useful.
- `Current Context`: provide rich orientation for the reader, including current state, prior state, terminology, assumptions, relevant history, why the question matters, and what has already been tried.
- `Timeline`: reconstruct the relevant sequence of events; if unknown, state that directly.
- `Observed Facts`: include only statements supported by the source materials.
- `Comparisons and Tensions`: capture expected versus actual behavior, conflicts between sources, and other meaningful contrasts.
- `Hypotheses or Interpretive Angles`: include interpretation only, clearly labeled as interpretation.
- `Open Questions`: state what remains unresolved.
- `Missing Materials`: identify the highest-value missing evidence or background materials that would materially improve interpretation.
- `Inlined Source Materials`: write source headings and omission notes with shell commands, then append the source text from files on disk with `cat`, `sed -n`, or `awk`. Include both direct evidence and supporting/background documentation that a downstream reader would otherwise need to retrieve separately. Do not manually copy or retype original source text in this section.
- `Appendix`: use for overflow background, glossary material, parameter definitions, or additional supporting documents that remain relevant but would make the main body unwieldy.

`pro-prompt.md` rules:

- State the requested Pro deliverable first.
- State the core question and decision to unblock.
- Tell ChatGPT Pro to reason from the attached or pasted `research-context.md`.
- Ask for evidence-grounded judgment, uncertainty, competing explanations, and next checks when relevant.
- Do not include secrets or unrelated background.

`pro-response.md` rules:

- Save the final ChatGPT Pro response verbatim or as close as the UI allows.
- Add only a short heading with the run timestamp and model label if visible.
- Do not rewrite the Pro response while saving it.

## Safety

- Do not inline secrets, credentials, tokens, keys, or unrelated large directories.
- Do not inline raw binary-heavy artifacts. Convert them to text first.
- Do not manually paste original source-file contents into `Inlined Source Materials`.
- Do not treat interpretations as facts just because they sound plausible.
- Before transmission, scan selected materials and `research-context.md` for obvious sensitive paths or content such as `.env`, keys, tokens, credentials, auth dumps, and unrelated private data.
- Treat uploading or pasting package contents into ChatGPT as third-party transmission. Confirm at action time unless the user explicitly approved sending that specific package to ChatGPT Pro in the current request.
- If Safari shows login, password, 2FA, CAPTCHA, security challenge, or account recovery, hand off to the user.
- If ChatGPT shows an error, expired login, unavailable model, upload failure, or a stuck non-progressing state, record it in `run-notes.md` and ask the user instead of silently changing provider or model.

## Resources

- `references/single-file-layout.md`: Required structure and section behavior for `research-context.md`.
- `references/problem-framing.md`: Define the goal, question, decision boundary, and constraints.
- `references/context-selection.md`: Decide what to include, exclude, convert, and inline.
- `references/chatgpt-pro-safari.md`: Use Safari and Computer Use to submit the package to ChatGPT Pro, wait, and save the response.
- `references/second-opinion-brief.md`: Package evidence for a judgment-oriented review.
- `references/root-cause-hypotheses.md`: Compare competing explanations without collapsing them into one story too early.
- `references/literature-synthesis.md`: Extract and compare claims, methods, assumptions, and gaps across research materials.
- `references/experiment-anomaly-diagnosis.md`: Structure contradictory or surprising results.
- `references/argument-and-contribution-planning.md`: Surface the main claim, support, weaknesses, and missing evidence.
- `references/theory-derivation-check.md`: Mark valid steps, hidden assumptions, and unsupported jumps.
- `scripts/wait_for_pro_response.sh`: Sleep once between ChatGPT Pro status checks without imposing a maximum wait.

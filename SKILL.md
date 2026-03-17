---
name: pro-research
description: |
  A research and technical reasoning skill for difficult, ambiguous problems: use when evidence is sparse, conflicting, or distributed across sources, and the goal is to build a rigorous problem model, propose explanatory hypotheses, and design solution paths with theory-grounded reasoning before changing code. It is designed for complex synthesis, derivation-style analysis, and validation of inference chains across code, logs, docs, configs, tests, metrics, and experimental notes, with an explicit technical route-to-solution outcome.
  Not for: direct patching, routine bug fixes, ordinary PR reviews, browser automation, academic prose polishing, or narrow citation-only checks.
---

# Pro Research

Use Oracle as a browser-first second-model pass for high-ambiguity engineering diagnosis and scientific research reasoning. Treat Oracle output as advisory, evidence-bound analysis rather than ground truth.

## Decision Rule

- Use this skill when the main need is to understand what is happening, what the evidence supports, which hypotheses remain plausible, and what to investigate next.
- Move to a dedicated implementation-and-fix workflow when the problem is already scoped and the next step is to implement a repair and prove it with tests.
- Move to a dedicated academic prose polishing workflow when the main task is to rewrite or refine existing scholarly text.
- Move to a dedicated citation-placement workflow when the task is narrow citation placement, footnote audit, or reference span checking.

## Browser Readiness

- Before the first browser run on a machine, or whenever ChatGPT login state is unknown, run:

  ```bash
  scripts/run_pro_research.sh login
  ```

- Complete the ChatGPT sign-in flow in the opened browser window before starting any real Oracle work.
- The login bootstrap is intended to be one-time per machine/profile. Later `run` calls should reuse the same persistent automation profile and the same DevTools port instead of asking you to sign in again.
- If a browser run fails with missing cookies, login button detection, or ChatGPT session errors, rerun `scripts/run_pro_research.sh login` and only then continue.

## Workflow

1. Confirm that the task justifies escalation.
   Reach for this skill when one pass of investigation still leaves multiple plausible explanations, or when the answer depends on comparing several evidence sources together.

2. Ensure browser login is ready.
   If ChatGPT login state is unknown, bootstrap it with `scripts/run_pro_research.sh login` before spending time on prompt assembly.

3. Pick a concrete deliverable before gathering files.
   Good outputs include a diagnosis memo, second-opinion brief, literature synthesis, anomaly explanation, research-gap summary, theory-check note, or next-steps plan.

4. Build the smallest evidence package that still contains the truth.
   Prefer Markdown, text, logs, code, config, and notes with enough context and background. Include rich, task-relevant description to preserve reasoning continuity while still pruning noise. A useful target is to let relevant context dominate around 70%–90% of the payload where practical.
   Convert PDFs, slides, spreadsheets, images, and web captures into text before using the wrapper.

5. Bias for context completeness within a focused boundary.
   When in doubt, add more related content and background that directly explains what happened, what changed, and why it matters, as long as it stays within the evidence scope and remains relevant to the chosen deliverable.

6. Load the right reference before writing the prompt.
   Read only the file that matches the task:
   - `references/problem-framing.md`
   - `references/second-opinion-brief.md`
   - `references/root-cause-hypotheses.md`
   - `references/literature-synthesis.md`
   - `references/experiment-anomaly-diagnosis.md`
   - `references/argument-and-contribution-planning.md`
   - `references/theory-derivation-check.md`
   - `references/context-selection.md`

7. Preview the bundle before starting a long Oracle run.
   Run:

   ```bash
   scripts/run_pro_research.sh preview "<task>" <paths...>
   ```

   Remove noisy files until the bundle is focused and the file report looks sane.

8. Start the browser run only after the preview looks clean.
   Run:

   ```bash
   scripts/run_pro_research.sh run "<task>" <paths...>
   ```

   The wrapper defaults to `npx -y @steipete/oracle --engine browser --browser-manual-login --browser-port 9333 --browser-reuse-wait 10s --browser-profile-lock-timeout 300s --model gpt-5.4-pro`.

9. Reattach instead of rerunning.
   Long Oracle sessions often detach. Use:

   ```bash
   oracle status --hours 72
   oracle session <id>
   ```

   Do not create duplicate runs for the same prompt unless the user explicitly wants a fresh pass.

10. Enforce research-result gating.
   Any subsequent step that depends on Oracle/pro-research output is blocked until the run is finished and the full result is received. Do not infer, decide, or execute follow-up actions that consume the missing result.

11. Use waiting time productively.
   While waiting, continue task-relevant local work only (e.g., deeper local evidence reading, scenario framing, non-pro-research reasoning, alternative hypothesis generation tied to the target problem), and keep all output clearly separated from pro-research-dependent decisions.

12. Keep the session alive during wait.
   Do not end the session or mark the task complete solely because pro-research is still running. Return concise status updates and explicit pending actions, then wait for the Oracle result before moving on.

13. Strict idle-wait mode.
   Do not question or test the pro-research run status repeatedly. The default wait is for result completion. Task-related investigation is allowed, but is not a substitute for the awaited pro-research output. If there is genuine suspicion that the run is not progressing, perform one status validation check only, then return to waiting.

## Prompt Contract

- State the deliverable first.
- Name every attached path and its role.
- Spell out the main question, constraints, and what has already been tried.
- For engineering diagnosis, ask for competing hypotheses, evidence, confidence, and next steps.
- For scientific research, ask for evidence, uncertainty, open questions, limitations, and where the current materials stop supporting the claim.

## Safety

- Keep API mode opt-in only. Do not switch to `--engine api` unless the user explicitly approves spend.
- Do not send secrets, credentials, or unrelated large directories.
- Do not send raw binary-heavy artifacts through the wrapper. Convert them to text first.
- Treat Oracle as a second opinion and verify important claims locally.

## Resources

- `scripts/run_pro_research.sh`: Login bootstrap, preview, and browser-run wrapper with slugging and safety guards.
- `references/problem-framing.md`: Define the question, deliverable, and decision boundary.
- `references/second-opinion-brief.md`: Ask for a structured second opinion with evidence and uncertainty.
- `references/root-cause-hypotheses.md`: Compare competing explanations for a hard problem.
- `references/literature-synthesis.md`: Synthesize papers, notes, and competing methods.
- `references/experiment-anomaly-diagnosis.md`: Diagnose contradictory or abnormal results.
- `references/argument-and-contribution-planning.md`: Pressure-test research framing, contribution claims, and next steps.
- `references/theory-derivation-check.md`: Check whether a derivation or interpretation is actually supported.
- `references/context-selection.md`: Choose the smallest mixed evidence bundle that still contains the truth.

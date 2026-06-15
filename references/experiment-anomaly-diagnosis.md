# Experiment Anomaly Diagnosis

Use this when results are contradictory, unstable, unexpectedly weak, or do not match the theory or paper claim. The goal is to make the anomaly legible inside `research-context.md` without prematurely picking a winner.

## What To Pull Into The File

- In `Current Context`: the experiment setup, baseline behavior, system or method background, and why the anomaly matters.
- In `Timeline`: sequence of runs, changes, observations, and relevant prior-state history.
- In `Observed Facts`: exact results, settings, and contradictions that are directly supported by notes or outputs.
- In `Comparisons and Tensions`: expected versus actual behavior, baseline versus new result, paper claim versus local result.
- In `Hypotheses or Interpretive Angles`: plausible causes, clearly labeled as hypotheses.
- In `Missing Materials`: missing controls, missing logs, or missing measurements.

## Anomaly Checklist

- observed anomaly
- expected behavior
- strongest evidence the anomaly is real
- strongest evidence it might be an artifact
- confounders
- highest-value next check
- background docs or historical notes required to interpret the anomaly correctly

Inline the exact result tables, metric summaries, settings, baseline docs, and relevant implementation or config history that the reader would otherwise need to retrieve separately.

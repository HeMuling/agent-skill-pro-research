# Experiment Anomaly Diagnosis

Use this when results are contradictory, unstable, unexpectedly weak, or do not match the theory or paper claim.

## Prompt Skeleton

```text
Task type: experiment-anomaly-diagnosis
Deliverable: anomaly analysis

Observed anomaly:
<what result is surprising or inconsistent>

Expected behavior:
<what was supposed to happen>

Materials map:
- <path>: experiment notes
- <path>: metrics or result summary
- <path>: implementation or config
- <path>: paper claim or theory note

Question:
Explain the most plausible reasons for the anomaly and propose the highest-value next checks.

Required output:
- Most plausible causes
- Evidence for and against each cause
- Confounders or missing controls
- What to verify next
- Which interpretations are not supported yet
```
